import 'package:flutter/material.dart';
import 'exam_package.dart';

class ExamPackageView extends StatelessWidget {
  final String category;
  const ExamPackageView({super.key, required this.category});

  @override
  Widget build(BuildContext context) {

    var items = ['sdfsa','asdfadsfdasf','asfdasdfsf',];
    return GridView.builder(
      shrinkWrap: true,
      // physics: NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ExamPackageWidget(examPackageId: 1, title:  items[index],),
              ),
            );

            // _onCardTap(cardNames[index]);
          },
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                // Icon(Icons.access_time_rounded, size: 60,color: Theme.of(context).colorScheme.primary,),
                Text(
                  items[index],
                  style: TextStyle(fontSize: 24.0),
                ),
              ],
            ),

          ),
        );
      },
    );
  }
}
