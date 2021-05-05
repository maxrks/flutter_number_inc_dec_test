import 'dart:async';

import 'package:flutter/material.dart';

import 'ItemNumberField.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  StreamController<dynamic> _streamController;

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
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    _streamController.sink.close();
    _streamController.close();
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
            ConstrainedBox(
              constraints: BoxConstraints(minHeight: 50, minWidth: 200),
              child: RaisedButton(
                  onPressed: () {
                    _showConfirmDialog(context);
                  },
                  child: Text(
                    "Input Test",
                    style: TextStyle(fontSize: 30),
                  ),
                  color: Colors.cyan),
            )
          ],
        ),
      ),
    );
  }

  _showConfirmDialog(BuildContext ctx) {
    var titleText = "Prompt";

    _streamController = new StreamController();
    _streamController.sink.add("event");

    var _testCtrl1 = TextEditingController();
    var _testCtrl2 = TextEditingController();

    _testCtrl1.text = "1.5";
    _testCtrl2.text = "600";

    var _dialog = new AlertDialog(
      insetPadding: EdgeInsets.all(5.0),
      // contentPadding: EdgeInsets.all(5.0),
      title: Text(
        titleText,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Container(
        height: 100,
        width: MediaQuery.of(context).size.width,
        // height: MediaQuery.of(context).size.height,
        child: StreamBuilder<dynamic>(
            stream: _streamController.stream,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              return new SingleChildScrollView(
                child: snapshot.hasData && snapshot.data.toString() != ""
                    ? () {
                        return Column(
                          children: [
                            ItemNumberField(
                              text: "AAA Enabled",
                              hint: "",
                              headerWidth: 150,
                              controler: _testCtrl1,
                              min: 0,
                              max: 2.0,
                              step: 0.01,
                              fraction: 2,
                              unit: "(*)",
                              color: Colors.black,
                              enabled: true,
                            ),
                            ItemNumberField(
                              text: "BBB Enabled",
                              hint: "",
                              headerWidth: 150,
                              controler: _testCtrl1,
                              min: 0,
                              max: 2.0,
                              step: 0.01,
                              fraction: 2,
                              unit: "(*)",
                              color: Colors.black,
                              enabled: true,
                            ),
                            ItemNumberField(
                              text: "CCC disabled",
                              hint: "",
                              headerWidth: 150,
                              controler: _testCtrl2,
                              min: 0,
                              max: 1000,
                              step: 1,
                              fraction: 0,
                              unit: "(*)",
                              color: Colors.amber,
                              enabled: false,
                            ),
                            ItemNumberField(
                              text: "DDD disabled",
                              hint: "",
                              headerWidth: 150,
                              controler: _testCtrl2,
                              min: 0,
                              max: 1000,
                              step: 1,
                              fraction: 0,
                              unit: "(*)",
                              color: Colors.amber,
                              enabled: false,
                            ),
                          ],
                        );
                      }()
                    : Text("wait..."),
              );
            }),
      ),
      actions: <Widget>[
        new OutlineButton(
          child: new Text(
            'Cancel',
            style: TextStyle(fontSize: 20),
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          onPressed: () {
            _streamController.close();

            Navigator.of(context).pop(false);
          },
        ),
        new FlatButton(
          textColor: Colors.white,
          color: Theme.of(context).primaryColor,
          child: Text("Confirm", style: TextStyle(fontSize: 20)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          onPressed: () {
            _streamController.close();
            Navigator.of(context).pop(true);
          },
        ),
      ],
    );

    showDialog<bool>(
      context: ctx,
      barrierDismissible: false,
      builder: (BuildContext c) {
        return _dialog;
      },
    );
  }
}
