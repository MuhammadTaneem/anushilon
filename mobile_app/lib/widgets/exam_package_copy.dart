import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ExamPackageWidget extends StatefulWidget {
  final int  examPackageId;
  final int?  examPackageLiveExamId;
  final String?  title;
  const ExamPackageWidget({super.key, required this.examPackageId, this.title, this.examPackageLiveExamId});

  @override
  State<ExamPackageWidget> createState() => _ExamPackageWidgetState();
}

class _ExamPackageWidgetState extends State<ExamPackageWidget> with SingleTickerProviderStateMixin {

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Create an AnimationController to control the blinking effect
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    // Create a curved animation to make the blinking effect smoother
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    // Start the animation (blinking)
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    // Don't forget to dispose the animation controller when the widget is removed from the tree
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> cardNames = [ 'রুটিন','শিক্ষা উপকরণ', 'আর্কাইভ', 'মেরিট লিস্ট'];
    List<Widget> cardIcons = [
      Icon(Icons.calendar_month_outlined, color: Theme.of(context).colorScheme.primary, size: 55,),
      Icon(Icons.local_library, color: Theme.of(context).colorScheme.primary,size: 55),
      Icon(Icons.archive, color: Theme.of(context).colorScheme.primary,size: 55),
      Icon(Icons.emoji_events, color: Theme.of(context).colorScheme.primary,size: 55)];

    return Scaffold(
      appBar: widget.title !=null?AppBar(
        title: FittedBox(fit: BoxFit.scaleDown ,child: Text(widget.title!)),
        centerTitle: true,
      ):null,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 10),
        child: Column(
          children: [
            const Gap(5),
            Row(
              children: [
                Expanded(
                  child: Stack(
                    fit: StackFit.passthrough,
                    alignment: Alignment.topRight,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          widget.examPackageLiveExamId == null ?
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("পরিক্ষা নেই"),
                                content: const Text("এই প্যাকেজের আজকে কোন পরিক্ষা নেই, পরবর্তী পরিক্ষা শিডিউল দেখতে রুটিনে ক্লিক করুন"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("OK"),
                                  ),
                                ],
                              );
                            },
                          ): Container();
                        },
                        child: const Text("Live Exam"),
                      ),
                      // Visibility(
                      //   visible: widget.examPackageLiveExamId != null,
                      //   child: AnimatedBuilder(
                      //     animation: _animation,
                      //     builder: (context, child) {
                      //       return Transform.scale(
                      //         scale: _animation.value,
                      //         child: Container(
                      //           width: 10,
                      //           height: 10,
                      //           decoration: BoxDecoration(
                      //             color: Colors.red,
                      //             shape: BoxShape.circle,
                      //           ),
                      //         ),
                      //       );
                      //     },
                      //   ),
                      // ),

                      Visibility(
                        visible: widget.examPackageLiveExamId != null,
                        child: AnimatedBuilder(
                          animation: _animation,
                          builder: (context, child) {
                            return Positioned(
                              right: 0, // Adjust the right value to set the desired distance from the right edge
                              top: 4, // Adjust the top value to set the desired distance from the top edge
                              child: Transform.scale(
                                scale: _animation.value,
                                child: Container(
                                  width: 15,
                                  height: 15,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            ),


            const Gap(20),
            Card(
              elevation: 0.1,
              color: Colors.orange.shade50,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("• লাইভ এক্সাম বাটনে ক্লিক করে আজকের চলমান পরিক্ষায় অংশ গ্রহন করুন "
                    "\n\n• পরবর্তী পরিক্ষার সিডিউল জানার জন্য রুটিন এবং পূর্ববর্তী পরিক্ষার সমূহ দেখতে আর্কাইভে ক্লিক করুন"
                    "\n\n• এই প্যকেজের আওতাওভুক্ত ছবি, পিডিএফ পেতে শিক্ষা উপকরণ চাপুন"
                    "\n\n• মেধা তালিকা দেখতে মেরিট লিস্টে ক্লিক করুন"
                ),
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
