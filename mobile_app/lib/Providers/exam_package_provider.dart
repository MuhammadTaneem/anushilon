import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:localstorage/localstorage.dart';
import '../schema/exam_package_schema.dart';
import '../services/exan_package_service.dart';
import '../utils/show_message.dart';
import '../utils/urtils.dart';


class ExamPackageProvider with ChangeNotifier {

  List<ExamPackageType> _examPackageList = [];
  bool _isLoading = false;


  List<ExamPackageType> get items {
    return [..._examPackageList];
  }

  loadPackage(String category) async {

    try{
      _isLoading = true;
      notifyListeners();

      final LocalStorage storage = await getStorage();
      // Map<String, dynamic> data = {
      //   'category': category,
      //   'student': await storage.getItem('userId'),
      // };
      // print(data);
      Response response = await getExamPackage ({
        'category': category,
        'student': await storage.getItem('userId'),
      });
        print(jsonDecode(response.body));

      if (response.statusCode == 200) {
        // var response = jsonDecode(response.body);

        _examPackageList =  parseExamPackageList(jsonDecode(response.body)['results']);
      } else {
        _examPackageList = [];
        showErrorMessage(msg: "সার্ভারে সমস্যা হয়েছে, পুনঃরায় চেস্টা করুন");
      }
    }catch(error){
      _examPackageList = [];
      showErrorMessage(msg: "সার্ভারে সমস্যা হয়েছে, পুনঃরায় চেস্টা করুন");
    }
    _isLoading = false;
    notifyListeners();
  }

  bool get isLoading{
    return _isLoading;
  }
}