import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app/schema/routune_schema.dart';
import 'package:mobile_app/widgets/loader_widget.dart';
import 'package:provider/provider.dart';
import '../Providers/routine_provider.dart';

class RoutineScreen extends StatefulWidget {
  const RoutineScreen({Key? key}) : super(key: key);

  @override
  State<RoutineScreen> createState() => _RoutineScreenState();
}

class _RoutineScreenState extends State<RoutineScreen> {

  List<RoutineType> items=[];

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('bn', null);
    // Provider.of<RoutineProvider>(context, listen: false).loadRoutine();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<RoutineProvider>(context, listen: false).loadRoutine();
    });
  }

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat.yMMMMd('bn');
    NumberFormat banglaNumberFormat = NumberFormat.decimalPattern('bn');
    var _provider = Provider.of<RoutineProvider>(context, listen: true);
    items = _provider.items;
    print(items);

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("রুটিন"),
        ),
        body:_provider.isLoading? Center(child: CentralLoading()):  ListView.separated(
            shrinkWrap: true,
            itemCount:items.length,
            separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(height: 10),
            itemBuilder: (context, index) {
              // RoutineType item = _provider.items[index];
              return Card(
                margin:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        items[index].packageName,
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Gap(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text('পরিক্ষা নং :',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium),
                                  const SizedBox(width: 8.0),
                                  Text(
                                    banglaNumberFormat.format(
                                      items[index].examNumber,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('তারিখ       :',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium),
                                  const SizedBox(width: 8.0),
                                  Text(
                                      " ${dateFormat.format(items[index].date)}"),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('প্রশ্ন           :',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium),
                                  const SizedBox(width: 8.0),
                                  Text(
                                    "${banglaNumberFormat.format(
                                      items[index].noOfQuestion,
                                    )} টি",
                                  ),
                                  // Text('${item.noOfQuestion} টি' ),
                                ],
                              ),
                            ],
                          ),
                          items[index].available?
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.resolveWith<Color?>(
                                    (Set<MaterialState> states) {
                                  return Theme.of(context)
                                      .colorScheme
                                      .secondary;
                                },
                              ),
                            ),
                            onPressed: null,
                            child: const Text('পরিক্ষা দিন'),
                          ):Container(),
                        ],
                      ),
                      const Gap(10),
                      items[index].syllabus.isNotEmpty
                          ? const Text("সিলেবাস     :")
                          : Container(),
                      ListView.separated(
                          // physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: items[index].syllabus.length,
                          separatorBuilder:
                              (BuildContext context, int index) =>
                          const SizedBox(height: 10),
                          itemBuilder: (context, subjectIndex) {
                            return Text(
                                " • ${items[index].syllabus[subjectIndex].subject} : ${items[index].syllabus[subjectIndex].chapters}");
                          }),
                      const Gap(2),
                    ],
                  ),
                ),
              );
            })
    );
  }
}
