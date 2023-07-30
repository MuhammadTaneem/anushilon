import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:mobile_app/Providers/favorite_provider.dart';
import 'package:mobile_app/Providers/mcq_provider.dart';
import 'package:mobile_app/Providers/notification_provider.dart';
import 'package:mobile_app/Providers/package_provider.dart';
import 'package:mobile_app/Providers/rutine_provider.dart';
import 'package:mobile_app/screens/varsity_screen.dart';
import 'package:mobile_app/authentication/login.dart';
import 'package:mobile_app/screens/favorite_screen.dart';
import 'package:mobile_app/screens/free_exam_screen.dart';
import 'package:mobile_app/screens/guccho_screen.dart';
import 'package:mobile_app/screens/hsc_screen.dart';
import 'package:mobile_app/screens/medichal_screen.dart';
import 'package:mobile_app/screens/notification_screen.dart';
import 'package:mobile_app/screens/participated_screen.dart';
import 'package:mobile_app/screens/profile_page_screen.dart';
import 'package:mobile_app/screens/question_bank_screen.dart';
import 'package:mobile_app/screens/subject_wise_screen.dart';
import 'package:mobile_app/theme/theme_data.dart';
import 'package:mobile_app/theme/theme_manager.dart';
import 'package:mobile_app/utils/urtils.dart';
import 'package:provider/provider.dart';
import 'screens/engineering_screen.dart';
import 'screens/home_page_screen.dart';
import 'screens/package_screen.dart';


main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final LocalStorage storage = await getStorage();
  bool isAuthenticated = await storage.getItem("isAuthorized") ?? false;
  runApp(MyApp(authenticated: isAuthenticated));
}

class MyApp extends StatefulWidget {

  final bool authenticated;
  const MyApp({super.key, required this.authenticated});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    ThemeManager _themeManager = ThemeManager();
    return  MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => McqProvider(),),
        ChangeNotifierProvider(create: (_) => PackageProvider(),),
        ChangeNotifierProvider(create: (_) => RoutineProvider(),),
        ChangeNotifierProvider(create: (_) => NotificationProvider(),),
        ChangeNotifierProvider(create: (_) => FavoriteProvider(),),
      ],
      child: MaterialApp(
          title: 'অনুশীলন',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: _themeManager.themeMode,
        initialRoute: '/',
        routes: {
          '/': (context) => widget.authenticated ? const HomePageScreen(): LoginPage(),
          HomePageScreen.routeName: (context) => const HomePageScreen(),
          PackageScreen.routeName: (ctx) => const PackageScreen(),
          ProfileScreen.routeName: (ctx) => const ProfileScreen(),
          FreeExamScreen.routeName: (ctx) => const FreeExamScreen(),
          VarsityScreen.routeName: (ctx) => const VarsityScreen(),
          EngineeringScreen.routeName: (ctx) => const EngineeringScreen(),
          MedicalScreen.routeName: (ctx) => const MedicalScreen(),
          QuestionBankScreen.routeName: (ctx) => const QuestionBankScreen(),
          SubjectWiseScreen.routeName: (ctx) => const SubjectWiseScreen(),
          HscScreen.routeName: (ctx) => const HscScreen(),
          FavoriteScreen.routeName: (ctx) => const FavoriteScreen(),
          ParticipatedScreen.routeName: (ctx) => const ParticipatedScreen(),
          GucchoScreen.routeName: (ctx) => const GucchoScreen(),
          NotificationScreen.routeName: (ctx) =>  NotificationScreen(),


        },
        onUnknownRoute: (settings) {
          return MaterialPageRoute(
            builder: (ctx) => const HomePageScreen(),
          );
        },

      ),
    );
  }
}