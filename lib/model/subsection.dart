class Subsection {
  int idSubsection;
  String subsection;
  int idSection;
  int idTypeContent;
  String pathFile;
  int status;
  String description;
  int viewed;

  Subsection(
      {required this.idSubsection,
      required this.subsection,
      required this.idSection,
      required this.idTypeContent,
      required this.pathFile,
      required this.status,
      required this.description,
      required this.viewed});
}
