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
  int? randomNum;
  TextEditingController? textEditingController;
  Uint8List? verifyImage;

  @override
  void initState() {
    super.initState();
    randomNum = Random().nextInt(999);
    textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    textEditingController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget child = Container();

    child = Column(
      children: [
        ElevatedButton(
            onPressed: getCertificateList,
            child: const Text('getCertificateList')),
        ElevatedButton(onPressed: getVerify, child: const Text('getVerify')),
        if (null != verifyImage)
          Container(
            height: 50,
            width: double.infinity,
            color: Colors.yellow,
            child: ExtendedImage.memory(
              verifyImage!,
              loadStateChanged: (ExtendedImageState state) {
                print('state: $state');
                print('loadState: ${state.extendedImageLoadState}');
                print('info: ${state.extendedImageInfo}');
              },
            ),
          ),
        ExtendedImage.asset('assets/images/getVerify.jpeg'),
        InkWell(
          // onTap: getVerify,
          child: ExtendedImage.network(
            'https://hk.sz.gov.cn:8118/user/getVerify?$randomNum',
            loadStateChanged: (ExtendedImageState state) {
              print('1state: $state');
              print('1loadState: ${state.extendedImageLoadState}');
              print('1info: ${state.extendedImageInfo}');
            },
            // width: ScreenUtil.instance.setWidth(400),
            // height: ScreenUtil.instance.setWidth(400),
            // fit: BoxFit.fill,
            // cache: true,
            // border: Border.all(color: Colors.red, width: 1.0),
            // shape: boxShape,
            // borderRadius: BorderRadius.all(Radius.circular(30.0)),
            //cancelToken: cancellationToken,
          ),
        ),
        // if(null != verifyImage) Image.memory(verifyImage!),
        TextField(
          controller: textEditingController,
        ),

        ElevatedButton(onPressed: login, child: const Text('login')),
        // Image.asset('assets/images/v1.png'),
        // Image.network('https://hk.sz.gov.cn:8118/user/getVerify?558'),
        // Image.network('https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fwww.sooopu.com%2Fmember%2FSooopuEdit1%2Fuploadfile%2F200906%2F20090609132638978.gif&refer=http%3A%2F%2Fwww.sooopu.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1647183303&t=409801a90d56650785cf8903f4b889f2'),
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
    // var random = Random();
    var result = await MyClient()
        .api
        ?.getVerify('${Random().nextInt(1000)}')
        .catchError((e) {
      print('e: $e');
    });
    print('result. ${result.runtimeType} ${(result as String).length}');
    print('result: $result ${result.runtimeType}');
    setState(() {
      verifyImage = Uint8List.fromList((result).codeUnits);
      print('result: ${verifyImage == null} ${verifyImage?.length}');
      // Uint8List.fromList((result).codeUnits).map((e) => print('e: $e'));
      print('resultx: ${result.codeUnits.sublist(0, 32)}');
      print('utf8: ${utf8.encoder.convert(result).sublist(0, 32)}');
      print('verifyImage: ${verifyImage?.sublist(0, 32)}');
    });
    var nextNum = Random().nextInt(999);
    while (nextNum == randomNum) {
      nextNum = Random().nextInt(999);
    }
    setState(() {
      randomNum = nextNum;
      print('randomNum: $randomNum');
    });
  }

  login() async {
    int certType = 4;
    String certNo = 'H04304428';
    String pwd = 'a63061977';
    String verifyCode = textEditingController!.text;

    print('certNo: $certNo');
    print('certNo: ${Utils.encodeBase64(certNo)}');
    print('ertNo: ${Utils.decodeBase64(Utils.encodeBase64(certNo))}');

    print('pwd: ${Utils.encodeBase64(pwd)}');
    print('pwd: ${Utils.encodeBase64(Utils.generateMd5(pwd))}');
    print('verifyCode: $verifyCode');
    var result = await MyClient()
        .api
        ?.login(certType, Utils.encodeBase64(certNo),
            Utils.encodeBase64(Utils.generateMd5(pwd)), verifyCode)
        .catchError((e) {
      print('e: $e');
    });
    print('result: $result');
  }
}
