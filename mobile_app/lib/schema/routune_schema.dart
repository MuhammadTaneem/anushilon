class RoutineType{
  late int? id;
  late int packageId;
  late int examNumber;
  late bool submitted;
  late bool resultPublished;
  late DateTime date;
  late int noOfQuestion;
  late String subjects;
  late String chapters;


  RoutineType({
    this.id,
    required this.packageId,
    required this.examNumber,
    required this.submitted,
    required this.resultPublished,
    required this.date,
    required this.noOfQuestion,
    required this.subjects,
    required this.chapters,
  });
}