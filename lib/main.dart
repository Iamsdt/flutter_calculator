import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

  // This method will divide the total screen size into 4 parts
  double getWidth(BuildContext context) =>
      MediaQuery.of(context).size.width / 4;


  String string = "0"; //hold information to display
  String result = "0"; // current operation result
  String prevResult = "0"; // previous results need if user use again
  String first = ""; // first number
  String operation = ""; // math operation type
  String second = ""; // second number
  int selected = 0; // currently selected number

  double fontSize = 52.0; // current display front size

  /// THis methods will update information into display
  /// selected -> currently selected item
  void updateResult(int selected) {
    setState(() {
      // if result has some value then show the result
      if (result != "0") {
        string = result;
        result = "0";
      } else {
        //otherwise show according to current number holder
        switch (selected) {
          case 0:
            string = first;
            break;
          case 1:
            {
              if (second.isNotEmpty) {
                string = first + "\n" + operation + "\n" + second;
              } else if (operation.isNotEmpty) {
                string = first + "\n" + operation;
              }
            }
        }
      }

      //update font size
      if (first.length > 5 || second.length > 5) {
        fontSize = 42.0;
      } else if (first.length > 10 || second.length > 10) {
        fontSize = 32.0;
      } else if (first.length > 13 || second.length > 13) {
        fontSize = 28.0;
      } else if (first.length < 5 || second.length < 5) {
        fontSize = 52.0;
      }
    });
  }

  /// This methods will add number from user input (on tap)
  void addNum(String s) {
    switch (selected) {
      case 0:
        {
          // if first value is zero then replace current one
          if (first == "0") {
            //if first is zero and input is also zero do same
            if (s == "0") {
              first = s;
            } else {
              first = s;
            }
          } else {
            // if user input more than 15 number show warning
            if (first.length > 15) {
              showWarning();
            } else {
              first += s;
            }
          }
        }
        break;
      case 1:
        {
          //same like first
          if (second == "0") {
            if (s == "0") {
              second = s;
            } else {
              second = s;
            }
          } else {
            // if user input more than 15 number show warning
            if (second.length > 15) {
              showWarning();
            } else {
              second += s;
            }
          }
        }
    }
    updateResult(selected);
  }

  // this methods will show an warning to the user
  // thanks awesome library Fluttertoast
  void showWarning() {
    Fluttertoast.showToast(
        msg: "Maximum number length is 15",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 2,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0);
  }

  /// This methods will calculate and do mathematical operations
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
        // if user input has . that means
        // user input fraction value
        // then show fraction result
        // or if user did division then do same
        if (first.contains(".") || operation == "÷") {
          // if result is larger or smaller then show Exponential
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

        //save results into previous
        prevResult = result;
        //reset other values
        selected = 0;
        first = "";
        second = "";
        string = "";
        operation = "";
        //update now
        updateResult(selected);
      });
    }
  }

  /// This method will trigger when user hit add button
  void add() {
    // is user click add button then switch number holder one to second
    selected = 1;
    // if their is previous result and
    // first number holder is empty
    //then user want to do operation with this result
    if (prevResult != "0" && first.isEmpty) {
      first = prevResult;
    }
    //remove previous result
    prevResult = "0";
    // save operations
    operation = "+";
    updateResult(selected);
  }

  // minus method
  void minus() {
    selected = 1;
    if (prevResult != "0" && first.isEmpty) {
      first = prevResult;
    }
    prevResult = "0";
    operation = "-";
    updateResult(selected);
  }

  //division method
  void div() {
    selected = 1;
    if (prevResult != "0" && first.isEmpty) {
      first = prevResult;
    }
    prevResult = "0";
    operation = "÷";
    updateResult(selected);
  }

  //division method
  void mul() {
    selected = 1;
    if (prevResult != "0" && first.isEmpty) {
      first = prevResult;
    }
    prevResult = "0";
    operation = "x";
    updateResult(selected);
  }


  // this method for back press
  void back() {
    setState(() {
      //remove one number from current number holder
      switch (selected) {
        case 0:
          {
            if (first.length > 1) {
              first = first.substring(0, first.length - 1);
            } else {
              first = "0";
            }
            updateResult(selected);
          }
          break;
        case 1:
          {
            if (second.length > 1) {
              second = second.substring(0, second.length - 1);
            } else {
              second = "";
              if (operation.isNotEmpty) {
                operation = "";
                selected = 0;
              } else {
                selected = 0;
                first = first.substring(0, first.length - 1);
              }
            }
            updateResult(selected);
          }
      }
    });
  }

  /// this methods will clear all the data
  void clear() {
    setState(() {
      result = "";
      first = "";
      operation = "";
      second = "";
      selected = 0;
      fontSize = 52.0;
      string = "0";
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
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

  /// this methods will create a text widget
  Widget getText(string, {font = 32.0}) {
    return Text(
      string,
      style: getStyle(font: font),
    );
  }

  /// this the helper method for text style
  TextStyle getStyle({font: 32.0}) {
    return TextStyle(color: Colors.white, fontSize: font);
  }

  // main container widget
  Widget getContainer(string, {child, height = 80.0, font = 32.0}) {
    // if child is null create text widget with passed string
    if (child == null) {
      child = getText(string, font: font);
    }

    // click handler for all user actions
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
