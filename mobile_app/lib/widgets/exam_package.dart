import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mobile_app/widgets/give_exam_widget.dart';

class ExamPackageWidget extends StatefulWidget {
  final int examPackageId;
  final int? examPackageLiveExamId;
  final int? submitted;
  final String? title;

  const ExamPackageWidget(
      {super.key,
      required this.examPackageId,
      this.title,
      this.examPackageLiveExamId, this.submitted});

  @override
  State<ExamPackageWidget> createState() => _ExamPackageWidgetState();
}

class _ExamPackageWidgetState extends State<ExamPackageWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(_controller);
    _animation = Tween<double>(begin: 1.0, end: 0.5).animate(_controller);


    if(widget.submitted==null &&widget.examPackageLiveExamId != null){
      _controller.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> cardNames = [
      'রুটিন',
      'শিক্ষা উপকরণ',
      'আর্কাইভ',
      'মেরিট লিস্ট'
    ];
    List<Widget> cardIcons = [
      Icon(
        Icons.calendar_month_outlined,
        color: Theme.of(context).colorScheme.primary,
        size: 55,
      ),
      Icon(Icons.local_library,
          color: Theme.of(context).colorScheme.primary, size: 55),
      Icon(Icons.archive,
          color: Theme.of(context).colorScheme.primary, size: 55),
      Icon(Icons.emoji_events,
          color: Theme.of(context).colorScheme.primary, size: 55)
    ];

    return Scaffold(
      appBar: widget.title != null
          ? AppBar(
              title:
                  FittedBox(fit: BoxFit.scaleDown, child: Text(widget.title!)),
              centerTitle: true,
            )
          : null,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Column(
          children: [
            const Gap(5),
            Row(
              children: [
                Expanded(
                  child: AnimatedBuilder(
                    animation: _scaleAnimation,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _scaleAnimation.value,
                        child: ElevatedButton(
                          onPressed: () {
                            widget.examPackageLiveExamId != null
                                ? widget.submitted == null? Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => GiveExamWidget(
                                        examId:
                                            widget.examPackageLiveExamId ?? 0)))
                            :showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("অংশ গ্রহন করেছেন"),
                                  content: const Text(
                                      "এই পরিক্ষায় আজকে আপনি অংশ গ্রহন করেছেন, ফলাফল প্রকাশ হবার পর আপনি পুনঃরায় পরিক্ষা দিতে পারবেন।"),
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
                            )
                                : showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text("পরিক্ষা নেই"),
                                        content: const Text(
                                            "এই প্যাকেজের আজকে কোন পরিক্ষা নেই, পরবর্তী পরিক্ষা শিডিউল দেখতে রুটিনে ক্লিক করুন"),
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
                                  );
                          },
                          child: Stack(
                            // Wrap the Row with a Stackwid
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Text("Live Exam"),
                              ),
                              Visibility(
                                visible: widget.examPackageLiveExamId != null && widget.submitted == null,
                                child: AnimatedBuilder(
                                  animation: _animation,
                                  builder: (context, child) {
                                    return Positioned(
                                      left: 0,
                                      top: 2,
                                      child: Transform.scale(
                                        scale: _animation.value,
                                        child: Container(
                                          width: 15,
                                          height: 15,
                                          decoration: const BoxDecoration(
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
                      );
                    },
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
                child: Text(
                    "• লাইভ এক্সাম বাটনে ক্লিক করে আজকের চলমান পরিক্ষায় অংশ গ্রহন করুন "
                    "\n\n• পরবর্তী পরিক্ষার সিডিউল জানার জন্য রুটিন এবং পূর্ববর্তী পরিক্ষার সমূহ দেখতে আর্কাইভে ক্লিক করুন"
                    "\n\n• এই প্যকেজের আওতাওভুক্ত ছবি, পিডিএফ পেতে শিক্ষা উপকরণ চাপুন"
                    "\n\n• মেধা তালিকা দেখতে মেরিট লিস্টে ক্লিক করুন"),
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
