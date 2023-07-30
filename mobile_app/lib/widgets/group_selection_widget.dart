import 'package:flutter/material.dart';

import '../services/profile_service.dart';

String? selectedGroup;
final List<String> groups = ['arts', 'science', 'commerce'];


void groupSelectionWidget(BuildContext context) async {

  Future.delayed(Duration.zero, () async {
    await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          actionsPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          buttonPadding: EdgeInsets.zero,
          titlePadding: const EdgeInsets.symmetric (vertical: 0),
          title: Container(
            padding: const EdgeInsets.symmetric (vertical: 10),
            color: Theme.of(context).colorScheme.primary,
            child: const FittedBox(
                fit: BoxFit.scaleDown,
                child: Text('Select Your Group',style: TextStyle(color: Colors.white, fontSize: 16))),
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
                        updateProfile({
                          'group': item,
                        });
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
  });

}