import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CentralLoading extends StatelessWidget {
  const CentralLoading({super.key});




  @override
  Widget build(BuildContext context) {
    return  Center(
      child: SpinKitSpinningLines(
        color: Theme.of(context).colorScheme.secondary,
        size: 60.0,
      ),
    );
  }
}
