import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../schema/package_schema.dart';

class PackageDetailsWidget extends StatefulWidget {
  final PackageType package;

  PackageDetailsWidget({required this.package});

  @override
  State<PackageDetailsWidget> createState() => _PackageDetailsWidgetState();
}

class _PackageDetailsWidgetState extends State<PackageDetailsWidget> {

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   initializeDateFormatting('bn', null);
  // }

  @override
  Widget build(BuildContext context) {
    int expireIn = widget.package.endDate.difference(widget.package.startDate).inDays;
    DateFormat dateFormat = DateFormat.yMMMd('bn');
    NumberFormat banglaNumberFormat = NumberFormat.decimalPattern('bn');
    // TODO: Implement logic to fetch package details based on the packageId

    return Scaffold(
      appBar: AppBar(
        title: const Text('প্যাকেজের বিস্তারিত'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 20),
              child: Center(
                child: Text(
                  widget.package.name,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),





            Row(
              children: [
                const Expanded(
                  flex: 2,
                  child: Text(
                    "পরীক্ষা",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Text(":  ${banglaNumberFormat.format(widget.package.noOfExam)} টি",
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
                    "পরীক্ষা সম্পন্ন",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Text(":  ${banglaNumberFormat.format(widget.package.noOfExamDone)} টি",
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
                    "পরীক্ষা বাকি",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Text(":  ${banglaNumberFormat.format(widget.package.noOfExam-widget.package.noOfExamDone)} টি",
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
                    "শুরু",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Text(":  ${dateFormat.format(widget.package.startDate)}",
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
                  child: Text(":  ${dateFormat.format(widget.package.startDate)}",
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
                    "মেয়াদ",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Text(":  $expireIn দিন",
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

            Text('${widget.package.description}'),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
