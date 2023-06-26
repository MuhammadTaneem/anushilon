import 'package:flutter/material.dart';
import 'package:mobile_app/Providers/package_provider.dart';
import 'package:mobile_app/package/package_list.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../schema/package_schema.dart';
import '../widgets/animated_expention.dart';
import 'package:readmore/readmore.dart';
import 'package:intl/date_symbol_data_local.dart';
class PackageScreen extends StatefulWidget {
  static const routeName = '/package_screen';
  const PackageScreen({super.key});

  @override
  State<PackageScreen> createState() => _PackageScreenState();
}

class _PackageScreenState extends State<PackageScreen> {



  @override
  void initState() {
    super.initState();
    initializeDateFormatting('bn', null);
  }

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat.yMMMd('bn');
    // DateFormat timeFormat = DateFormat.jm('bn');
    NumberFormat banglaNumberFormat = NumberFormat.decimalPattern('bn');
    var packageProvider = Provider.of<PackageProvider>(context, listen: true);
    List<PackageType> items = packageProvider.items;
    return Scaffold(
        appBar: AppBar(title: const Text("প্যাকেজ")),
        body: SingleChildScrollView(child: Container(

            padding: EdgeInsets.only(top: 20),
            child: PackageList())));
  }
}
