import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  final bool bShow;
  const Loading({Key? key, this.bShow = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child = Center(
      child: bShow ? const CircularProgressIndicator() : Container(),
    );

    child = Container(
      width: 50,
      height: 50,
      child: child,
    );

    return child;
  }
}
