import 'package:flutter/material.dart';
import 'package:hksz/api/api.dart';

class LoginUI extends StatefulWidget {
  const LoginUI({Key? key}) : super(key: key);

  @override
  _LoginUIState createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
  @override
  Widget build(BuildContext context) {
    Widget child = Container();

    child = Column(
      children: [
        ElevatedButton(onPressed: getCertificateList, child: const Text('test')),
      ],
    );

    child = Center(
      child: child,
    );

    child = Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: child,
    );
    return child;
  }

  getCertificateList() async {
    var result = await MyClient().api?.getCertificateList().catchError((e) {
      print('e: $e');
    });
    print('result: $result');
  }
}
