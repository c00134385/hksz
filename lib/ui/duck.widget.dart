import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:typed_data';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:hksz/api/api.dart';
import 'package:hksz/mixin/mixin.dart';
import 'package:hksz/model/models.dart';
import 'package:hksz/utils/utils.dart';
import 'common.widgets.dart';
import 'package:intl/intl.dart';

class DuckWidget extends StatefulWidget {
  final UserAccount userAccount;
  const DuckWidget({
    Key? key,
    required this.userAccount,
  }) : super(key: key);

  @override
  _DuckWidgetState createState() => _DuckWidgetState();
}

class _DuckWidgetState extends State<DuckWidget> with TimerTaskStateMixin {
  @override
  Widget build(BuildContext context) {
    Widget child = Container();

    child = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AccountItem(
          account: widget.userAccount,
        ),
        InkWell(
          onTap: getVerify,
          child: (null != verifyImage)
              ? ExtendedImage.memory(
                  verifyImage!,
                  loadStateChanged: (ExtendedImageState state) {
                    // print('state: $state');
                    print('loadState: ${state.extendedImageLoadState}');
                    print('info: ${state.extendedImageInfo}');
                  },
                  height: 80,
                  // width: 280,
                  fit: BoxFit.fill,
                )
              : Container(
                  height: 50,
                ),
        ),
        Container(
          width: 150,
          child: TextField(
            controller: textEditingController,
            keyboardType: TextInputType.text,
          ),
        ),
        Wrap(
          children: [
            ElevatedButton(onPressed: login, child: const Text('login')),
            ElevatedButton(onPressed: logout, child: const Text('logout')),
            ElevatedButton(
                onPressed: getUserInfo, child: const Text('getUserInfo')),
            ElevatedButton(
                onPressed: isCanReserve, child: const Text('isCanReserve')),
            ElevatedButton(
                onPressed: getDistrictHouseList,
                child: const Text('getDistrictHouseList')),
            ElevatedButton(
                onPressed: () {
                  startTimer();
                  setState(() {
                    print('isTimerActive: $isTimerActive');
                  });
                },
                child: const Text('start task')),
            ElevatedButton(
                onPressed: () {
                  cancelTimer();
                  setState(() {
                    print('isTimerActive: $isTimerActive');
                  });
                }, child: const Text('stop task')),

          ],
        ),
        // Column(
        //   mainAxisSize: MainAxisSize.min,
        //   children: rooms!.map((e) {
        //     Widget child = RoomItem(roomInfo: e);
        //     child = InkWell(
        //       child: child,
        //       onTap: () => confirmOrder(e),
        //     );
        //     child = Padding(
        //       child: child,
        //       padding: EdgeInsets.only(top: 10),
        //     );
        //     return child;
        //   }).toList(),
        // ),
        Icon(
          isTimerActive ? Icons.lightbulb : Icons.lightbulb_outline_rounded,
          color: isTimerActive ? Colors.yellow : Colors.grey,
        ),
        Container(
          color: Colors.yellow,
          constraints: BoxConstraints(maxHeight: 80),
          child: Text(
            '$_result',
            style: const TextStyle(color: Colors.red),
          ),
        ),

      ],
    );

    child = Container(
      child: child,
      // color:
      //     Colors.primaries[hashCode % Colors.primaries.length].withOpacity(0.5),
      // constraints: BoxConstraints(maxWidth: 100),
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        border: const Border(
            bottom: const BorderSide(color: Colors.grey, width: 1.0)),
      ),
    );

    return child;
  }

  TextEditingController? textEditingController;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
    myClient = MyClient();
    // getCertificateList();
    getVerify();
  }

  MyClient? myClient;
  String? _result;
  Uint8List? verifyImage;
  List<RoomInfo>? rooms = List.empty();

  getVerify() async {
    var result = await myClient?.api
        ?.getVerify('${Random().nextDouble()}')
        .catchError((e) {
      print('e: $e');
    });

    setState(() {
      verifyImage = result;
    });
  }

  login() async {
    int certType = widget.userAccount.certificate?.id ?? 4;
    String certNo = widget.userAccount.certNo ?? '';
    String pwd = widget.userAccount.pwd ?? '';
    String verifyCode = textEditingController!.text;
    print(
        'certType: $certType  certNo: $certNo pwd: $pwd verifyCode: $verifyCode');
    var result = await myClient?.api
        ?.login(certType, Utils.encodeBase64(certNo),
            Utils.encodeBase64(Utils.generateMd5(pwd)), verifyCode)
        .catchError((e) {
      print('e: $e');
    });

    if (result?.status == 200) {
      textEditingController?.clear();
      getVerify();
    }
    setState(() {
      print('result: $result');
      _result = '$result';
    });
  }

  logout() async {
    var result = await myClient?.api?.logout().catchError((e) {
      print('e: $e');
      _result = e;
    });
    setState(() {
      print('result: $result');
      // _result = '$result';
    });
  }

  getUserInfo() async {
    var result = await myClient?.api?.getUserInfo().catchError((e) {
      print('e: $e');
    });
    setState(() {
      print('result: $result');
      _result = '$result';
    });
  }

  isCanReserve() async {
    var result = await myClient?.api?.isCanReserve().catchError((e) {
      print('e: $e');
    });
    setState(() {
      print('result: $result');
      _result = '$result';
    });
  }

  getDistrictHouseList() async {
    var checkInDate = new DateFormat('yyyy-MM-dd')
        .format(DateTime.now().add(Duration(days: 6)));
    print('checkinDate: $checkInDate');

    var result = await myClient?.api
        ?.getDistrictHouseList(checkinDate: checkInDate)
        .catchError((e) {
      print('e: $e');
    });
    setState(() {
      print('result: $result');
      result?.data?.forEach((element) {
        print('roomInfo: ${element.toJson()}');
      });
      _result = '$result';
      rooms = result?.data;
    });
  }

  confirmOrder(RoomInfo roomInfo) async {
    print('$roomInfo');
    var checkInDate = new DateFormat('yyyy-MM-dd').format(roomInfo.date!);
    print('checkinDate: $checkInDate');
    var result = await myClient?.api
        ?.confirmOrder(
            checkinDate: checkInDate,
            timespan: roomInfo.timespan,
            sign: roomInfo.sign)
        .catchError((e) {
      print('e: $e');
    });
    setState(() {
      print('result: $result');
      // _result = '$result';
    });
  }

  @override
  void timerAction() async {
    var checkInDate = new DateFormat('yyyy-MM-dd')
        .format(DateTime.now().add(Duration(days: 6)));
    print('checkinDate: $checkInDate');

    int count = 10;
    while(true) {
      count --;
      if(count <= 0) {
        break;
      }
      try {
        var result = await myClient?.api
            ?.getDistrictHouseList()
            .catchError((e) {
          print('e: $e');
        });
        print('result:  $result');
        if(null != result && result.status == 200) {
          rooms = result.data;
          if(rooms?.where((element) => element.count! > 0).length != 0) {
            break;
          }
        }
      } catch(e) {
        print('ee: $e');
      }

      print('count:  $count');
    }

    rooms?.forEach((element) {
      if(element.count! > 0) {
        confirmOrder(element);
      }
    });
  }
}
