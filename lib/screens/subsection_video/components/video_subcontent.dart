import 'package:applmsbm/constants.dart';
import 'package:applmsbm/model/subsection.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

import '../../../size_config.dart';

class VideoSubcontent extends StatefulWidget {
  Subsection subsection;

  VideoSubcontent({required this.subsection}) : super();

  @override
  State<VideoSubcontent> createState() => _VideoSubcontentState();
}

class _VideoSubcontentState extends State<VideoSubcontent> {
  int? idPerson;

  Future<int?> getid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    idPerson = await prefs.getInt('idPerson');
    print("el id encontrado es: " + idPerson.toString());
    return idPerson;
  }

  late VideoPlayerController _controller;
  bool _visible = true;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.subsection.pathFile)
      ..addListener(() => setState(() {
            videoPosition = _controller.value.position;
          }))
      ..initialize().then((_) => setState(() {
            videoLength = _controller.value.duration;
          }));

    getid();
    _controller.setLooping(!_controller.value.isLooping);
  }

  late Duration videoLength;
  late Duration videoPosition;
  double volume = 0.5;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: <Widget>[
        if (_controller.value.isInitialized) ...[
          GestureDetector(
            onTap: () {
              setState(() {
                // Toggle light when tapped.
                _visible = !_visible;
              });
            },
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            ),
          ),
          Center(
              child: AnimatedOpacity(
            // Si el Widget debe ser visible, anime a 1.0 (completamente visible). Si
            // el Widget debe estar oculto, anime a 0.0 (invisible).
            opacity: _visible ? 1.0 : 0.0,
            duration: Duration(milliseconds: 500),
            child: Column(
              children: [
                VideoProgressIndicator(
                  _controller,
                  allowScrubbing: true,
                  padding: EdgeInsets.all(10),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(_controller.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow),
                        onPressed: () {
                          setState(() {
                            if (_visible) {
                              _controller.value.isPlaying
                                  ? _controller.pause()
                                  : _controller.play();
                            }
                          });
                        },
                      ),
                      Text(
                          '${convertToMinutesSeconds(videoPosition)} / ${convertToMinutesSeconds(videoLength)}'),
                      SizedBox(width: 5),
                      Icon(animatedVolumeIcon(volume)),
                      Slider(
                        value: volume,
                        min: 0,
                        max: 1,
                        onChanged: (_volume) => setState(() {
                          if (_visible) {
                            volume = _volume;
                            _controller.setVolume(_volume);
                          }
                        }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ))
        ],
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}

String convertToMinutesSeconds(Duration duration) {
  final parsedMinutes = duration.inMinutes < 10
      ? '0${duration.inMinutes}'
      : duration.inMinutes.toString();

  final seconds = duration.inSeconds % 60;

  final parsedSeconds =
      seconds < 10 ? '0${seconds % 60}' : (seconds % 60).toString();
  return '$parsedMinutes:$parsedSeconds';
}

IconData animatedVolumeIcon(double volume) {
  if (volume == 0)
    return Icons.volume_mute;
  else if (volume < 0.5)
    return Icons.volume_down;
  else
    return Icons.volume_up;
}
