import 'package:flutter/material.dart';
import 'package:mobile_app/Varsity/varsity_screen.dart';
import 'package:mobile_app/favorite/favorite.dart';
import 'package:mobile_app/freeExam/free_exam_screen.dart';
import 'package:mobile_app/guccho/guccho_screen.dart';
import 'package:mobile_app/hsc/hsc_screen.dart';
import 'package:mobile_app/medical/medichal_screen.dart';
import 'package:mobile_app/notification/notification_screen.dart';
import 'package:mobile_app/package/package_list.dart';
import 'package:mobile_app/participatedExam/participated_screen.dart';
import 'package:mobile_app/questionBank/question_bank.dart';
import 'package:mobile_app/subjectWise/subject_wise.dart';

import '../engineering/engineering_screen.dart';
import '../package/package_screen.dart';
import '../profile/profile_page_screen.dart';

class DashBoard extends StatefulWidget {


   DashBoard({Key? key}) : super(key: key);
   static const routeName = '/dashboard';

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  late bool searchBarVisible = false;

  List<HomePageCategory> homePageCategoryList=[
    HomePageCategory(icon: Icon(Icons.assignment),screen : FreeExamScreen.routeName, name: "ফ্রি পরীক্ষা", ),
    HomePageCategory(icon: Icon(Icons.star),screen : PackageScreen.routeName, name: "লাইভ পরীক্ষা"),
    HomePageCategory(icon: Icon(Icons.school), screen : VarsityScreen.routeName,name: "ভার্সিটি"),
    HomePageCategory(icon: Icon(Icons.local_hospital),screen : MedicalScreen.routeName, name: "মেডিকেল"),
    HomePageCategory(icon: Icon(Icons.engineering),screen : EngineeringScreen.routeName, name: "ইঞ্জিনিয়ারিং"),
    HomePageCategory(icon: Icon(Icons.group),screen : GucchoScreen.routeName, name: "গুচ্ছ"),
    HomePageCategory(icon: Icon(Icons.help),screen :  QuestionBankScreen.routeName, name: "প্রশ্ন ব্যাংক"),
    HomePageCategory(icon: Icon(Icons.menu_book),screen : SubjectWiseScreen.routeName, name: "বিষয়ভিত্তিক"),
    HomePageCategory(icon: Icon(Icons.category),screen : SubjectWiseScreen.routeName, name: "মক পরীক্ষা"),
    HomePageCategory(icon: Icon(Icons.verified_user),screen : HscScreen.routeName, name: "এইচএসসি"),
    HomePageCategory(icon: Icon(Icons.favorite),screen : FavoriteScreen.routeName, name: "ফ্যাভারিট"),
    HomePageCategory(icon: Icon(Icons.replay),screen : ParticipatedScreen.routeName, name: "পূর্ববর্তী"),
  ];

  @override
  Widget build(BuildContext context) {
    late double dvHeight = MediaQuery.of(context).size.height;
    late double dvWight = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("অনুশীলন"),
        actions: [
          IconButton(onPressed: (){
            setState(() {
            searchBarVisible = !searchBarVisible;
            print(searchBarVisible);
            });
          }, icon:Icon(Icons.search)),
          IconButton(onPressed: (){
            Navigator.pushNamed(context, NotificationScreen.routeName);
          }, icon:Icon(Icons.notifications_active)),
          // SizedBox(height: 10, width: 10,),
          SizedBox(height: 10, width: 10,)
        ],

        bottom: searchBarVisible?PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search...',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                print(value);
                // Handle search text change
                // Implement your search logic here
              },
            ),
          ),
        ):null,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4

                    ),
                    itemCount: homePageCategoryList.length,
                     itemBuilder: (context, index) {
                    final item = homePageCategoryList[index];
                    return InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, item.screen);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 1.0), //(x,y)
                              blurRadius: 0.2,
                            ),
                          ],
                        ),
                        margin: EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            item.icon,
                            FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(item.name))],
                        ),
                      ),
                    );
                  }

    ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("প্যাকেজ সমূহ", style: TextStyle(
                  fontSize: 20
                ),),
              ),
              // PackageScreen()
              PackageList()

            ],
          ),
        ),
      ),
    );
  }
}

class HomePageCategory{
  final Icon icon;
  final String name;
  final String screen;
  HomePageCategory({required this.icon, required this.screen, required this.name});
}
