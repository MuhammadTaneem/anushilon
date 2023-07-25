import 'package:flutter/material.dart';
import 'package:mobile_app/profile/profile_service.dart';


class GroupSelectionScreen extends StatefulWidget {
  const GroupSelectionScreen({super.key});
  static const routeName = '/select_group_screen';

  @override
  State<GroupSelectionScreen> createState() => _GroupSelectionScreenState();
}

class _GroupSelectionScreenState extends State<GroupSelectionScreen> {
  String? selectedGroup;
  final List<String> groups = ['arts', 'science', 'commerce'];


  void _showIncomeSourceMenu(BuildContext context) async {
    String? selectedCategory = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actionsPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          buttonPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0), // Set a custom border radius
          ),

          titlePadding: const EdgeInsets.only(left: 0),
          title: Container(
            color: Theme.of(context).colorScheme.primary,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [


                FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text('Select Your Group',style: TextStyle(color: Colors.white, fontSize: 16)),
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
            width: double.maxFinite,
            child: Scrollbar(
              thickness: 5,
              child: ListView(
                shrinkWrap: true,
                children: groups.map((String item) {
                  return Container(
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.black12)),
                    ),
                    child: ListTile(
                      title: Text(item),
                      onTap: () {
                        Navigator.pop(context, item);
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
    if (selectedCategory != null) {
      setState(() {
        updateProfile(selectedCategory);
        selectedGroup = selectedCategory;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    late double dvHeight = MediaQuery.of(context).size.height;
    late double dvWight = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Select a group'),
      ),
      body:Center(
        child: Container(
          width: dvWight*.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: groups
                .map((group) => RadioListTile<String>(
              title: Text(group),
              value: group,
              groupValue: selectedGroup,
              onChanged: (value) {
                setState(() {
                  selectedGroup = value;
                });
              },
            ))
                .toList(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showIncomeSourceMenu(context);
        //   if (selectedGroup != null) {
        //     print(selectedGroup);
        //   }
        },
        child: Icon(Icons.check),
      ),
    );
  }
}