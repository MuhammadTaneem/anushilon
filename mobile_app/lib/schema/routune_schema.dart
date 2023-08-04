import 'dart:convert';

class RoutineType{
  late int id;
  late int packageId;
  late int duration;
  late int point;
  late double penalty;
  late String packageName;
  late int examNumber;
  late bool available;
  late DateTime date;
  late int noOfQuestion;
  late List<SubjectType> syllabus;




  RoutineType({
    required this.id,
    required this.packageId,
    required this.packageName,
    required this.duration,
    required this.examNumber,
    required this.point,
    required this.penalty,
    required this.available,
    required this.date,
    required this.noOfQuestion,
    required this.syllabus,
  });

  factory RoutineType.fromMap(Map<String, dynamic> map) {
    DateTime now = DateTime.now();
    var today =now.toIso8601String().split('T')[0];

    return RoutineType(
      id: map['id'],
      packageId: map['package'],
      packageName: map['package_name'],
      noOfQuestion: map['number_of_question'],
      examNumber: map['exam_number'],
      duration: map['duration'],
      point: map['point'],
      penalty: map['penalty'],
      date :DateTime.parse(map['exam_date']),
      available: map['exam_date'] == today? true:false,
      syllabus:parseSubjectList(map['syllabus']),
      // syllabus:[],
    );
  }

}

class SubjectType{
  late String subject;
  late String chapters;
  SubjectType({
    required this.subject,
    required this.chapters,
  });



}


List<SubjectType> parseSubjectList(String jsonStr) {

  List<SubjectType>subjectList=[];
  Map<String, dynamic> obj = jsonDecode(jsonStr);
  obj.forEach((key, value) {
    String subjectName = key.replaceAll("_", " ");
    String chapters='';
    value.forEach((key, value) {
      chapters.length<1?chapters+=' ${value}':chapters+=' ,${value}';
    });
    subjectList.add(SubjectType(subject: subjectName, chapters: chapters));
  });

  return subjectList;
}

List<RoutineType> parseRoutineList(List<dynamic> jsonStr) {
  return jsonStr.map((map) => RoutineType.fromMap(map)).toList();
}