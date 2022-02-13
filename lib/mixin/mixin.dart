import 'package:flutter/material.dart';
import 'dart:async';

typedef OnTimeCallback = void Function();

mixin TimerTaskStateMixin<T extends StatefulWidget> on State<T> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    print('TimerTaskStateMixin initState is called $hashCode');
    // startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    print('TimerTaskStateMixin dispose is called $hashCode');
    cancelTimer();
  }

  bool get isTimerActive => _timer?.isActive??false;

  startTimer() {
    cancelTimer();
    // int countValue = 60;
    // _timer = Timer.periodic(Duration(seconds: 1), (timer) {
    //   countValue--;
    //   print('TimerTaskStateMixin($hashCode) : $countValue');
    // });
    var deadline = DateTime(2022, 2, 14, 10,);
    var duration = deadline.difference(DateTime.now());
    duration = Duration(seconds: 5);
    print('duration: $duration');
    _timer = Timer(duration, () {
      // var now = DateTime.now();
      // print('TimerTaskStateMixin($hashCode) : $now');
      timerAction();
    });
  }

  cancelTimer() {
    _timer?.cancel();
    _timer = null;
  }

  void timerAction();
}
