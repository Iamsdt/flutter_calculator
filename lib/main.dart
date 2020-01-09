import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double getWidth(BuildContext context) =>
      MediaQuery.of(context).size.width / 4;

  String result = "0";
  String first = "";
  String operation = "";
  String second = "";
  int selected = 0;

  void updateResult(int selected) {}

  void addNum(String s) {
    setState(() {
      if (selected == 0) {
        first += s;
      } else if (selected == 1) {
        second += s;
      }
      updateResult(selected);
    });
  }

  void calculate() {}

  void add() {
    setState(() {});
  }

  void minus() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(children: <Widget>[
            Expanded(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    result,
                    textAlign: TextAlign.end,
                    style: getStyle(font: 42.0),
                  ),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                getContainer("C"),
                getContainer("÷"),
                getContainer("x"),
                getContainer("back",
                    child: Icon(
                      Icons.backspace,
                      color: Colors.white,
                    )),
              ],
            ),
            Row(
              children: <Widget>[
                getContainer("7"),
                getContainer("8"),
                getContainer("9"),
                getContainer("minus",
                    child: Icon(
                      Icons.remove,
                      size: 32.0,
                      color: Colors.white,
                    )),
              ],
            ),
            Row(
              children: <Widget>[
                getContainer("4"),
                getContainer("5"),
                getContainer("6"),
                getContainer("add",
                    child: Icon(
                      Icons.add,
                      size: 32.0,
                      color: Colors.white,
                    )),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                    child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        getContainer("1"),
                        getContainer("2"),
                        getContainer("3"),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: getContainer("0"),
                        ),
                        getContainer("."),
                      ],
                    )
                  ],
                )),
                InkWell(
                  onTap: () {
                    calculate();
                  },
                  child: Container(
                    width: getWidth(context),
                    height: 160.0,
                    child: Center(child: getText("=", font: 45.0)),
                    decoration: BoxDecoration(
                        color: Colors.cyan,
                        border:
                            Border.all(color: Color(0xffdbdad7), width: 0.1)),
                  ),
                )
              ],
            )
          ]),
        ),
      ),
    );
  }

  Widget getText(string, {font = 32.0}) {
    return Text(
      string,
      style: getStyle(font: font),
    );
  }

  TextStyle getStyle({font: 32.0}) {
    return TextStyle(color: Colors.white, fontSize: font);
  }

  Widget getContainer(string, {child, height = 80.0, font = 32.0}) {
    if (child == null) {
      child = getText(string, font: font);
    }

    void handleClick() {
      //back
    }

    return InkWell(
      onTap: () {
        handleClick();
      },
      child: Container(
        width: getWidth(context),
        height: height,
        child: Center(child: child),
        decoration: BoxDecoration(
            border: Border.all(color: Color(0xffdbdad7), width: 0.1)),
      ),
    );
  }
}
