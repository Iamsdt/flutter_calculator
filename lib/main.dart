import 'dart:math';

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

  String string = "0";
  String result = "0";
  String prevResult = "0";
  String first = "";
  String operation = "";
  String second = "";
  int selected = 0;

  double fontSize = 42.0;

  void updateResult(int selected) {
    setState(() {
      if (result != "0") {
        string = result;
        result = "0";
      } else {
        if (selected == 0) {
          string = first;
        } else if (selected == 1) {
          if (second.isNotEmpty) {
            string = first + "\n" + operation + "\n" + second;
          } else if (operation.isNotEmpty) {
            string = first + "\n" + operation;
          }
        }
      }

      //update font size
      if (first.length > 8 || second.length > 8) {
        fontSize = 32.0;
      } else if (first.length > 10 || second.length > 10) {
        fontSize = 28.0;
      } else if (first.length > 15 || second.length > 10) {
        fontSize = 28.0;
      } else if (first.length > 20 || second.length > 10) {
        fontSize = 25.0;
      } else if (first.length < 10 || second.length < 10) {
        fontSize = 42.0;
      }
    });
  }

  void addNum(String s) {
    if (selected == 0) {
      if (first == "0") {
        if (s == "0") {
          first = s;
        } else {
          first = s;
        }
      } else {
        first += s;
      }
    } else if (selected == 1) {
      if (second == "0") {
        if (s == "0") {
          second = s;
        } else {
          second = s;
        }
      } else {
        second += s;
      }
    }
    updateResult(selected);
  }

  void calculate() {
    if (operation.isNotEmpty && second.isNotEmpty) {
      double num1 = double.parse(first);
      double num2 = double.parse(second);

      double res = 0.0;

      switch (operation) {
        case "+":
          res = num1 + num2;
          break;
        case "-":
          res = num1 - num2;
          break;
        case "x":
          res = num1 * num2;
          break;
        case "÷":
          res = num1 / num2;
          break;
      }
      setState(() {
        if (first.contains(".") || operation == "÷") {
          if (res > 100000) {
            result = res.toStringAsExponential(2);
          } else if (res < 0.009) {
            result = res.toStringAsExponential(2);
          } else {
            result = res.toStringAsFixed(2);
          }
        } else {
          if (res > 100000) {
            result = res.toStringAsExponential(0);
          } else {
            result = res.toStringAsFixed(0);
          }
        }
        prevResult = result;
        selected = 0;
        first = "";
        second = "";
        string = "";
        operation = "";
        updateResult(selected);
      });
    }
  }

  void add() {
    selected = 1;
    if (prevResult != "0" && first.isEmpty) {
      first = prevResult;
    }
    prevResult = "0";
    operation = "+";
    updateResult(selected);
  }

  void minus() {
    selected = 1;
    if (prevResult != "0" && first.isEmpty) {
      first = prevResult;
    }
    prevResult = "0";
    operation = "-";
    updateResult(selected);
  }

  void div() {
    selected = 1;
    if (prevResult != "0" && first.isEmpty) {
      first = prevResult;
    }
    prevResult = "0";
    operation = "÷";
    updateResult(selected);
  }

  void mul() {
    selected = 1;
    if (prevResult != "0" && first.isEmpty) {
      first = prevResult;
    }
    prevResult = "0";
    operation = "x";
    updateResult(selected);
  }

  void back() {
    setState(() {
      if (selected == 0) {
        if (first.length > 1) {
          first = first.substring(0, first.length - 1);
        } else {
          first = "0";
        }
        updateResult(selected);
      } else if (selected == 1) {
        if (second.length > 1) {
          second = second.substring(0, second.length - 1);
        } else {
          second = "";
          if (operation.isNotEmpty) {
            operation = "";
          } else {
            selected = 0;
            first = first.substring(0, first.length - 1);
          }
        }

        if (result != "0") {
          result = "0";
          string = "0";
        }

        updateResult(selected);
      }
    });
  }

  void clear() {
    setState(() {
      result = "";
      first = "";
      operation = "";
      second = "";
      selected = 0;
      fontSize = 42.0;
      string = "0";
    });
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
                    string,
                    textAlign: TextAlign.end,
                    style: getStyle(font: fontSize),
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
      setState(() {
        switch (string) {
          case "add":
            add();
            break;
          case "minus":
            minus();
            break;
          case "x":
            mul();
            break;
          case "÷":
            div();
            break;
          case "back":
            back();
            break;
          case "C":
            clear();
            break;
          default:
            {
              addNum(string);
            }
        }
      });
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
