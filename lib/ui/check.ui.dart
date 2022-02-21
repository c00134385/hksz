import 'package:flutter/material.dart';
import 'package:hksz/api/api.dart';
import 'package:hksz/model/models.dart';

import 'batch.ui.dart';
import 'common.widgets.dart';
import 'grab.ui.dart';

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

    child = ListView(
      children: _buildChildren(),
    );

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
          color: checkedUserAccounts.contains(userAccount)?Colors.yellow[200]: Colors.transparent,
          border: Border(bottom: BorderSide(color: Colors.grey)),
        ),
      );
      child = InkWell(
        child: child,
        onTap: () {
          setState(() {
            if(checkedUserAccounts.contains(userAccount)) {
              checkedUserAccounts.remove(userAccount);
            } else {
              checkedUserAccounts.add(userAccount);
            }
          });
        },
      );
      return child;
    }).toList();

    children.add(
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(onPressed: getCertificateList, child: Text('refresh')),
          ElevatedButton(onPressed: _next, child: Text('next')),
        ],
      )
    );

    return children;
  }

  @override
  void initState() {
    super.initState();
    userAccounts = widget.accounts.map((e) {
      return UserAccount.fromString(e);
    }).toList();
    userAccounts?.forEach((element) {
      checkedUserAccounts.add(element);
    });

    getCertificateList();
  }

  List<UserAccount>? userAccounts;
  List<UserAccount> checkedUserAccounts = List.empty(growable: true);
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

  _next() {
    if(null == userAccounts) {
      return;
    }
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return GrabUI(userAccounts: checkedUserAccounts,);
    }));
  }

  toBatch() {
    if(null == userAccounts) {
      return;
    }
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return BatchUI(userAccounts: checkedUserAccounts,);
    }));
  }
}


