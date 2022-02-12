import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hksz/api/api.dart';
import 'dart:math';
import 'package:extended_image/extended_image.dart';
import 'package:hksz/utils/utils.dart';

class LoginUI extends StatefulWidget {
  const LoginUI({Key? key}) : super(key: key);

  @override
  _LoginUIState createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
  TextEditingController? textEditingController;
  Uint8List? verifyImage;
  String? result;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
    _fetchData();
  }

  @override
  void dispose() {
    super.dispose();
    textEditingController?.dispose();
  }

  _fetchData() async {
    getCertificateList();
    getVerify();
  }

  @override
  Widget build(BuildContext context) {
    Widget child = Container();

    child = Column(
      children: [
        ElevatedButton(onPressed: _fetchData, child: const Text('refresh')),
        // ElevatedButton(onPressed: getCertificateList, child: const Text('getCertificateList')),
        // ElevatedButton(onPressed: getVerify, child: const Text('getVerify')),
        if (null != verifyImage)
          InkWell(
            onTap: getVerify,
            child: Container(
              height: 50,
              width: double.infinity,
              // color: Colors.yellow,
              child: ExtendedImage.memory(
                verifyImage!,
                loadStateChanged: (ExtendedImageState state) {
                  print('state: $state');
                  print('loadState: ${state.extendedImageLoadState}');
                  print('info: ${state.extendedImageInfo}');
                },
              ),
            ),
          ),
        TextField(
          controller: textEditingController,
          keyboardType: TextInputType.text,
          inputFormatters: [],
        ),

        ElevatedButton(onPressed: login, child: const Text('login')),
        ElevatedButton(onPressed: getUserInfo, child: const Text('getUserInfo')),
        ElevatedButton(onPressed: logout, child: const Text('logout')),

        ElevatedButton(onPressed: isCanReserve, child: const Text('isCanReserve')),
        ElevatedButton(onPressed: getCheckInDate, child: const Text('getCheckInDate')),
        ElevatedButton(onPressed: getReserveOrderInfo, child: const Text('getReserveOrderInfo')),
        Text(
          '$result',
          style: TextStyle(
            color: Colors.red,
          ),
        )
      ],
    );

    child = SingleChildScrollView(
      child: child,
    );

    // child = Center(
    //   child: child,
    // );

    child = Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: child,
    );
    return child;
  }

  getCertificateList() async {
    String test = 'tfif';
    print('test: $test');
    print('${test.codeUnits}');
    print('${Uint8List.fromList(test.codeUnits)}');

    test.codeUnits.map((e) => print('e: $e'));
    // Uint8List.fromList(test.codeUnits)

    var result = await MyClient().api?.getCertificateList().catchError((e) {
      print('e: $e');
    });
    print('result: $result');
  }

  getVerify() async {
    var result = await MyClient().api?.getVerify('${Random().nextDouble()}').catchError((e) {
      print('e: $e');
    });
    // print('result. ${result.runtimeType}');
    // print('result: $result ${result.runtimeType}');

    setState(() {
      verifyImage = result;
    });
    // var nextNum = Random().nextInt(999);
    // while (nextNum == randomNum) {
    //   nextNum = Random().nextInt(999);
    // }
    // setState(() {
    //   randomNum = nextNum;
    //   print('randomNum: $randomNum');
    // });
  }

  login() async {
    int certType = 4;
    String certNo = 'H04304428';
    String pwd = 'a63061977';
    String verifyCode = textEditingController!.text;

    // print('certNo: $certNo');
    // print('certNo: ${Utils.encodeBase64(certNo)}');
    // print('ertNo: ${Utils.decodeBase64(Utils.encodeBase64(certNo))}');
    //
    // print('pwd: ${Utils.encodeBase64(pwd)}');
    // print('pwd: ${Utils.encodeBase64(Utils.generateMd5(pwd))}');
    // print('verifyCode: $verifyCode');
    var result = await MyClient()
        .api
        ?.login(certType, Utils.encodeBase64(certNo), Utils.encodeBase64(Utils.generateMd5(pwd)), verifyCode)
        .catchError((e) {
      print('e: $e');
    });
    print('result: $result');
  }

  logout() async {}

  getUserInfo() async {
    var result = await MyClient().api?.getUserInfo().catchError((e) {
      print('e: $e');
    });
    print('result: $result');
  }

  isCanReserve() async {
    var result = await MyClient().api?.isCanReserve().catchError((e) {
      print('e: $e');
    });
    print('result: $result');
  }

  getCheckInDate() async {
    var result = await MyClient().api?.getCheckInDate().catchError((e) {
      print('e: $e');
    });
    print('result: $result');
  }

  getReserveOrderInfo() async {
    var result = await MyClient().api?.getReserveOrderInfo().catchError((e) {
      print('e: $e');
    });
    print('result: $result');
  }
}
