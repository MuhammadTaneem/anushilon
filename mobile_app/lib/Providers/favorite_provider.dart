import 'package:flutter/material.dart';
import 'package:mobile_app/schema/mcq_schema.dart';

import '../Database/sqflight.dart';

class FavoriteProvider with ChangeNotifier {

  String imageUlr = 'https://images.unsplash.com/photo-1546587348-d12660c30c50?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2074&q=80';
  late List<McqType> _favorite = [
    McqType(
      id: 1,
      point: 2,
      multiChose: false,
      isFavorite: true,
      question: "বাংলাদেশের রাজধানী কোথায় অবস্থিত?",

      options: [
        OptionType(id: 1, text: "ঢাকা", correct: true),
        OptionType(id: 2, text: "চট্টগ্রাম", correct: false),
        OptionType(id: 3, text: "রাজশাহী", correct: false),
        OptionType(id: 4, text: "খুলনা",correct: false),
      ],
      explanation: "বাংলাদেশের রাজধান ঢাকা.",
    ),
    McqType(
      id: 2,
      point: 2,
      multiChose: false,
      isFavorite: true,
      question: "বাংলাদেশের জাতীয় বৃহত্তম নদী কোনটি?",

      options: [
        OptionType(id: 1, text: "পদ্মা", imageUrl: imageUlr, correct: true),
        OptionType(id: 2, text: "ব্রহ্মপুত্র",imageUrl: imageUlr, correct: false),
        OptionType(id: 3, text: "তিস্তা",imageUrl: imageUlr, correct: false),
        OptionType(id: 4, text: "মেঘনা", imageUrl: imageUlr, correct: false),
      ],
      explanation: "পদ্মা নদীটি বাংলাদেশের জাতীয় বৃহত্তম নদী।",
    ),
    McqType(
      id: 3,
      point: 1,
      multiChose: false,
      isFavorite: true,
      question: "বাংলাদেশের জাতীয় প্রতীক কী?",
      imageUrl: imageUlr,

      options: [
        OptionType(id: 1, text: "শাপলা", correct: false),
        OptionType(id: 2, text: "ধনুক", correct: true),
        OptionType(id: 3, text: "ফুলগচ্ছ", correct: false),
        OptionType(id: 4, text: "মহিষ", correct: false),
      ],
      explanation: " শাপলা বাংলাদেশের জাতীয় প্রতীক।",
      explanationImgUrl: imageUlr
    ),
    McqType(
      id: 4,
      point: 3,
      multiChose: true,
      isFavorite: true,

      question: "বাংলাদেশের জাতীয় পতাকার রং কি কি?",
      options: [
        OptionType(id: 1, text: "সবুজ", correct: true),
        OptionType(id: 2, text: "নীল ", correct: false),
        OptionType(id: 3, text: "লাল", correct: true),
        OptionType(id: 4, text: "হলুদ", correct: false),
      ],
      explanation: "বাংলাদেশের জাতীয় পতাকা সবুজ আয়তক্ষেত্রের মধ্যে লাল বৃত্ত। সবুজ রং বাংলাদেশের সবুজ প্রকৃতি ও তারুণ্যের প্রতীক, বৃত্তের লাল রং উদীয়মান সূর্য, স্বাধীনতা যুদ্ধে আত্মোৎসর্গকারীদের রক্তের প্রতীক",
    )


  ];
  late int _response;
  late int filterYear = DateTime.now().year;
  final bool _isLoading = false;


  Future<void> loadItems() async {
    _favorite = await DatabaseHelper.instance.getAllMcq();
    notifyListeners();
  }
  Future<void> deleteItem(mcqId) async {
    int deletedRows = await DatabaseHelper.instance.deleteMcq(mcqId);
    if (deletedRows > 0) {
      loadItems();
    }
  }


  Future<void> addItem(McqType mcq) async {
    var _response = await DatabaseHelper.instance.addMcq(mcq);
    if(_response>0){
      loadItems();
    }

  }



  List<McqType> get items {
    return [..._favorite];
  }

  bool get isLoading {
    return _isLoading;
  }
}
