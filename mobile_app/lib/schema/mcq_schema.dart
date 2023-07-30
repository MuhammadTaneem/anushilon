
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
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'point': point,
      'multiChose': multiChose ? 1 : 0,
      'isFavorite': isFavorite ? 1 : 0,
      'showAns': showAns ? 1 : 0,
      'question': question,
      'imageUrl': imageUrl,
      'explanation': explanation,
      'explanationImgUrl': explanationImgUrl,
      // 'options': options.map((option) => option.toMap(id)).toList(),
    };
  }
  factory McqType.fromMap(Map<String, dynamic> map) {
    return McqType(
      id: map['id'],
      point: map['point'],
      multiChose: map['multiChose'] == 1,
      isFavorite: map['isFavorite'] == 1,
      showAns: map['showAns'] == 1,
      question: map['question'],
      imageUrl: map['imageUrl'],
      explanation: map['explanation'],
      explanationImgUrl: map['explanationImgUrl'],
      options: <OptionType>[],
      // options: map['options']((option) => option.fromMap()).toList(), // You'll need to fetch options separately
    );
  }



}

class OptionType{
  late int id;
  late bool correct;
  late String? text;
  late String? imageUrl;
  OptionType({required this.id, this.text, this.imageUrl, required this.correct});
  Map<String, dynamic> toMap(int mcqId) {
    return {
      'mcqId': mcqId,
      'correct': correct ? 1 : 0,
      'text': text,
      'imageUrl': imageUrl,
    };
  }

  factory OptionType.fromMap(Map<String, dynamic> map) {
    return OptionType(
      id: map['id'],
      correct: map['correct'] == 1,
      text: map['text'],
      imageUrl: map['imageUrl'],
    );
  }

}


List<McqType> parseMcqList(List<dynamic> jsonStr) {
  return jsonStr.map((map) => parseMcq(map)).toList();
}

McqType parseMcq(Map<String, dynamic> json) {
  List<OptionType> options = [];
  for (int i = 1; i <= 4; i++) {
    String? text = json['option_text_$i'];
    String? imageUrl = json['option_img_$i'];
    bool correct = i == int.parse(json['correct_ans']);
    options.add(OptionType(id: i, text: text, imageUrl: imageUrl, correct: correct));
  }

  return McqType(
    id: json['id'],
    point: 0, // Set the appropriate value for point if available in the JSON
    multiChose: false, // Set the appropriate value for multiChose if available in the JSON
    isFavorite: false,
    showAns: false,
    question: json['question'],
    imageUrl: json['question_img'],
    options: options,
    explanation: json['explanation'],
    explanationImgUrl: json['explanation_img'],
  );
}






