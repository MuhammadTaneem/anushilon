import 'package:flutter/material.dart';
import 'package:mobile_app/Providers/exam_package_provider.dart';
import 'package:mobile_app/schema/exam_package_schema.dart';
import 'package:mobile_app/widgets/loader_widget.dart';
import 'package:provider/provider.dart';
import 'exam_package.dart';

class ExamPackageView extends StatefulWidget {
  final String category;

  const ExamPackageView({super.key, required this.category});

  @override
  State<ExamPackageView> createState() => _ExamPackageViewState();
}

class _ExamPackageViewState extends State<ExamPackageView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ExamPackageProvider>(context, listen: false)
          .loadPackage(widget.category);
    });
  }

  @override
  Widget build(BuildContext context) {
    ExamPackageProvider _provider =Provider.of<ExamPackageProvider>(context, listen: true);
    return Scaffold(
      body: _provider.isLoading
          ? CentralLoading()
          : _provider.items.length < 1
              ? Center(child: Text("এই মডিউলে কোন প্যাকেজ নাই"))
              : GridView.builder(
                  shrinkWrap: true,
                  // physics: NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: _provider.items.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ExamPackageWidget(
                              examPackageId: _provider.items[index].id,
                              title: _provider.items[index].name,
                              examPackageLiveExamId:
                                  _provider.items[index].examId,
                              submitted: _provider.items[index].submitted
                            ),
                          ),
                        );

                        // _onCardTap(cardNames[index]);
                      },
                      child: Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Icon(Icons.access_time_rounded, size: 60,color: Theme.of(context).colorScheme.primary,),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                _provider.items[index].name,
                                maxLines: 3,
                                style: const TextStyle(fontSize: 24.0,
                                  overflow:TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
