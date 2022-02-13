import 'dart:math';
import 'dart:typed_data';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:hksz/api/api.dart';
import 'package:hksz/model/models.dart';
import 'package:hksz/utils/utils.dart';
import 'common.widgets.dart';
import 'package:intl/intl.dart';

// class GooseItem extends StatelessWidget {
//
//   final String certNo;
//   final String pwd;
//   final List<Certificate>? certificates;
//   const GooseItem({Key? key, required this.certNo, required this.pwd, required this.certificates}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     Widget child = Container();
//
//     child = Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Text('$certificates'),
//         PropertyWidget(name: 'certNo', value: certNo,),
//         PropertyWidget(name: 'pwd', value: pwd,),
//       ],
//     );
//
//     child = Container(
//       child: child,
//       color: Colors.primaries[hashCode%Colors.primaries.length].withOpacity(0.5),
//       padding: EdgeInsets.all(10),
//     );
//
//     return child;
//   }
// }

class GooseWidget extends StatefulWidget {
  final int? certType;
  final String? certNo;
  final String? pwd;
  const GooseWidget({
    Key? key,
    required this.certNo,
    required this.pwd,
    required this.certType,
  }) : super(key: key);

  @override
  _GooseWidgetState createState() => _GooseWidgetState();
}

class _GooseWidgetState extends State<GooseWidget> {
  @override
  Widget build(BuildContext context) {
    Widget child = Container();

    child = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButton<Certificate>(
          value: selectCertificate,
          onChanged: (value) {
            print('value: $value');
            setState(() {
              selectCertificate = value;
            });
          },
          items: certificates?.map<DropdownMenuItem<Certificate>>((e) {
            return DropdownMenuItem<Certificate>(
              child: Text('${e.name}'),
              value: e,
            );
          }).toList(),
          hint: const Text('select cert type'),
        ),
        PropertyWidget(
          name: 'certNo',
          value: widget.certNo,
        ),
        PropertyWidget(
          name: 'pwd',
          value: widget.pwd,
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
                  height: 50,
                )
              : Container(
                  height: 50,
                ),
        ),
        Container(
          width: 100,
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
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: rooms!.map((e) {
            Widget child = RoomItem(roomInfo: e);
            child = InkWell(
              child: child,
              onTap: () => confirmOrder(e),
            );
            child = Padding(
              child: child,
              padding: EdgeInsets.only(top: 10),
            );
            return child;
          }).toList(),
        ),
        // ListView.builder(itemBuilder: (context, index) {
        //   return RoomItem(roomInfo: rooms![index]);
        // }, itemCount: rooms?.length,),
        Text(
          '$_result',
          style: const TextStyle(color: Colors.red),
        ),
      ],
    );

    child = Container(
      child: child,
      // color:
      //     Colors.primaries[hashCode % Colors.primaries.length].withOpacity(0.5),
      constraints: BoxConstraints(maxWidth: 100),
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
    getCertificateList();
    getVerify();
  }

  List<Certificate>? certificates;
  Certificate? selectCertificate;
  MyClient? myClient;
  String? _result;
  Uint8List? verifyImage;
  List<RoomInfo>? rooms = List.empty();

  getCertificateList() async {
    var result = await myClient?.api?.getCertificateList().catchError((e) {
      print('e: $e');
    });
    print('result: $result');
    setState(() {
      certificates = result?.data;
      selectCertificate =
          certificates?.firstWhere((element) => element.id == widget.certType);
    });
  }

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
    int certType = 4;
    String certNo = 'H04304428';
    String pwd = 'a63061977';
    String verifyCode = textEditingController!.text;
    var result = await myClient?.api
        ?.login(certType, Utils.encodeBase64(certNo),
            Utils.encodeBase64(Utils.generateMd5(pwd)), verifyCode)
        .catchError((e) {
      print('e: $e');
    });

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
    var checkInDate = new DateFormat('yyyy-MM-dd')
        .format(roomInfo.date!);
    print('checkinDate: $checkInDate');
    var result = await myClient?.api
        ?.confirmOrder(checkinDate: checkInDate, timespan: roomInfo.timespan, sign: roomInfo.sign)
        .catchError((e) {
      print('e: $e');
    });
    setState(() {
      print('result: $result');
      // _result = '$result';
    });
  }
}
