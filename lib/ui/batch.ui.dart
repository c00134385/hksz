import 'package:flutter/material.dart';
import 'package:hksz/api/api.dart';
import 'package:hksz/model/models.dart';
import 'package:hksz/ui/goose.widget.dart';

class BatchUI extends StatefulWidget {
  final List<UserAccount> userAccounts;
  const BatchUI({Key? key, required this.userAccounts}) : super(key: key);

  @override
  _BatchUIState createState() => _BatchUIState();
}

class _BatchUIState extends State<BatchUI> {

  @override
  Widget build(BuildContext context) {
    Widget child = Container();

    child = ListView.builder(itemBuilder: (BuildContext context, int index) {
      UserAccount userAccount = widget.userAccounts[index];
      return GooseWidget(certNo: userAccount.certNo, pwd: userAccount.pwd, certType: userAccount.certType,);
    }, itemCount: widget.userAccounts.length,);

    child = Scaffold(
      appBar: AppBar(
        title: Text('Batch'),
      ),
      body: child,
    );
    return child;
  }

  @override
  void initState() {
    super.initState();
    // getCertificateList();
  }

  // List<Certificate>? certificates;
  //
  // getCertificateList() async {
  //   var result = await MyClient().api?.getCertificateList().catchError((e) {
  //     print('e: $e');
  //   });
  //   print('result: $result');
  //   setState(() {
  //     certificates = result?.data;
  //   });
  // }
}
