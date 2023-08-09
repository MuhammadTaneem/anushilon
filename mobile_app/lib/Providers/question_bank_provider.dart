import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mobile_app/schema/question_bank_scheema.dart';
import 'package:mobile_app/services/question_bank_service.dart';
import 'package:mobile_app/utils/show_message.dart';
import '../Database/sqflight.dart';
import '../utils/json_formaor.dart';

class QuestionBankProvider with ChangeNotifier {
  late bool _isLoading = false;
  late  List<QuestionBankType> _questionBankList = [];
  late  QuestionBankType _questionBank;



  Future<void> loadQuestionBankList(data) async {
    try{
      _isLoading = true;
      notifyListeners();

      Response response = await getQuestionBankList(data);
      if (kDebugMode) {
        print(jsonDecode(response.body));
      }
      if (response.statusCode == 200) {
        var aa  =  jsonDecode(response.body, reviver: reviver);
        _questionBankList = parseQuestionBankList(aa);
      } else {
        _questionBankList=[];
        showErrorMessage(msg: "সমস্যার জন্য আন্তরিকভাবে দুক্ষিত, দয়াকরে পুনঃরায় চেস্টা করুন");
      }
    }catch(error){
      _questionBankList=[];
      showErrorMessage(msg: "সার্ভারে সমস্যার জন্য আন্তরিকভাবে দুক্ষিত");
    }
    _isLoading = false;
    notifyListeners();
  }


  Future<void> loadQuestionBankDetails(id) async {
    try{
      _isLoading = true;
      notifyListeners();

      Response response = await getQuestionBankDetails(id);
      if (kDebugMode) {
        print(jsonDecode(response.body));
      }
      if (response.statusCode == 200) {
        var aa  =  jsonDecode(response.body, reviver: reviver);
        _questionBank = QuestionBankType.fromMap(aa);
      } else {
        _questionBankList=[];
        showErrorMessage(msg: "সমস্যার জন্য আন্তরিকভাবে দুক্ষিত, দয়াকরে পুনঃরায় চেস্টা করুন");
      }
    }catch(error){
      _questionBankList=[];
      showErrorMessage(msg: "সার্ভারে সমস্যার জন্য আন্তরিকভাবে দুক্ষিত");
    }
    _isLoading = false;
    notifyListeners();
  }

  checkFavorite() async {
    var favoriteIdList = await DatabaseHelper.instance.getAllMcqIds();
    for (var mcq in _questionBank.mcqList) {
      if (favoriteIdList.contains(mcq.id)) {
        mcq.isFavorite = true;
      }
      else{
        mcq.isFavorite = false;
      }
    }
    notifyListeners();
  }

  List<QuestionBankType> get items {
    return [..._questionBankList];
  }
  QuestionBankType get item{
    checkFavorite();
    return _questionBank;
  }


  bool get isLoading {
    return _isLoading;
  }

}
