import 'package:flutter/material.dart';
import 'package:mobile_app/Providers/favorite_provider.dart';
import 'package:mobile_app/schema/mcq_schema.dart';
import 'package:mobile_app/widgets/read_mcq_screen.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  static const routeName = '/favorite_screen';

  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}




class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    List<McqType> mcqList =
        Provider.of<FavoriteProvider>(context, listen: true).items;
    return Scaffold(
      appBar: AppBar(
        title: Text("ফ্যাভারিট"),
      ),
      body: ReadMcqScreen(mcqList: mcqList),
    );
  }
}
