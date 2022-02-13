import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hksz/api/api.dart';
import 'package:hksz/model/models.dart';
import 'package:hksz/utils/utils.dart';
import 'package:intl/intl.dart';

import 'goose.widget.dart';

class QuickOrderUI extends StatefulWidget {
  final List<UserAccount> userAccounts;

  const QuickOrderUI({Key? key, required this.userAccounts}) : super(key: key);

  @override
  _QuickOrderUIState createState() => _QuickOrderUIState();
}

class _QuickOrderUIState extends State<QuickOrderUI> with SingleTickerProviderStateMixin{
  UserAccount? selectedUserAccount;
  List<Certificate>? certificates;

  getCertificateList() async {
    var result = await MyClient().api?.getCertificateList().catchError((e) {
      print('e: $e');
    });
    print('result: $result');
    setState(() {
      certificates = result?.data;
    });
  }

  @override
  void initState() {
    super.initState();
    getCertificateList();
  }

  @override
  Widget build(BuildContext context) {
    Widget child = Container();

    child = DropdownButton<UserAccount>(
      value: selectedUserAccount,
      onChanged: (value) {
        print('value: $value');
        setState(() {
          selectedUserAccount = value;
        });
      },
      items: widget.userAccounts.map<DropdownMenuItem<UserAccount>>((e) {
        return DropdownMenuItem<UserAccount>(
          child: Text('${e.certType} / ${e.certNo} / ${e.pwd}'),
          value: e,
        );
      }).toList(),
      hint: const Text('select cert type'),
    );

    UserAccount? userAccount = selectedUserAccount;
    child = Column(
      children: [
        child,
        if (null != userAccount)
          GooseWidget(
            certNo: userAccount.certNo,
            pwd: userAccount.pwd,
            certType: userAccount.certType,
            key: ValueKey(userAccount.hashCode),
          ),
        if(null != userAccount)
          QuickPanel(userAccount: userAccount),
      ],
    );

    // child = GooseWidget(certNo: userAccount.certNo, pwd: userAccount.pwd, certType: userAccount.certType,);

    child = SingleChildScrollView(
      child: child,
    );

    child = Scaffold(
      appBar: AppBar(
        title: Text('OrderRoom'),
      ),
      body: child,
    );
    return child;
  }
}


class QuickPanel extends StatefulWidget {
  final UserAccount userAccount;
  const QuickPanel({Key? key, required this.userAccount}) : super(key: key);

  @override
  _QState createState() => _QState();
}

class _QState extends State<QuickPanel> {
  @override
  Widget build(BuildContext context) {
    Widget child = Container();

    return child;
  }

  Certificate? selectedCertificate;
  MyClient? myClient;
  String? _result;
  Uint8List? verifyImage;
  List<RoomInfo>? rooms = List.empty();
  TextEditingController? textEditingController;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
    myClient = MyClient();
    getCertificateList();
    getVerify();
  }

  getCertificateList() async {
    var result = await myClient?.api?.getCertificateList().catchError((e) {
      print('e: $e');
    });
    print('result: $result');
    setState(() {
      var certificates = result?.data;
      selectedCertificate =
          certificates?.firstWhere((element) => element.id == widget.userAccount.certType);
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
    int certType = widget.userAccount.certType!;
    String certNo = widget.userAccount.certNo!;
    String pwd = widget.userAccount.pwd!;
    String verifyCode = textEditingController!.text;
    var result = await myClient?.api
        ?.login(certType, Utils.encodeBase64(certNo),
        Utils.encodeBase64(Utils.generateMd5(pwd)), verifyCode)
        .catchError((e) {
      print('e: $e');
    });

    if(result?.status == 200) {
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
}
