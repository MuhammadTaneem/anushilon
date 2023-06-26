import 'package:flutter/material.dart';
import 'package:fancy_bottom_navigation_2/fancy_bottom_navigation.dart';
import 'package:mobile_app/dashBoard/dashBoard.dart';
import 'package:mobile_app/profile/profile_page_screen.dart';
import 'package:mobile_app/questionBank/question_bank.dart';
import '../routine/routine.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const routeName = '/home_page';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget currentPage = DashBoard();
  List<Widget> pages=[DashBoard(),Routine(), QuestionBankScreen(),ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: currentPage,
      bottomNavigationBar: FancyBottomNavigation(
      // activeIconColor: Theme.of(context).colorScheme.secondary,
      //   barBackgroundColor: Theme.of(context).colorScheme.secondary,
      //   circleColor: Theme.of(context).colorScheme.secondary,
        tabs: [
          TabData(iconData: Icons.home, title: "হোম পেইজ"),
          TabData(iconData: Icons.event, title: "রুটিন"),
          TabData(iconData: Icons.help, title: "প্রশ্ন ব্যাংক",),
          TabData(iconData: Icons.person, title: "প্রোফাইল")
        ],
        onTabChangedListener: (position) {
          setState(() {
          currentPage = pages[position];
          });
        },
      ),
    );
  }
}
