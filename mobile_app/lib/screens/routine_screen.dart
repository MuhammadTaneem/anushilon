import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../Providers/package_provider.dart';
import '../Providers/rutine_provider.dart';
import '../schema/routune_schema.dart';
class RoutineScreen extends StatefulWidget {
  const RoutineScreen({Key? key}) : super(key: key);

  @override
  State<RoutineScreen> createState() => _RoutineScreenState();
}
class _RoutineScreenState extends State<RoutineScreen> {

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('bn', null);
  }


  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat.yMMMd('bn');
    NumberFormat banglaNumberFormat = NumberFormat.decimalPattern('bn');
    var packageProvider = Provider.of<PackageProvider>(context, listen: true);
    var routineProvider = Provider.of<RoutineProvider>(context, listen: true);

    List<RoutineType> items = routineProvider.items;


    return Scaffold(

        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("রুটিন"),
        ),
        body: SingleChildScrollView(
        child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: items.length,
        separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
        RoutineType item = items[index];
        return Card(

          margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${packageProvider.getPackageNameById(item.packageId)}',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text('পরিক্ষা নং :', style: Theme.of(context).textTheme.titleMedium ),
                            SizedBox(width: 8.0),
                            Text("${banglaNumberFormat.format(item.examNumber)}",),
                          ],
                        ),
                        Row(
                          children: [
                            Text('তারিখ       :', style: Theme.of(context).textTheme.titleMedium ),
                            SizedBox(width: 8.0),
                            Text(" ${dateFormat.format(item.date)}"),
                          ],
                        ),
                        Row(
                          children: [
                            Text('প্রশ্ন           :',style: Theme.of(context).textTheme.titleMedium ),
                            SizedBox(width: 8.0),
                            Text("${banglaNumberFormat.format(item.noOfQuestion)} টি",),
                            // Text('${item.noOfQuestion} টি' ),
                          ],
                        ),
                      ],
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                              (Set<MaterialState> states) {
                            return Theme.of(context).colorScheme.secondary;
                          },
                        ),
                      ),
                      onPressed: null,
                      child: Text('পরিক্ষা দিন'),
                    ),
                  ],
                ),
                SizedBox(height: 6.0),
                Text('সাবজেক্ট   :',style: Theme.of(context).textTheme.titleMedium ),
                Text(item.subjects),
                SizedBox(height: 4.0),
                Text('চ্যাপটার    :',style: Theme.of(context).textTheme.titleMedium ),
                Text(
                  item.chapters
                ),



                SizedBox(height: 16.0),
              ],
            ),
          ),
        );
        }

          // Column(
          //   children: [
          //     SizedBox(height: 20,),
          //     Column()

          //
          //
          //
          //
          //
          //   ],
          // ),
        ))
    );
  }
}
