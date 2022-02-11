import 'package:flutter/material.dart';
import 'package:hksz/api/api.dart';
import 'dart:math';
import 'package:extended_image/extended_image.dart';

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
        ElevatedButton(onPressed: getVerify, child: const Text('getVerify')),
        ExtendedImage.network(
          'https://hk.sz.gov.cn:8118/user/getVerify?559',
          // width: ScreenUtil.instance.setWidth(400),
          // height: ScreenUtil.instance.setWidth(400),
          // fit: BoxFit.fill,
          // cache: true,
          // border: Border.all(color: Colors.red, width: 1.0),
          // shape: boxShape,
          // borderRadius: BorderRadius.all(Radius.circular(30.0)),
          //cancelToken: cancellationToken,
        ),
        // Image.asset('assets/images/v1.png'),
        Image.network('https://hk.sz.gov.cn:8118/user/getVerify?558'),
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
    var result = await MyClient().api?.getCertificateList().catchError((e) {
      print('e: $e');
    });
    print('result: $result');
  }

  getVerify() async {
    var random = Random();
    var result = await MyClient().api?.getVerify('${random.nextInt(1000)}').catchError((e) {
      print('e: $e');
    });
    print('result: $result');
  }
}
