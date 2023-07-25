// import 'package:flutter/material.dart';
// import 'package:fancy_bottom_navigation_2/fancy_bottom_navigation.dart';
// import 'package:mobile_app/dashBoard/dashBoard.dart';
// import 'package:mobile_app/profile/profile_page_screen.dart';
// import 'package:mobile_app/questionBank/question_bank.dart';
// import '../routine/routine.dart';
//
//
// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);
//   static const routeName = '/home_page';
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   Widget currentPage = DashBoard();
//   List<Widget> pages=[DashBoard(),Routine(), QuestionBankScreen(),ProfileScreen()];
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       body: currentPage,
//       bottomNavigationBar: FancyBottomNavigation(
//       // activeIconColor: Theme.of(context).colorScheme.secondary,
//       //   barBackgroundColor: Theme.of(context).colorScheme.secondary,
//       //   circleColor: Theme.of(context).colorScheme.secondary,
//         tabs: [
//           TabData(iconData: Icons.home, title: "হোম পেইজ"),
//           TabData(iconData: Icons.event, title: "রুটিন"),
//           TabData(iconData: Icons.help, title: "প্রশ্ন ব্যাংক",),
//           TabData(iconData: Icons.person, title: "প্রোফাইল")
//         ],
//         onTabChangedListener: (position) {
//           setState(() {
//           currentPage = pages[position];
//           });
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:mobile_app/dashBoard/dashBoard.dart';
import 'package:mobile_app/profile/profile_page_screen.dart';
import 'package:mobile_app/questionBank/question_bank.dart';
import '../routine/routine.dart';
import '../widgets/nav_items.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const routeName = '/home_page';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int selectedIndex = 0;
  final pages = [
    {'label': 'হোম পেইজ', 'icon': const Icon(Icons.home, color: Colors.white,), 'screen': DashBoard()},
    {'label': 'রুটিন', 'icon': const Icon(Icons.event, color: Colors.white,), 'screen': const Routine()},
    {'label': 'প্রশ্ন ব্যাংক', 'icon': const Icon(Icons.help,color: Colors.white,), 'screen': const QuestionBankScreen()},
    {'label': 'প্রোফাইল', 'icon': const Icon(Icons.person,color: Colors.white,), 'screen': const ProfileScreen()}
  ];
  late final List<Widget> _items =  pages.map<Widget>((page) => NavbarItem( icon: page['icon'] as Icon, label: page['label'] as String,)  ).toList();
  List<Widget> getNavItem(sIndex){
    return pages
        .asMap()
        .map((index, page) {
      if (index == sIndex) {
        return MapEntry(
          index,
          page['icon'] as Icon ,
        );
      } else {
        return MapEntry(
            index,
            _items[index]
        );
      }
    }).values.toList();
  }



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: pages[selectedIndex]['screen'] as Widget?,
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: Theme.of(context).colorScheme.primary,
        animationCurve: Curves.ease,
        animationDuration: const Duration(milliseconds:1100),
        buttonBackgroundColor: Theme.of(context).colorScheme.secondary,
        height: 60,
        items: getNavItem(selectedIndex),
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}
