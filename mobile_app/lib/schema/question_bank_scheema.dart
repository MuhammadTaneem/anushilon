import 'package:mobile_app/schema/mcq_schema.dart';

class QuestionBankType{
  final int id;
  final int year;
  final String varsity;
  final String unit;
  final List<McqType> mcqList;

  QuestionBankType( {
    required this.year,
    required this.varsity,
    required this.unit,
    required this.id,
    required this.mcqList
  });

  factory QuestionBankType.fromMap(Map<String, dynamic> json) => QuestionBankType(
    id: json['id'],
    year: json['year'],
    varsity: json['varsity'],
    unit: json['unit'],
    mcqList:json.containsValue('mcq_list')? parseMcqList(json['mcq_list']):[],
  );
}

List<QuestionBankType> parseQuestionBankList(List<dynamic> jsonStr) {
  return jsonStr.map((map) => QuestionBankType.fromMap(map)).toList();
}
