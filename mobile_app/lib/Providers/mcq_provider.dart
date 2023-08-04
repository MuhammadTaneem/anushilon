import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mobile_app/utils/show_message.dart';
import '../Database/sqflight.dart';
import '../schema/mcq_schema.dart';
import '../services/mcq_service.dart';
import '../utils/json_formaor.dart';

class McqProvider with ChangeNotifier {
  late int _count = 0;
  final int _limit = 25;
  late int _pageNumber = 0;
  late String? subject;
  late String? subjectKey;
  late String? chapter;
  late bool _isLoading = false;
  late  List<McqType> _mcqList = [];



  Future<void> loadMcq() async {
    try{
      _isLoading = true;
      notifyListeners();

      Map<String, dynamic> data = {
        'limit': '$_limit',
        'offset': '${_pageNumber*_limit}',
        'subject': subjectKey,
        'chapter': chapter,
        'published': 'True',
      };
      Response response = await getMcq(data);
      print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        var aa =  jsonDecode(response.body, reviver: reviver);
        _count = aa['count'];
        _mcqList = parseMcqList(aa['results']);
      } else {
        showErrorMessage(msg: "সার্ভারে সমস্যা হয়েছে, পুনঃরায় চেস্টা করুন");
      }
    }catch(error){
      print("$error");
      showErrorMessage(msg: "সার্ভারে সমস্যা হয়েছে,, পুনঃরায় চেস্টা করুন");
    }
    _isLoading = false;
    notifyListeners();
  }

  checkFavorite() async {
    var favoriteIdList = await DatabaseHelper.instance.getAllMcqIds();
    for (var mcq in _mcqList) {
      if (favoriteIdList.contains(mcq.id)) {
        mcq.isFavorite = true;
      }
      else{
        mcq.isFavorite = false;
      }
    }
    notifyListeners();
  }

  List<McqType> get items {
    checkFavorite();
    return [..._mcqList];
  }


  setChapter(String? chapterName){
    chapter = chapterName;
  }
  setSubjectKey(String? subjectKeyName){
    subjectKey = subjectKeyName;
  }
  setPage(int page){
    _pageNumber = page;
  }
  get getPage{
    return _pageNumber;
  }




  bool get isLoading {
    return _isLoading;
  }
  int get count{
    return _count;
  }
}
