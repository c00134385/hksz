import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hksz/api/api.dart';
import 'package:hksz/model/models.dart';
import 'package:hksz/ui/widgets.dart';
import 'package:hksz/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:html/parser.dart';

class GrabUI extends StatefulWidget {
  final List<UserAccount> userAccounts;

  const GrabUI({Key? key, required this.userAccounts}) : super(key: key);

  @override
  _GrabUIState createState() => _GrabUIState();
}

class _GrabUIState extends State<GrabUI> with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: widget.userAccounts.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget child = Container();

    // child = CustomScrollView(
    //   slivers: [
    //     SliverToBoxAdapter(
    //       child: TabBar(
    //         controller: _tabController,
    //         isScrollable: true,
    //         labelColor: Colors.black,
    //         labelStyle: TextStyle(fontSize: 15),
    //         unselectedLabelStyle: TextStyle(color: Colors.grey),
    //         tabs: widget.userAccounts.map((e) {
    //           Widget child = Text(e.certNo!);
    //           child = Padding(padding: EdgeInsets.symmetric(vertical: 12, horizontal: 0), child: child);
    //           return child;
    //         }).toList(),
    //       ),
    //     ),
    //   ],
    // );

    child = Column(
      children: [
        TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: Colors.black,
          labelStyle: TextStyle(fontSize: 15),
          unselectedLabelStyle: TextStyle(color: Colors.grey),
          tabs: widget.userAccounts.map((e) {
            Widget child = Text(e.certNo!);
            child = Padding(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 0),
                child: child);
            return child;
          }).toList(),
        ),
        Expanded(
            child: TabBarView(
          controller: _tabController,
          children: widget.userAccounts.map((e) {
            // Widget child = Text(e.certNo!);
            // child = Padding(padding: EdgeInsets.symmetric(vertical: 12, horizontal: 0), child: child);
            // return child;
            return WorkBodyUI(
              userAccount: e,
            );
          }).toList(),
        )),
      ],
    );

    child = Scaffold(
      appBar: AppBar(
        title: const Text('Grab Page'),
      ),
      body: child,
    );
    return child;
  }
}

class WorkBodyUI extends StatefulWidget {
  final UserAccount userAccount;

  const WorkBodyUI({Key? key, required this.userAccount}) : super(key: key);

  @override
  _WorkBodyUIState createState() => _WorkBodyUIState();
}

class _WorkBodyUIState extends State<WorkBodyUI>
    with AutomaticKeepAliveClientMixin {
  MyClient? myClient;
  String? result;
  String? verifyCodeFile;
  List<RoomInfo>? roomInfoList;
  TextEditingController? verifyCodeController;

  MyApi? get api => myClient?.api;

  @override
  void initState() {
    super.initState();
    verifyCodeController = TextEditingController();
    myClient = MyClient();
  }

  @override
  void dispose() {
    super.dispose();
    verifyCodeController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget child = Container();
    child = Text("${widget.userAccount}");

    child = ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        Widget child = Container();
        child = Container(
          height: 50,
          color: Colors.primaries[(index + hashCode) % Colors.primaries.length],
        );
        return child;
      },
      itemCount: 30,
    );

    child = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          children: [
            Loading(bShow: bShowLoading),
            ElevatedButton(
              onPressed: _init,
              child: const Text('init'),
            ),
          ],
        ),
        Text(result ?? ''),
      ],
    );

    child = CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Row(
            children: [
              Loading(bShow: bShowLoading),
              ElevatedButton(
                onPressed: _init,
                child: const Text('Init'),
              ),
              if (null != verifyCodeFile)
                InkWell(
                  child: Image.file(
                    File(verifyCodeFile ?? ''),
                    height: 40,
                    fit: BoxFit.contain,
                  ),
                  onTap: _getVerifyCode,
                ),
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: Row(
            children: [
              ElevatedButton(
                onPressed: _getVerifyCode,
                child: const Text('VerifyCode'),
              ),
              if (null != verifyCodeFile)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      controller: verifyCodeController,
                      keyboardType: TextInputType.text,
                    ),
                  ),
                ),
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: Wrap(
            spacing: 10,
            children: [
              ElevatedButton(
                onPressed: _login,
                child: const Text('Login'),
              ),
              ElevatedButton(
                onPressed: _logout,
                child: const Text('Logout'),
              ),
              ElevatedButton(
                onPressed: _getUserInfo,
                child: const Text('Get UserInfo'),
              ),
              ElevatedButton(
                onPressed: _getRooms,
                child: const Text('Get Rooms'),
              ),
              ElevatedButton(
                onPressed: _canBeReserved,
                child: const Text('Can be Reserved'),
              ),
              ElevatedButton(
                onPressed: _hack1,
                child: const Text('Hack1'),
              ),
              ElevatedButton(
                onPressed: _hack2,
                child: const Text('Hack2'),
              ),
              ElevatedButton(
                onPressed: _test,
                child: const Text('Get CheckIn'),
              ),
              ElevatedButton(
                onPressed: _getCheckInList,
                child: const Text('Get CheckInList'),
              ),
            ],
          ),
        ),
        SliverList(
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
            RoomInfo room = roomInfoList![index];
            Widget child = Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                          '${new DateFormat('yyyy-MM-dd').format(room.date!)}'),
                      Spacer(),
                      Text('${room.count}/${room.total}'),
                      Spacer(),
                      Text(' ${room.timespan}'),
                    ],
                  ),
                  Text('${room.sign}'),
                ],
              ),
            );
            return child;
          }, childCount: roomInfoList?.length ?? 0),
        ),
        SliverToBoxAdapter(
          child: Text(result ?? ''),
        ),
      ],
    );

    return child;
  }

  _init() async {
    showLoading();
    result = await myClient?.api?.index();
    hideLoading();
  }

  _getVerifyCode() async {
    showLoading();
    double random = Random().nextDouble();
    var ret = await myClient?.api?.getVerify('$random');
    Directory tempDir = await getTemporaryDirectory();
    String fileName = tempDir.path.endsWith('/')
        ? (tempDir.path + "$random.jfif")
        : (tempDir.path + "/$random.jfif");
    File(fileName).writeAsBytesSync(ret, flush: true);
    verifyCodeFile = fileName;
    result = verifyCodeFile;
    hideLoading();
  }

  _login() async {
    int certType = widget.userAccount.certType!;
    String certNo = widget.userAccount.certNo ?? '';
    String pwd = widget.userAccount.pwd ?? '';
    String verifyCode = verifyCodeController!.text;
    print(
        'certType: $certType  certNo: $certNo pwd: $pwd verifyCode: $verifyCode');
    showLoading();
    var ret = await myClient?.api
        ?.login(certType, Utils.encodeBase64(certNo),
            Utils.encodeBase64(Utils.generateMd5(pwd)), verifyCode)
        .catchError((e) {
      print('e: $e');
      result = '$e';
      hideLoading();
    });
    result = ret.toString();
    hideLoading();
  }

  _logout() async {
    showLoading();
    var ret = await myClient?.api?.logout().catchError((e) {
      print('e: $e');
      result = '$e';
      hideLoading();
    });
    result = ret.toString();
    hideLoading();
  }

  _getUserInfo() async {
    showLoading();
    var ret = await myClient?.api?.getUserInfo().catchError((e) {
      print('e: $e');
      result = '$e';
      hideLoading();
    });
    result = ret.toString();
    hideLoading();
  }

  _getRooms() async {
    Timer.periodic(Duration(seconds: 3), (timer) async {
      if (DateTime.now().isAfter(DateTime(DateTime.now().year,
          DateTime.now().month, DateTime.now().day, 9, 59, 45))) {
        timer.cancel();
      }
      showLoading();
      var ret = await myClient?.api?.getDistrictHouseList().catchError((e) {
        print('e: $e');
        result = '$e';
        hideLoading();
      });
      roomInfoList = ret?.data!;
      result = ret.toString();
      hideLoading();
    });
  }

  _canBeReserved() async {
    showLoading();
    var ret = await myClient?.api?.isCanReserve().catchError((e) {
      print('e: $e');
      result = '$e';
      hideLoading();
    });
    result = ret.toString();
    hideLoading();
  }

  List<TimerTask> hackTaskList1 = List.empty(growable: true);
  List<TimerTask> hackTaskList2 = List.empty(growable: true);

  _hack1() {
    while (true) {
      if (hackTaskList1.length > 100) {
        break;
      }
      hackTaskList1.add(TimerTask(timerAction: () async {
        RoomInfo? room = roomInfoList?.last;
        if (null != room) {
          var ret = await api
              ?.confirmOrder(
                  checkinDate: DateFormat('yyyy-MM-dd').format(room.date!),
                  timespan: room.timespan,
                  sign: room.sign)
              .catchError((e) {
            print('e: $e');
            result = '$e';
            return;
          });

          result = ret.toString();
          var document = parse(result);
          // document.getElementById('hid')

          ret = await api
              ?.submitReservation(
                  checkinDate: DateFormat('yyyy-MM-dd').format(room.date!),
                  timeSpan: room.timespan,
                  sign: room.sign,
                  checkCode: verifyCodeController?.text,
                  houseType: 1)
              .catchError((e) {
            print('e: $e');
            result = '$e';
            return;
          });

          result = ret.toString();
        }
      }));
    }
  }

  _hack2() {
    while (true) {
      if (hackTaskList2.length > 100) {
        break;
      }
      hackTaskList2.add(TimerTask(timerAction: () async {
        RoomInfo? room = roomInfoList?.last;
        if (null != room) {
          var ret = await api
              ?.submitReservation(
                  checkinDate: DateFormat('yyyy-MM-dd').format(room.date!),
                  timeSpan: room.timespan,
                  sign: room.sign,
                  checkCode: verifyCodeController?.text,
                  houseType: 1)
              .catchError((e) {
            print('e: $e');
            result = '$e';
            return;
          });

          result = ret.toString();
        }
      }));
    }
  }

  _test() async {
    RoomInfo? room = roomInfoList?.last;
    if (null != room) {
      var ret = await api
          ?.confirmOrder(
              checkinDate: DateFormat('yyyy-MM-dd').format(room.date!),
              timespan: room.timespan,
              sign: room.sign)
          .catchError((e) {
        print('e: $e');
        result = '$e';
        return;
      });
      result = ret.toString();

      var document = parse(result);
      // document.getElementById('hid')
    }
  }

  _getCheckIn() async {
    showLoading();
    var ret = await myClient?.api?.getCheckInDate().catchError((e) {
      print('e: $e');
      result = '$e';
      hideLoading();
    });
    result = ret.toString();
    hideLoading();
  }

  _getCheckInList() async {
    showLoading();
    var ret = await myClient?.api?.getCheckInInfoList(1, 10).catchError((e) {
      print('e: $e');
      result = '$e';
      hideLoading();
    });
    result = ret.toString();
    hideLoading();
  }

  bool bShowLoading = false;

  showLoading() {
    setState(() {
      bShowLoading = true;
    });
  }

  hideLoading() {
    setState(() {
      bShowLoading = false;
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

typedef TimerAction = void Function();

class TimerTask {
  Timer? _timer;
  final TimerAction timerAction;

  TimerTask({required this.timerAction}) {
    _startTimer();
  }

  @override
  void dispose() {
    _cancelTimer();
  }

  bool get isTimerActive => _timer?.isActive ?? false;

  _startTimer() {
    _cancelTimer();
    var beginTime = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      10,
    );
    // beginTime = beginTime.subtract(Duration(milliseconds: 10));
    // print('duration: $beginTime ${beginTime.subtract(Duration(milliseconds: 1000))}');
    var duration = beginTime.difference(DateTime.now());
    print('duration: $duration');
    _timer = Timer(duration, () {
      timerAction();
    });
  }

  _cancelTimer() {
    _timer?.cancel();
    _timer = null;
  }
}
