// import 'package:cash_flow/Database/sqflight.dart';
import 'package:flutter/material.dart';

import '../schema/package_schema.dart';



class PackageProvider with ChangeNotifier {

  late final  List<PackageType> _packages = [
    PackageType(id:1, name: "মেডিকেল প্রস্তুতি", amount: 350, discount: 50, noOfExam: 50,noOfExamDone: 10, categoryId: 2, description: "স্বপ্ন মনে অনেক ছিলো. ছিলো হাজার আসা. এক সাথে কাটবে জীবন. বাঁধবো সুখের স্বপ্ন মনে অনেক ছিলো. ছিলো হাজার আসা. এক সাথে কাটবে জীবন. বাঁধবো সুখের স্বপ্ন মনে অনেক ছিলো. ছিলো হাজার আসা. এক সাথে কাটবে জীবন. বাঁধবো সুখের স্বপ্ন মনে অনেক ছিলো. ছিলো হাজার আসা. এক সাথে কাটবে জীবন. বাঁধবো সুখের স্বপ্ন মনে অনেক ছিলো. ছিলো হাজার আসা. এক সাথে কাটবে জীবন. বাঁধবো সুখের স্বপ্ন মনে অনেক ছিলো. ছিলো হাজার আসা. এক সাথে কাটবে জীবন. বাঁধবো সুখের স্বপ্ন মনে অনেক ছিলো. ছিলো হাজার আসা. এক সাথে কাটবে জীবন. বাঁধবো সুখের ", startDate: DateTime.now(), endDate: DateTime(2023, 6, 25), discountDate: DateTime.now()),
    PackageType(id: 2, name: "ঢাবি ক ইউনিট প্রস্তুতি", amount: 390, discount: 39, noOfExam: 50, noOfExamDone: 30,categoryId: 2, description: "স্বপ্ন মনে অনেক ছিলো. ছিলো হাজার আসা. এক সাথে কাটবে জীবন. বাঁধবো সুখের স্বপ্ন মনে অনেক ছিলো. ছিলো হাজার আসা. এক সাথে কাটবে জীবন. বাঁধবো সুখের স্বপ্ন মনে অনেক ছিলো. ছিলো হাজার আসা. এক সাথে কাটবে জীবন. বাঁধবো সুখের স্বপ্ন মনে অনেক ছিলো. ছিলো হাজার আসা. এক সাথে কাটবে জীবন. বাঁধবো সুখের স্বপ্ন মনে অনেক ছিলো. ছিলো হাজার আসা. এক সাথে কাটবে জীবন. বাঁধবো সুখের স্বপ্ন মনে অনেক ছিলো. ছিলো হাজার আসা. এক সাথে কাটবে জীবন. বাঁধবো সুখের স্বপ্ন মনে অনেক ছিলো. ছিলো হাজার আসা. এক সাথে কাটবে জীবন. বাঁধবো সুখের ", startDate: DateTime.now(), endDate: DateTime(2023, 7, 25), discountDate: DateTime.now()),
    PackageType(id: 3, name: "ইঞ্জিনিয়ারিং প্রস্তুতি", amount: 450, discount: 30, noOfExam: 50, noOfExamDone: 15,categoryId: 2, description: "স্বপ্ন মনে অনেক ছিলো. ছিলো হাজার আসা. এক সাথে কাটবে জীবন. বাঁধবো সুখের স্বপ্ন মনে অনেক ছিলো. ছিলো হাজার আসা. এক সাথে কাটবে জীবন. বাঁধবো সুখের স্বপ্ন মনে অনেক ছিলো. ছিলো হাজার আসা. এক সাথে কাটবে জীবন. বাঁধবো সুখের স্বপ্ন মনে অনেক ছিলো. ছিলো হাজার আসা. এক সাথে কাটবে জীবন. বাঁধবো সুখের স্বপ্ন মনে অনেক ছিলো. ছিলো হাজার আসা. এক সাথে কাটবে জীবন. বাঁধবো সুখের স্বপ্ন মনে অনেক ছিলো. ছিলো হাজার আসা. এক সাথে কাটবে জীবন. বাঁধবো সুখের স্বপ্ন মনে অনেক ছিলো. ছিলো হাজার আসা. এক সাথে কাটবে জীবন. বাঁধবো সুখের ", startDate: DateTime.now(), endDate: DateTime(2023, 8, 15), discountDate: DateTime.now()),
    PackageType(id:4, name: "কৃষি গুচ্ছ ভর্তি প্রস্তুতি", amount: 370, discount: 50, noOfExam: 50,noOfExamDone: 2, categoryId: 2, description: "স্বপ্ন মনে অনেক ছিলো. ছিলো হাজার আসা. এক সাথে কাটবে জীবন. বাঁধবো সুখের স্বপ্ন মনে অনেক ছিলো. ছিলো হাজার আসা. এক সাথে কাটবে জীবন. বাঁধবো সুখের স্বপ্ন মনে অনেক ছিলো. ছিলো হাজার আসা. এক সাথে কাটবে জীবন. বাঁধবো সুখের স্বপ্ন মনে অনেক ছিলো. ছিলো হাজার আসা. এক সাথে কাটবে জীবন. বাঁধবো সুখের স্বপ্ন মনে অনেক ছিলো. ছিলো হাজার আসা. এক সাথে কাটবে জীবন. বাঁধবো সুখের স্বপ্ন মনে অনেক ছিলো. ছিলো হাজার আসা. এক সাথে কাটবে জীবন. বাঁধবো সুখের স্বপ্ন মনে অনেক ছিলো. ছিলো হাজার আসা. এক সাথে কাটবে জীবন. বাঁধবো সুখের ", startDate: DateTime.now(), endDate: DateTime.now(), discountDate: DateTime.now()),
  ];
  late  int _response;
  // final snackWidget = SnackWidget();
  late int filterYear = DateTime.now().year;
  // late int filterMonth = DateTime.now().month;
  bool _isLoading = false;


  String getPackageNameById(int id) {
    for (PackageType package in _packages) {
      if (package.id == id) {
        return package.name;
      }
    }
    return ''; // Return an empty string if no package with the given id is found
  }

  List<PackageType> getPackagesFromIdList() {

    List<int> myPackages = [1,3,4];
    List<PackageType> selectedPackages = [];

    for (int id in myPackages) {
      PackageType? package = _packages.firstWhere((package) => package.id == id );
      if (package != null) {
        selectedPackages.add(package);
      }
    }
    return selectedPackages;
  }



  // getFilterContext(){
  //   return{'year': filterYear, 'month': filterMonth};
  // }

  List<PackageType> get items {
    return [..._packages];
  }

  bool get isLoading{
    return _isLoading;
  }

  //
  // Future<void> loadItems() async {
  //   _isLoading = true;
  //   notifyListeners();
  //   // _incomes = await DatabaseHelper.instance.getIncome();
  //   // _filteredIncomes = _incomes.where((income) =>
  //   // income.dateTime.year == FilterDate.year  && income.dateTime.month == FilterDate.month
  //   // ).toList();
  //   // _items;
  //   notifyListeners();
  //   _isLoading = false;
  // }




  // int get itemCount {
  //   return _filteredIncomes.length;
  // }

  // int get totalAmount{
  //   int  totalAmount = _filteredIncomes.fold(0, (previousValue, item) => previousValue + item.amount);
  //   return totalAmount;
  // }

  // Future<void> addItem(IncomeType income) async {
  //   _response = await DatabaseHelper.instance.addIncome(income);
  //   if(_response>0){
  //     snackWidget.showMessage(message: "Income added.", snackbarType: SnackbarType.success);
  //     loadItems();
  //   }
  //   else{
  //   snackWidget.showMessage(message: "Failed.", snackbarType: SnackbarType.error);
  //   }
  //
// }
  //
  // removeItem(IncomeType income) async {
  //   if(income.id != null){
  //   _response = await DatabaseHelper.instance.removeIncome(income.id);
  //   }
  //   if(_response>0){
  //     snackWidget.showMessage(message: "Income deleted.", snackbarType: SnackbarType.success);
  //     loadItems();
  //   }
  // }
  // editItem(IncomeType income) async {
  //   _response = 0;
  //   if(income.id != null){
  //     _response = await DatabaseHelper.instance.updateIncome(income);
  //   }
  //   if(_response>0){
  //     snackWidget.showMessage(message: "Income updated.", snackbarType: SnackbarType.success);
  //     loadItems();
  //   }
  //   else{
  //     snackWidget.showMessage(message: "failed.", snackbarType: SnackbarType.error);
  //   }
  // }



}