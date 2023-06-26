class McqType{
  late int id;
  late int point;
  late bool multiChose;
  late bool isFavorite;
  late bool showAns;
  late String question;
  late String? imageUrl;
  late List<OptionType> options;
  late String explanation;
  late String? explanationImgUrl;


  McqType({
    required this.id,
    required this.point,
    required this.multiChose,
    this.isFavorite = false,
    this.showAns = false,
    required this.question,
    this.imageUrl,
    required this.options,
    required this.explanation,
    this.explanationImgUrl,
  });

}

class OptionType{
  late int id;
  late bool correct;
  late String? text;
  late String? imageUrl;
  OptionType({required this.id, this.text, this.imageUrl, required this.correct});
}