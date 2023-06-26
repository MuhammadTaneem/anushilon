import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../schema/mcq_schema.dart';

class ReadMcqScreen extends StatefulWidget {
  final List<McqType> mcqList;

  const ReadMcqScreen({required this.mcqList});

  @override
  _ReadMcqScreenState createState() => _ReadMcqScreenState();
}

class _ReadMcqScreenState extends State<ReadMcqScreen> {
  late List<bool> showAnswers;
  late List<bool> showExplanation;

  @override
  void initState() {
    super.initState();
    showAnswers = List<bool>.filled(widget.mcqList.length, false);
    showExplanation = List.from(showAnswers);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: widget.mcqList.length,
        itemBuilder: (context, index) {
          final mcq = widget.mcqList[index];
          return Card(
            elevation: 0.8,
            margin: const EdgeInsets.all(8.0),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (mcq.imageUrl != null)
                    CachedNetworkImage(
                      imageUrl: mcq.imageUrl!,
                      width: double.infinity,
                      height: 200.0,
                      placeholder: (context, url) => SpinKitSpinningLines(
                        color: Theme.of(context).colorScheme.secondary,
                        size: 60.0,
                      ),
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) => ErrorWidget(error),
                    ),

                  Text(
                    mcq.question,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 18.0,
                    ),
                  ),
                  // SizedBox(height: 8.0),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: mcq.options.length,
                    itemBuilder: (context, optionIndex) {
                      final option = mcq.options[optionIndex];
                      return Row(
                        children: [
                          if (mcq.multiChose)
                            Checkbox(
                              value: option.correct && showAnswers[index],
                              onChanged: showAnswers[index]?(_){}:null,
                            ),
                          if (!mcq.multiChose)
                            Radio(
                              visualDensity: VisualDensity.compact,
                              value: option.correct && showAnswers[index],
                              groupValue: true,
                              // Provide the appropriate group value here
                              onChanged: showAnswers[index]?(_){}:null,
                            ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (option.text != null) Text(option.text!),


                                if (option.imageUrl != null)

                                  CachedNetworkImage(
                                    imageUrl: option.imageUrl!,
                                    width: double.infinity,
                                    height: 100.0,
                                    placeholder: (context, url) => SpinKitSpinningLines(
                                      color: Theme.of(context).colorScheme.secondary,
                                      size: 60.0,
                                    ),
                                    fit: BoxFit.cover,
                                    errorWidget: (context, url, error) => ErrorWidget(error),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  // const SizedBox(height: 2.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(
                          mcq.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          setState(() {
                            mcq.isFavorite = !mcq.isFavorite;
                          });
                        },
                      ),
                      IconButton(onPressed: () {
                      setState(() {
                      showAnswers[index] = !showAnswers[index];
                      });
                      }, icon:Icon( showAnswers[index] ?
                      Icons.visibility_off : Icons.remove_red_eye ,
                        color: Theme.of(context).colorScheme.secondary,
                      ),),
                      IconButton(onPressed: () {
                        setState(() {
                          showExplanation[index] = !showExplanation[index];
                        });
                      }, icon:Icon( showExplanation[index] ?
                      Icons.explore_off : Icons.explore ,
                        color: Theme.of(context).colorScheme.secondary,
                      ),),
                    ],
                  ),
                  if (showExplanation[index])
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // SizedBox(height: 8.0),
                        Text(
                          'উত্তর : ${mcq.options.where((option) => option.correct).map((option) => option.text).join(', ')}',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                        if (mcq.explanationImgUrl != null)
                          CachedNetworkImage(
                            imageUrl: mcq.explanationImgUrl!,
                            width: double.infinity,
                            height: 100.0,
                            placeholder: (context, url) => SpinKitSpinningLines(
                              color: Theme.of(context).colorScheme.secondary,
                              size: 60.0,
                            ),
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) => ErrorWidget(error),
                          ),
                        // SizedBox(height: 8.0),
                        Text(
                          'বিবরণ : ${mcq.explanation}',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ],
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
