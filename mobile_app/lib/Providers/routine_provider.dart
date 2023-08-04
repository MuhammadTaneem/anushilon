import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mobile_app/services/routine_service.dart';

import '../schema/mcq_schema.dart';
import '../schema/routune_schema.dart';
import '../utils/json_formaor.dart';
import '../utils/show_message.dart';

class RoutineProvider with ChangeNotifier {

  late List<RoutineType> _routine = [];
  late int filterYear = DateTime.now().year;
  bool _isLoading = false;

  Future<void> loadRoutine({package, date}) async {
    try{
      _isLoading = true;
      notifyListeners();
      DateTime now = DateTime.now();
      var today =now.toIso8601String().split('T')[0];

      Map<String, dynamic> data = {
        'exam_from_date': date == null?date:today,
      };
      if(package != null){
      data['package']= package;
      }

      Response response = await getExamRoutine(data);

      if (response.statusCode == 200) {
        // print(jsonDecode(response.body));
        var aa =  jsonDecode(response.body, reviver: reviver);
        _routine =  parseRoutineList(aa);
      } else {
        showErrorMessage(msg: "সার্ভারে সমস্যা হয়েছে, পুনঃরায় চেস্টা করুন");
      }
    }catch(error){
      showErrorMessage(msg: "সার্ভারে সমস্যা হয়েছে,, পুনঃরায় চেস্টা করুন");
    }
    _isLoading = false;
    notifyListeners();
  }


  List<RoutineType> get items {
    return [..._routine];
  }

  bool get isLoading{
    return _isLoading;
  }
}