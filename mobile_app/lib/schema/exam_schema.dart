import 'package:mobile_app/schema/mcq_schema.dart';
import 'package:mobile_app/schema/routune_schema.dart';

class ExamType{
  late int id;
  late RoutineType exam;
  late List<McqType> mcqList;

  ExamType({
    required this.id,
    required this.exam,
    required this.mcqList
  });

  factory ExamType.fromMap(Map<String, dynamic> json) => ExamType(
      id: json['id'],
      exam: RoutineType.fromMap(json),
      mcqList:parseMcqList(json['mcq_list_value']),
  );
}