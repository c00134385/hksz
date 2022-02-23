import 'package:flutter/material.dart';
import 'package:hksz/model/models.dart';
import 'package:hksz/ui/batch.ui.dart';
import 'package:hksz/ui/check.ui.dart';
import 'package:hksz/ui/input.ui.dart';
import 'package:hksz/ui/login.ui.dart';
import 'package:hksz/ui/order.room.dart';
import 'package:hksz/ui/quick.order.dart';
import 'package:http/http.dart' as http;
import 'constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // const Text(
            //   'You have pushed the button this many times:',
            // ),
            // Text(
            //   '$_counter',
            //   style: Theme.of(context).textTheme.headline4,
            // ),
            // ElevatedButton(
            //   onPressed: toLogin,
            //   child: const Text('Login'),
            // ),
            // ElevatedButton(
            //   onPressed: toBatch,
            //   child: const Text('open batch'),
            // ),
            // ElevatedButton(
            //   onPressed: toOrder,
            //   child: const Text('order room'),
            // ),
            // ElevatedButton(
            //   onPressed: quickOrder,
            //   child: const Text('quickOrder'),
            // ),
            // ElevatedButton(
            //   onPressed: checkIn,
            //   child: const Text('check in'),
            // ),
            ElevatedButton(
              onPressed: entry,
              child: const Text('entry'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  toLogin() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const LoginUI();
    }));
  }

  toBatch() async {
    List<UserAccount> userAccounts = accounts.map((e) {
      return UserAccount.fromString(e);
    }).toList();

    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return BatchUI(userAccounts: userAccounts,);
    }));

    // var url = Uri.parse('https://example.com/whatsit/create');
    // var response = await http.post(url, body: {'name': 'doodle', 'color': 'blue'});
    // print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');
    //
    // print(await http.read(Uri.parse('https://example.com/foobar.txt')));
  }

  toOrder() {
    List<UserAccount> userAccounts = accounts.map((e) {
      return UserAccount.fromString(e);
    }).toList();

    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return OrderRoomUI(userAccount: userAccounts.first);
    }));
  }

  quickOrder() {
    List<UserAccount> userAccounts = accounts.map((e) {
      return UserAccount.fromString(e);
    }).toList();

    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return QuickOrderUI(userAccounts: userAccounts);
    }));
  }

  checkIn() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return CheckUI(accounts: accounts);
    }));
  }

  entry() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return InputUI();
    }));
  }
}

// List<String> account = [
//   '4,H09471876,ed521126',
//   // '4,H004304428,a63061977',
//   '3,G49480256,c00134385',
// ];

// [{"id":4,"name":"港澳居民來往內地通行證"},
// {"id":6,"name":"臺灣居民來往大陸通行證"},
// {"id":2,"name":"往來港澳通行證"},
// {"id":3,"name":"護照"}
// ]
