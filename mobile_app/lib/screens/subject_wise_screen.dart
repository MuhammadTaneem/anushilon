import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mobile_app/Providers/mcq_provider.dart';
import 'package:mobile_app/widgets/read_mcq_screen.dart';
import 'package:provider/provider.dart';
import '../Database/context_data.dart';
import '../utils/show_message.dart';
import '../widgets/custom_form_label.dart';
import '../widgets/loader_widget.dart';

class SubjectWiseScreen extends StatefulWidget {
  static const routeName = '/subject_wise_screen';

  const SubjectWiseScreen({super.key});

  @override
  State<SubjectWiseScreen> createState() => _SubjectWiseScreenState();
}

class _SubjectWiseScreenState extends State<SubjectWiseScreen> {
  bool isFilterOpen = true;
  bool _autoValidate = false;
  String? _selectedSubject;
  String? _selectedSubjectKey;
  String? _selectedChapter;
  int limit = 25;
  // int offset = 0;
  int pageNumber = 0;
  final Map<String, dynamic> _subjects = ContextOptions().subjects;
  final GlobalKey<FormState> _subjectWiseFormKey = GlobalKey<FormState>();
  late Map<String, dynamic> selectedSubjectData;

  void _showISubjectsSelectOptions(BuildContext context) async {
    String? selectedSubject = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actionsPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          buttonPadding: EdgeInsets.zero,
          titlePadding: const EdgeInsets.only(left: 0),
          title: Container(
            color: Theme.of(context).colorScheme.primary,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text('সাব্জেক্ট  নির্বাচন',
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                    )),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          content: Container(
            padding: EdgeInsets.zero,
            height: MediaQuery.of(context).size.height * 0.6,
            width: double.maxFinite,
            child: Scrollbar(
              thickness: 5,
              child: ListView(
                shrinkWrap: true,
                children: _subjects.keys.map((String subject) {
                  return Container(
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.black12)),
                    ),
                    child: ListTile(
                      title: Text(subject),
                      onTap: () {
                        Navigator.pop(context, subject);
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
    if (selectedSubject != null) {
      setState(() {
        _selectedSubject = selectedSubject;
        _selectedChapter = null;
        selectedSubjectData = _subjects[_selectedSubject];
        _selectedSubjectKey = selectedSubjectData['name'];
        Provider.of<McqProvider>(context, listen: false).setSubjectKey(_selectedSubjectKey);

        _showIChapterSelectOptions(context);
      });
    }
  }

  void _showIChapterSelectOptions(BuildContext context) async {
    final Map<String, String> chapters = selectedSubjectData['chapters'];
    String? selectedChapter = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actionsPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          buttonPadding: EdgeInsets.zero,
          titlePadding: const EdgeInsets.only(left: 0),
          title: Container(
            color: Theme.of(context).colorScheme.primary,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text('অধ্যায় নির্বাচন',
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                    )),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          content: Container(
            padding: EdgeInsets.zero,
            height: MediaQuery.of(context).size.height * 0.6,
            width: double.maxFinite,
            child: Scrollbar(
              thickness: 5,
              child: ListView(
                shrinkWrap: true,
                children: chapters.keys.map((String chapter) {
                  return Container(
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.black12)),
                    ),
                    child: ListTile(
                      title: Text(chapter),
                      onTap: () {
                        Navigator.pop(context, chapter);
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
    if (selectedChapter != null) {
      setState(() {
        _selectedChapter = selectedChapter;
        Provider.of<McqProvider>(context, listen: false).setChapter(_selectedChapter);
        _subjectWiseFormKey.currentState?.reset();
      });
    }
  }

  _onSubmit() {
    isFilterOpen = false;
    Provider.of<McqProvider>(context, listen: false).loadMcq();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final  count = Provider.of<McqProvider>(context, listen: false).count;
    if(count<1){
      isFilterOpen = true;
    }
    else{
      isFilterOpen = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    late McqProvider _provider = Provider.of<McqProvider>(context, listen: true);
    pageNumber = _provider.getPage;



    return Scaffold(
      appBar: AppBar(
        title: const Text("বিষয় ভিত্তিক"),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.filter_alt,
            ),
            onPressed: () {
              setState(() {
                isFilterOpen = !isFilterOpen;
              });

            },
          ),
        ],
      ),
      body: Column(
        children: [
          if (isFilterOpen) ...[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Colors.white70,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    MediaQuery.of(context).size.width * 0.03,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                      key: _subjectWiseFormKey,
                      autovalidateMode: _autoValidate
                          ? AutovalidateMode.onUserInteraction
                          : AutovalidateMode.disabled,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'বিষয় ভিত্তিক প্রশ্ন',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                              ),
                            ),
                          ),
                          const CustomFromLabel(
                            label: "সাব্জেক্ট নির্বাচন",
                            isRequired: false,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'সাব্জেক্ট নির্বাচন',
                              suffixIcon: Icon(Icons.arrow_drop_down),
                            ),
                            onTap: () {
                              _showISubjectsSelectOptions(context);
                            },
                            readOnly: true,
                            controller:
                                TextEditingController(text: _selectedSubject),
                            validator: (value) {
                              return value == null || value.isEmpty
                                  ? 'This field is required'
                                  : null;
                            },
                          ),
                          const Gap(20),
                          const CustomFromLabel(
                            label: "অধ্যায়",
                            isRequired: false,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'অধ্যায় নির্বাচন করুন',
                              suffixIcon: Icon(Icons.arrow_drop_down),
                            ),
                            onTap: () {
                              if (_selectedSubject != null) {
                                _showIChapterSelectOptions(context);
                              } else {
                                showHintMessage(msg: "সাব্জেক্ট নির্বাচন করুন");
                                _showISubjectsSelectOptions(context);
                              }
                            },
                            readOnly: true,
                            controller:
                                TextEditingController(text: _selectedChapter),
                            validator: (value) {
                              return value == null || value.isEmpty
                                  ? 'This field is required'
                                  : null;
                            },
                          ),
                          const Gap(20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    FormState formState =
                                        _subjectWiseFormKey.currentState!;
                                    formState.save();
                                    formState.validate() ? _onSubmit() : null;
                                    setState(() {
                                      _autoValidate = true;
                                    });
                                  },
                                  style: ButtonStyle(
                                    minimumSize:
                                        MaterialStateProperty.all<Size>(
                                      Size(
                                          MediaQuery.of(context).size.width *
                                              0.9,
                                          50),
                                    ),
                                  ),
                                  child: const Text("Submit")),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                        ],
                      )),
                ),
              ),
            ),
          ],
          if(_provider.isLoading)...[
            const Expanded(
              child: Center(
                child: CentralLoading(),
              ),
            )
          ],
          if(!_provider.isLoading && _provider.count>0)...[
            ReadMcqScreen(screen: 'mcq')
          ],
          if(!_provider.isLoading && _provider.count==0 && !isFilterOpen )...[
            const Expanded( child: Center(child: Text("প্রশ্ন খুজে পাওয়া যায় নি")),)
          ],
          _provider.count>0?Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Adjust the alignment as needed
            children: [
              const Gap(10),
              if(pageNumber!=0)...[
                Expanded(
                  child: ElevatedButton(

                      onPressed: () {
                        pageNumber--;
                        Provider.of<McqProvider>(context, listen: false).setPage(pageNumber);
                        _onSubmit();

                        // Add your button 1 functionality here
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.arrow_back),
                          Text('Previous Page'),
                        ],
                      )
                  ),
                ),
                const Gap(10),

              ],
              if((pageNumber+1)*limit<_provider.count)...[
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        pageNumber++;
                        Provider.of<McqProvider>(context, listen: false).setPage(pageNumber);
                        _onSubmit();

                        // Add your button 2 functionality here
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Next Page'),
                          Icon(Icons.arrow_forward),
                        ],
                      )
                  ),
                ),
                const Gap(10),
              ]

            ],
          ):Container()

        ],
      ),
    );
  }
}
