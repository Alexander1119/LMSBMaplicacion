import 'dart:io';

import 'package:http/http.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class MyViewModel extends ChangeNotifier {
  double _progress = 0;
  get downloadProgress => _progress;

  void startDownloading() async {
    var _progress = null;
    notifyListeners();

    final url =
        'https://firebasestorage.googleapis.com/v0/b/lmsbm-28298.appspot.com/o/content%2F1%2C1%2C2%2C2%2Csumayresta%2Cvideo.mp4?alt=media&token=85fddc11-20e9-4a4f-812a-0778cb544f5c';
    final request = Request('GET', Uri.parse(url));
    final StreamedResponse response = await Client().send(request);

    final contentLength = response.contentLength;
    // final contentLength = double.parse(response.headers['x-decompressed-content-length']);

    _progress = 0;
    notifyListeners();

    List<int> bytes = [];

    final file = await _getFile('song.mp3');
    response.stream.listen(
      (List<int> newBytes) {
        bytes.addAll(newBytes);
        final downloadedLength = bytes.length;
        _progress = downloadedLength / contentLength!;
        notifyListeners();
      },
      onDone: () async {
        _progress = 0;
        notifyListeners();
        await file.writeAsBytes(bytes);
      },
      onError: (e) {
        print(e);
      },
      cancelOnError: true,
    );
  }

  Future<File> _getFile(String filename) async {
    final dir = await getApplicationDocumentsDirectory();
    return File("${dir.path}/$filename");
  }
}
