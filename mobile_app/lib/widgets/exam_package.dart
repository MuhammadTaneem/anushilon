import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ExamPackageWidget extends StatelessWidget {
  final int  examPackageId;
  final String?  title;
  const ExamPackageWidget({super.key, required this.examPackageId, this.title});

  @override
  Widget build(BuildContext context) {
    List<String> cardNames = [ 'রুটিন','শিক্ষা উপকরণ', 'আর্কাইভ', 'মেরিট লিস্ট'];
    List<Widget> cardIcons = [
      Icon(Icons.calendar_month_outlined, color: Theme.of(context).colorScheme.primary, size: 55,),
      Icon(Icons.local_library, color: Theme.of(context).colorScheme.primary,size: 55),
      Icon(Icons.archive, color: Theme.of(context).colorScheme.primary,size: 55),
      Icon(Icons.emoji_events, color: Theme.of(context).colorScheme.primary,size: 55)];

    return Scaffold(
      appBar: title !=null?AppBar(
        title: FittedBox(fit: BoxFit.scaleDown ,child: Text(title!)),
        centerTitle: true,
      ):null,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 10),
        child: Column(
          children: [
            const Gap(5),
            Row(
              children: [
                Expanded(child: ElevatedButton(onPressed: (){}, child: const Text( "Live Exam"))),
              ],
            ),
            const Gap(20),
            Card(
              elevation: 0.1,
              color: Colors.orange.shade50,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("• NOtifcion pagelasdfadsf NOtifcion pagelasdfadsf "
                    "\n • NOtifcion pagelasdfadsf NOtifcion pagelasdfadsf NOtifcion pagelasdfadsf NOtifcion "
                    "sf NOtifcion pagelasdfadsf NOtifcion pagelasdfadsf NOtifcion pagelasdfadsf "),
              ),
            ),
            const Gap(20),
            GridView.builder(
              shrinkWrap: true,
              // physics: NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: cardNames.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    // _onCardTap(cardNames[index]);
                  },
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        cardIcons[index],
                        // Icon(Icons.access_time_rounded, size: 60,color: Theme.of(context).colorScheme.primary,),
                         Text(
                           cardNames[index],
                           style: TextStyle(fontSize: 24.0),
                         ),
                      ],
                    ),

                  ),
                );
              },
            ),

          ],
        ),
      ),
    );
  }
}
