import 'package:flutter/material.dart';
import 'package:hksz/api/api.dart';
import 'package:hksz/model/models.dart';

import 'batch.ui.dart';
import 'common.widgets.dart';

class CheckUI extends StatefulWidget {
  final List<String> accounts;
  const CheckUI({Key? key, required this.accounts}) : super(key: key);

  @override
  _CheckUIState createState() => _CheckUIState();
}

class _CheckUIState extends State<CheckUI> {
  @override
  Widget build(BuildContext context) {
    Widget child = Container();

    // child = ListView.builder(
    //   itemBuilder: (context, index) {
    //     UserAccount userAccount = userAccounts![index];
    //     userAccount.certificate = certificates
    //         ?.firstWhere((element) => element.id == userAccount.certType);
    //     Widget child = AccountItem(
    //       account: userAccount,
    //     );
    //     child = Container(
    //       child: child,
    //       padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    //       decoration: BoxDecoration(
    //         border: Border(bottom: BorderSide(color: Colors.grey)),
    //       ),
    //     );
    //     return child;
    //   },
    //   itemCount: widget.accounts.length,
    // );

    child = ListView(
      children: _buildChildren(),
    );

    // child = Column(
    //   children: [
    //     Expanded(child: child),
    //   ],
    // );

    child = Scaffold(
      appBar: AppBar(
        title: const Text('Check Page'),
      ),
      body: child,
    );
    return child;
  }

  List<Widget> _buildChildren() {
    List<Widget> children = List.empty();
    if(null == userAccounts) {
      return children;
    }
    children = userAccounts!.map((userAccount) {
      userAccount.certificate = certificates
          ?.firstWhere((element) => element.id == userAccount.certType);
      Widget child = AccountItem(
        account: userAccount,
      );
      child = Container(
        child: child,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey)),
        ),
      );
      return child;
    }).toList();
    children.add(
      ElevatedButton(onPressed: toBatch, child: Text('next')),
    );
    return children;
  }

  @override
  void initState() {
    super.initState();
    userAccounts = widget.accounts.map((e) {
      return UserAccount.fromString(e);
    }).toList();
    getCertificateList();
  }

  List<UserAccount>? userAccounts;
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

  toBatch() {
    if(null == userAccounts) {
      return;
    }
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return BatchUI(userAccounts: userAccounts!,);
    }));
  }
}


