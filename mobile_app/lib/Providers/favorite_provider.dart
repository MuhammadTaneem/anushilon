import 'package:flutter/material.dart';
import 'package:mobile_app/schema/mcq_schema.dart';

import '../Database/sqflight.dart';

class FavoriteProvider with ChangeNotifier {

  late List<McqType> _favorite = [];
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

  int get count{
    return _favorite.length;
  }

  bool get isLoading {
    return _isLoading;
  }
}
