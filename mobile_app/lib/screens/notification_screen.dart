import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/notification_provider.dart';
import '../schema/notification_schema.dart';

class NotificationScreen extends StatefulWidget {

  static const routeName = '/notification';
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  List<int>_clicked = [];

  @override
  Widget build(BuildContext context) {
    List<NotificationType> items = Provider.of<NotificationProvider>(context, listen: true).items;

    return Scaffold(
      appBar: AppBar(title: const Text("নোটিফিকেশন"),) ,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10,),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final item = items[index];
                return Container(
                  color: _clicked.contains(index) ? Colors.grey.shade200: Colors.transparent,
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                  child: InkWell(
                    onTap: () {
                      print("clicked");
                      print(_clicked);
                      setState(() {
                        _clicked.contains(index) ? _clicked.remove(index):_clicked.add(index);
                      });
                    },

                    child: ListTile(

                      leading: const Icon(Icons.circle_notifications),
                      title: Text(item.title),
                      subtitle: _clicked.contains(index) ? Text(item.description): null,
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 0,child: Divider(),),
              itemCount: items.length,
            ),
            const Divider(thickness: 5,),
          ],
        ),
      ),
    );
  }
}
