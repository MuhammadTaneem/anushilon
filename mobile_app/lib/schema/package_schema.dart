class PackageType{
  late int id;
  late String name;
  late int amount;
  late int discount;
  late int noOfExam;
  late int noOfExamDone;
  late int categoryId;
  late String description;
  late DateTime startDate;
  late DateTime endDate;
  late DateTime discountDate;


  PackageType({
    required this.id,
    required this.name,
    required this.amount,
    required this.discount,
    required this.noOfExam,
    required this.noOfExamDone,
    required this.categoryId,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.discountDate,
  });



// factory IncomeType.fromMap(Map<String, dynamic> json) => IncomeType(
//   id: json['id'],
//   source: json['source'],
//   description: json['description'],
//   amount: json['amount'],
//   dateTime: DateTime.parse(json['dateTime'])
// );
//
// Map<String, dynamic> toMap() {
//   return {
//     'id': id,
//     'source': source,
//     'description': description,
//     'amount': amount,
//     'dateTime': DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime),
//   };
// }
}