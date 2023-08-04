class ExamPackageType{
  late int id;
  late int? examId;
  late int? submitted;
  late String name;



  ExamPackageType({
    required this.id,
    required this.name,
    this.examId,
    this.submitted,
  });



factory ExamPackageType.fromMap(Map<String, dynamic> json) => ExamPackageType(
  id: json['id'],
  examId: json['exam_id'],
  submitted: json['submitted'],
  name: json['name']
);
}


List<ExamPackageType> parseExamPackageList(List<dynamic> jsonStr) {
  return jsonStr.map((map) => ExamPackageType.fromMap(map)).toList();
}