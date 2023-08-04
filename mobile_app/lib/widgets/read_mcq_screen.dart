import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:mobile_app/Providers/favorite_provider.dart';
import 'package:mobile_app/Providers/mcq_provider.dart';
import 'package:provider/provider.dart';
import '../schema/mcq_schema.dart';

class ReadMcqScreen extends StatefulWidget {
  final String screen;

  const ReadMcqScreen({Key? key, required this.screen}) : super(key: key);

  @override
  _ReadMcqScreenState createState() => _ReadMcqScreenState();
}

class _ReadMcqScreenState extends State<ReadMcqScreen> {
  late List<bool> showAnswers;
  late List<bool> showExplanation;
  String bulletPoint = "\u2022";
  late List<McqType> mcqList = [];

  makeFavorite(mcq) {
    Provider.of<FavoriteProvider>(context, listen: false).addItem(mcq);
  }

  removeFavorite(mcqId) {
    Provider.of<FavoriteProvider>(context, listen: false).deleteItem(mcqId);
  }

  @override
  void initState() {
    super.initState();
    if (widget.screen == 'favorite') {
      mcqList = Provider.of<FavoriteProvider>(context, listen: false).items;
      showAnswers = List<bool>.filled(mcqList.length, false);
      showExplanation = List.from(showAnswers);
    } else {
      mcqList = Provider.of<McqProvider>(context, listen: false).items;
      showAnswers = List<bool>.filled(mcqList.length, false);
      showExplanation = List.from(showAnswers);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        shrinkWrap: true,
        itemCount: mcqList.length,
        separatorBuilder: (BuildContext context, int index) =>
        const Gap(10),
        itemBuilder: (context, index) {
          return Card(
            elevation: 0.8,
            margin:const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (mcqList[index].imageUrl != null)
                    CachedNetworkImage(
                      imageUrl: mcqList[index].imageUrl!,
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
                    mcqList[index].question,
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 18.0,
                    ),
                  ),

                  ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: mcqList[index].options.length,
                    itemBuilder: (context, optionIndex) {
                      final option = mcqList[index].options[optionIndex];

                      return Row(
                        children: [
                          Radio(
                            visualDensity: VisualDensity.compact,
                            value: option.correct && showAnswers[index],
                            groupValue: true,
                            onChanged: showAnswers[index] ? (_) {} : null,
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
                                    placeholder: (context, url) =>
                                        SpinKitSpinningLines(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          size: 60.0,
                                        ),
                                    fit: BoxFit.cover,
                                    errorWidget: (context, url, error) =>
                                        ErrorWidget(error),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(
                          mcqList[index].isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          setState(() {
                            mcqList[index].isFavorite = !mcqList[index].isFavorite;
                            if (mcqList[index].isFavorite) {
                              makeFavorite(mcqList[index]);
                            } else {
                              removeFavorite(mcqList[index].id);
                            }
                          });
                        },
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            showAnswers[index] = !showAnswers[index];
                          });
                        },
                        icon: Icon(
                          showAnswers[index]
                              ? Icons.visibility_off
                              : Icons.remove_red_eye,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            showExplanation[index] =
                            !showExplanation[index];
                          });
                        },
                        icon: Icon(
                          showExplanation[index]
                              ? Icons.explore_off
                              : Icons.explore,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),
                  if (showExplanation[index])
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // SizedBox(height: 8.0),
                        Text(
                          'উত্তর : ${mcqList[index].options.where((option) => option.correct).map((option) => option.text).join(', ')}',
                          style: const TextStyle(fontStyle: FontStyle.italic),
                        ),
                        if (mcqList[index].explanationImgUrl != null)
                          CachedNetworkImage(
                            imageUrl: mcqList[index].explanationImgUrl!,
                            width: double.infinity,
                            height: 100.0,
                            placeholder: (context, url) =>
                                SpinKitSpinningLines(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondary,
                                  size: 60.0,
                                ),
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) =>
                                ErrorWidget(error),
                          ),
                        // SizedBox(height: 8.0),
                        Text(
                          'বিবরণ : \n${mcqList[index].explanation}',
                          style: const TextStyle(fontStyle: FontStyle.italic),
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
