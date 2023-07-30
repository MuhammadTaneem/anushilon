import 'package:flutter/material.dart';
import 'package:mobile_app/Providers/package_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../schema/package_schema.dart';
import 'animated_expention.dart';
import 'package:readmore/readmore.dart';
import 'package:intl/date_symbol_data_local.dart';
class PackageListWidget extends StatefulWidget {
  const PackageListWidget({super.key});

  @override
  State<PackageListWidget> createState() => _PackageListWidgetState();
}

class _PackageListWidgetState extends State<PackageListWidget> {



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
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (context, index) {
        PackageType item = items[index];
        return AnimatedExpansionTile(title: Flexible(
          child: Text(item.name,style:TextStyle(
            overflow: TextOverflow.ellipsis,
          ) ,),
        ),


          body: Container(

            // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.spa,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                // package name
                Container(
                  padding: const EdgeInsets.all(8),
                  child: Text(item.name,
                    style:  TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),

                Row(
                  children: [
                    const Expanded(
                      flex: 2,
                      child: Text(
                        "পরিক্ষা",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: Text(":  ${banglaNumberFormat.format(item.noOfExam)} টি",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Expanded(
                      flex: 2,
                      child: Text(
                        "মূল্য",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: item.discount == 0 ?
                      Text(":  ${banglaNumberFormat.format(item.amount)} টাকা",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ):
                      Row(
                        children: [
                          Text(":  "),
                          Text("${banglaNumberFormat.format(item.amount)}",
                            style: const TextStyle(
                              decoration: TextDecoration.lineThrough,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(" ${banglaNumberFormat.format(item.amount-item.discount)} টাকা",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                Row(
                  children: [
                    const Expanded(
                      flex: 2,
                      child: Text(
                        "শুরু",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: Text(":  ${dateFormat.format(item.startDate)}",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Expanded(
                      flex: 2,
                      child: Text(
                        "শেষ",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: Text(":  ${dateFormat.format(item.startDate)}",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),






                // Description
                Row(
                  children: const [
                    Expanded(
                      flex: 2,
                      child: Text(
                        "বিবরণ",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: Text(":",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                ReadMoreText(
                  item.description,
                  trimLines: 2,
                  colorClickableText: Colors.redAccent,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: 'আরও পড়ুন',
                  trimExpandedText: '   সংক্ষিপ্ত করুন',
                  style: const TextStyle(fontSize: 14, color: Colors.black),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    // Handle button press
                    // (code omitted for brevity)
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'ক্রয় করুন',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),);
      }, separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 10),
    );
  }
}
