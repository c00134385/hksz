import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hksz/model/models.dart';

import 'check.ui.dart';

class InputUI extends StatefulWidget {
  const InputUI({Key? key}) : super(key: key);

  @override
  _InputUIState createState() => _InputUIState();
}

class _InputUIState extends State<InputUI> {
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    textEditingController.text = "4,H09471876,ed521126\n4,H04304428,a63061977\n3,G49480256,c00134385";
  }

  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget child = Container();

    child = TextField(
      controller: textEditingController,
      maxLines: 10,
      keyboardType: TextInputType.multiline,
    );

    child = Column(
      children: [
        child,
        ElevatedButton(
          onPressed: next,
          child: const Text('Next'),
        ),
      ],
    );

    child = GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: child,
    );

    child = Scaffold(
      appBar: AppBar(
        title: Text('Input'),
      ),
      body: child,
    );

    child = SafeArea(child: child);

    return child;
  }

  next() async {
    if (textEditingController.text.trim().isEmpty) {
      _showSnackBar("no text");
    }

    try {
      List<String> accountStr = textEditingController.text.trim().split("\n");
      List<UserAccount> accounts = accountStr.map((e) {
        return UserAccount.fromString(e.trim());
      }).toList();

      var result = await showDialog(context: context, builder: (context){
        Widget child = Container();
        List<Widget> children = List.empty(growable: true);
        children.addAll(accounts.map((e) {
          return Text("${e.certType} / ${e.certNo} / ${e.pwd}");
        }).toList());
        children.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Ok'),
            ),
          ],
        ));

        child = Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        );

        child = Container(
          padding: EdgeInsets.all(20),
          // constraints: BoxConstraints(maxHeight: 200),
          child: child,
        );

        return Dialog(
          child: child,
        );
      });

      if(true == result) {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return CheckUI(accounts: accountStr);
        }));
      }
    } catch(e) {
      _showSnackBar(e.toString());
    }
  }

  _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}
