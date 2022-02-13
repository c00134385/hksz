import 'package:flutter/material.dart';
import 'package:hksz/model/models.dart';

import 'goose.widget.dart';

class OrderRoomUI extends StatefulWidget {
  final UserAccount userAccount;
  
  const OrderRoomUI({Key? key, required this.userAccount}) : super(key: key);

  @override
  _OrderRoomUIState createState() => _OrderRoomUIState();
}

class _OrderRoomUIState extends State<OrderRoomUI> {
  @override
  Widget build(BuildContext context) {
    Widget child = Container();

    // child = ListView.builder(itemBuilder: (BuildContext context, int index) {
    //   UserAccount userAccount = widget.userAccounts[index];
    //   return GooseWidget(certNo: userAccount.certNo, pwd: userAccount.pwd, certType: userAccount.certType,);
    // }, itemCount: widget.userAccounts.length,);
    UserAccount userAccount = widget.userAccount;
    child = GooseWidget(certNo: userAccount.certNo, pwd: userAccount.pwd, certType: userAccount.certType,);

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
