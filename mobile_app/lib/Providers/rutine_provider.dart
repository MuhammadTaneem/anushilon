import 'package:flutter/material.dart';

import '../schema/routune_schema.dart';

class RoutineProvider with ChangeNotifier {

  late final  List<RoutineType> _routune = [
    RoutineType(packageId: 1, examNumber: 3, submitted: false, resultPublished: false, date: DateTime.now(), noOfQuestion: 30, subjects: "পদার্থ, রসায়ন, জীব বিজ্ঞান", chapters: "ভৌতজগৎ ও পরিমাপ,ভেক্টর, গতিবিদ্যা, নিউটনের বলবিদ্যা, কাজ ক্ষমতা ও শক্তি, মহাকর্ষ ও অভিকর্ষ"),
    RoutineType(packageId: 3, examNumber: 4, submitted: true, resultPublished: false, date: DateTime.now(), noOfQuestion: 30, subjects: "পদার্থ, রসায়ন, জীব বিজ্ঞান", chapters: "ভৌতজগৎ ও পরিমাপ,ভেক্টর, গতিবিদ্যা, নিউটনের বলবিদ্যা, কাজ ক্ষমতা ও শক্তি, মহাকর্ষ ও অভিকর্ষ"),
    RoutineType(packageId: 2, examNumber: 5, submitted: false, resultPublished: false, date: DateTime.now(), noOfQuestion: 30, subjects: "পদার্থ, রসায়ন, জীব বিজ্ঞান", chapters: "ভৌতজগৎ ও পরিমাপ,ভেক্টর, গতিবিদ্যা, নিউটনের বলবিদ্যা, কাজ ক্ষমতা ও শক্তি, মহাকর্ষ ও অভিকর্ষ"),
    RoutineType(packageId: 1, examNumber: 7, submitted: false, resultPublished: false, date: DateTime.now(), noOfQuestion: 30, subjects: "পদার্থ, রসায়ন, জীব বিজ্ঞান", chapters: "ভৌতজগৎ ও পরিমাপ,ভেক্টর, গতিবিদ্যা, নিউটনের বলবিদ্যা, কাজ ক্ষমতা ও শক্তি, মহাকর্ষ ও অভিকর্ষ"),
  ];
  late  int _response;
  late int filterYear = DateTime.now().year;
  bool _isLoading = false;


  List<RoutineType> get items {
    return [..._routune];
  }

  bool get isLoading{
    return _isLoading;
  }
}