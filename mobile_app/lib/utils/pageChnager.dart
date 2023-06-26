import 'package:flutter/cupertino.dart';

class PageChanger extends StatefulWidget {
  final String routename;
  const PageChanger({super.key, required this.routename});

  @override
  State<PageChanger> createState() => _PageChangerState();
}

class _PageChangerState extends State<PageChanger> {
  void pageChange() {
    if (mounted) {
      Navigator.pushReplacementNamed(context, widget.routename);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageChange();

  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();

  }
}
