import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../User.dart';
import 'rest_ds.dart';

// import 'package:image_picker/image_picker.dart';

class Global {
  //GlobalKey mainApp = new GlobalKey();
  // static const FloatingActionButtonLocation endFloat = MuPo();
  static MyAppState appState;
  static RestDatasource _api = new RestDatasource();
  static BuildContext mainContext;
  
  static dynamic tmpStore;
  
  static List<dynamic> messageList = new List();
  static List<dynamic> drinkList = new List();
  static List<dynamic> notifications;
  static User me;
  
  static const bool debug = false;
  static bool booking = false;
  static int watching = 0;
  static const alipay = const MethodChannel('com.basezero/alipayhk');
  static var filterOption = [
    ["2018", "2019"],
    [
      "1",
      "2",
      "3",
      "4",
      "5",
      "6",
      "7",
      "8",
      "9",
      "10",
      "11",
      "12",
    ],
    [
      "28",
      "45",
      "65",
    ]
  ];



  static dynamic reload;
  

  static String busNameByID(String ID) {
    if (ID == "1") {
      return "28座";
    }
    if (ID == "2") {
      return "45座";
    }
    if (ID == "3") {
      return "65座";
    }

    if (ID == "4") {
      return "水晶巴士";
    }

    if (ID == "5") {
      return "豪華商務禮賓車";
    }
    return "";
  }

  static String busImgByID(String ID) {
    if (ID == "1") {
      return "images/28 bus icon.png";
    }
    if (ID == "2") {
      return "images/65 bus icon.png";
    }
    if (ID == "3") {
      return "images/65 bus icon.png";
    }
    return "";
  }

  static String toWineString(String ls) {
    if (ls == null || ls == "") return null;
    var a = ls.split(",");
    return a
        .map((f) => drinkList
            .singleWhere((ff) => ff["ID"].toString() == f.toString())["Name"])
        .join(", ");
  }

  static Future<void> showLoading(context) {
    if (context != null) mainContext = context;
    return showDialog(
        context: mainContext,
        builder: (context) {
          return Theme(
            data: ThemeData(accentColor: Colors.white),
            child: Scaffold(
              // appBar: AppBar(),
              backgroundColor: Colors.transparent,
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        });
  }

  static String formatDDMMYY(DateTime tm) {
    if (tm.year == DateTime.now().year) {
      return new DateFormat("M月d日").format(tm);
    } else {
      return new DateFormat("yy年M月d日").format(tm);
    }
  }

  static DateTime fromTime(TimeOfDay t) {
    final now = new DateTime.now();
    return new DateTime(now.year, now.month, now.day, t.hour, t.minute);
  }

  static String fd1(DateTime tm) {
    return new DateFormat("HH時mm分").format(tm);
  }

  static String fd2(TimeOfDay tm) {
    return fd1(fromTime(tm));
  }

  static bool isFast(DateTime tm) {
    DateTime today = new DateTime.now();

    Duration difference = tm.difference(today);
    //print(difference.compareTo(oneDay));

    if (difference.inHours < 2) {
      return true;
    } else
      return false;
  }

  static bool isToday(DateTime tm) {
    var t = DateTime.now();
    return (tm.day == t.day && tm.month == t.month && tm.year == t.year);
    // DateTime today = new DateTime.now();
    // Duration oneDay = new Duration(days: 1);

    // Duration difference = today.difference(tm);
    // //print(difference.compareTo(oneDay));
    // if (difference.compareTo(oneDay) < 1 && (DateTime.now().day == tm.day)) {
    //   return true;
    // } else
    //   return false;
  }

  static Future<bool> showConfirm(String msg, {context}) {
    if (context != null) mainContext = context;

    var b = showDialog<bool>(
        context: mainContext,
        builder: ((context) {
          return new AlertDialog(
            title: new Text("租租巴"),
            content: new Text(msg),
            actions: <Widget>[
              RaisedButton(
                color: Colors.lightGreen,
                child: Text("確定", style: TextStyle(color: Colors.white)),
                onPressed: () {
                  Navigator.pop(context, true);
                },
              ),
              RaisedButton(
                color: Colors.red,
                child: Text(
                  "取消",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.pop(context, false);
                },
              )
            ],
          );
        }));

    return b;
  }

  static Future<void> showAlert(String msg, {context}) {
    if (context != null) mainContext = context;

    return showDialog(
        context: mainContext,
        builder: ((context) {
          return new AlertDialog(
            title: new Text("租租巴"),
            content: new Text(msg),
            actions: <Widget>[
              RaisedButton(
                child: Text("好"),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        }));
  }

  static RestDatasource api(BuildContext context) {
    mainContext = context;
    return _api;
  }

  static final router = new Router();
  static const TextStyle login_1 = TextStyle(
      color: Color(0xFF333333), fontSize: 22.0, fontWeight: FontWeight.w700);
  static const TextStyle login_2 = TextStyle(
      color: Color(0xFF999999), fontSize: 17.0, fontWeight: FontWeight.w700);
  static const TextStyle main_1 = TextStyle(
      color: Color(0xFFFFFFFF), fontSize: 36.0, fontWeight: FontWeight.w500);
  static const TextStyle main_2 = TextStyle(
      color: Color(0xFF585858), fontSize: 24.0, fontWeight: FontWeight.w500);
  static const TextStyle main_2b = TextStyle(
      color: Color(0xFFFFFFFF), fontSize: 24.0, fontWeight: FontWeight.w500);
  static const TextStyle main_3 = TextStyle(
      color: Color(0xFF585858), fontSize: 16.0, fontWeight: FontWeight.w500);
  static const TextStyle main_4 = TextStyle(
      color: Color(0xFFFFFFFF), fontSize: 16.0, fontWeight: FontWeight.w500);
  static const TextStyle main_5 = TextStyle(
      color: Color(0xFF585858), fontSize: 16.0, fontWeight: FontWeight.w700);
  static const TextStyle h1 = TextStyle(
      color: Color(0xFF4D4D4D), fontSize: 24.0, fontWeight: FontWeight.w500);
  static const TextStyle h2 = TextStyle(
      color: Color(0xFF4D4D4D), fontSize: 22.0, fontWeight: FontWeight.w700);
  static const TextStyle h3 = TextStyle(
      color: Color(0xFF666666), fontSize: 18.0, fontWeight: FontWeight.w700);
  static const TextStyle h4 = TextStyle(
      color: Color(0xFF666666), fontSize: 13.0, fontWeight: FontWeight.w700);
  static const TextStyle h5 = TextStyle(
      color: Color(0xFF4D4D4D), fontSize: 15.0, fontWeight: FontWeight.w700);
  static const TextStyle h6 = TextStyle(
      color: Color(0xFF999999), fontSize: 12.0, fontWeight: FontWeight.w700);
  static const TextStyle h7 = TextStyle(
      color: Color(0xFF4D4D4D), fontSize: 13.0, fontWeight: FontWeight.w700);
  static const TextStyle b1 = TextStyle(
      color: Color(0xFFFFE01B), fontSize: 10.0, fontWeight: FontWeight.w700);
  static const TextStyle b2 = TextStyle(
      color: Color(0xFF666666), fontSize: 10.0, fontWeight: FontWeight.w700);
  static const TextStyle b3 = TextStyle(
      color: Color(0xFF666666), fontSize: 21.0, fontWeight: FontWeight.w700);
  static const TextStyle b4 = TextStyle(
      color: Color(0xFF666666), fontSize: 13.0, fontWeight: FontWeight.w700);
  static const TextStyle b5 = TextStyle(
      color: Color(0xFF666666), fontSize: 16.0, fontWeight: FontWeight.w700);
  static const TextStyle b6 = TextStyle(
      color: Color(0xFF666666), fontSize: 24.0, fontWeight: FontWeight.w700);
  static const TextStyle b7 = TextStyle(
      color: Color(0xFFb3b3b3), fontSize: 13.0, fontWeight: FontWeight.w700);
  static const TextStyle b7b = TextStyle(
      color: Color(0xFF666666), fontSize: 13.0, fontWeight: FontWeight.w700);

  static const TextStyle c1 = TextStyle(
      color: Color(0xFF666666), fontSize: 24.0, fontWeight: FontWeight.w700);
  static const TextStyle c2 = TextStyle(
      color: Color(0xFFDCAA0E), fontSize: 42.0, fontWeight: FontWeight.w700);
  static const TextStyle c3 = TextStyle(
      color: Color(0xFFDCAA0E), fontSize: 21.0, fontWeight: FontWeight.w700);
  static const TextStyle c4 = TextStyle(
      color: Color(0xFF666666), fontSize: 21.0, fontWeight: FontWeight.w700);
  static const TextStyle c5 = TextStyle(
      color: Color(0xFF666666), fontSize: 16.0, fontWeight: FontWeight.w400);
  static const TextStyle c6 = TextStyle(
      color: Color(0xFF666666), fontSize: 18.0, fontWeight: FontWeight.w700);

  static const TextStyle d1 = TextStyle(
      color: Color(0xFF666666), fontSize: 24.0, fontWeight: FontWeight.w700);
  static const TextStyle d2 = TextStyle(
      color: Color(0xFF666666), fontSize: 16.0, fontWeight: FontWeight.w400);
  static const TextStyle d3 = TextStyle(
      color: Color(0xFF666666), fontSize: 16.0, fontWeight: FontWeight.w700);
  static const TextStyle d4 = TextStyle(
      color: Color(0xFFDCAA0E), fontSize: 24.0, fontWeight: FontWeight.w700);
  static const TextStyle d4b = TextStyle(
      color: Colors.lightGreen, fontSize: 24.0, fontWeight: FontWeight.w700);
  static const TextStyle d5 = TextStyle(
      color: Color(0xFF666666), fontSize: 16.0, fontWeight: FontWeight.w400);
  static const TextStyle d6 = TextStyle(
      color: Color(0xFFDCAA0E), fontSize: 16.0, fontWeight: FontWeight.w700);
  static const TextStyle d7 = TextStyle(
      color: Color(0xFF666666), fontSize: 13.0, fontWeight: FontWeight.w400);

  static const TextStyle ad1 = TextStyle(
      color: Color(0xFFFFFFFF), fontSize: 25.0, fontWeight: FontWeight.w700);
  static const TextStyle ad2 = TextStyle(
      color: Color(0xFFFFFFFF), fontSize: 25.0, fontWeight: FontWeight.w700);

  static Widget background(context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Image.asset(
        "img/Background.png",
        fit: BoxFit.cover,
      ),
    );
  }

  static Widget background2(context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Image.asset(
        "img/background2.png",
        fit: BoxFit.cover,
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() {
    Global.appState = new MyAppState();
    return Global.appState;
  }
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Global.router.generator,
      theme: new ThemeData(
          fontFamily: "Nova",
          //  primarySwatch:  Colors.yellow
          primaryColor: Colors.black,
          accentColor: Colors.black
          // textTheme:  TextTheme(

          // )
          ),
    );
  }
}

class Header extends StatefulWidget {
  final bool isProfile;

  const Header({Key key, this.isProfile = false}) : super(key: key);
  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    var ww = MediaQuery.of(context).size.width;
    var hh = MediaQuery.of(context).size.height;
    var pt = MediaQuery.of(context).padding.top;
    return PhysicalModel(
      elevation: 3.0,
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(30.0)),
      color: Color(0xFFFFD628),
      child: Container(
        width: ww,
        height: 70.0 + pt,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: pt + 10.0,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    size: 30.0,
                    color: Color(0xFF666666),
                  ),
                ),
                InkResponse(
                    onTap: () {
                      while (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    },
                    child: Image.asset(
                      "images/logo.png",
                      width: 107.0,
                    )),
                widget.isProfile
                    ? SizedBox(
                        width: 50.0,
                      )
                    : IconButton(
                        onPressed: () {
                          Global.router.navigateTo(context, "/ProfilePage",
                              transition: TransitionType.fadeIn,
                              replace: false);
                        },
                        icon: Icon(
                          Icons.account_circle,
                          size: 30.0,
                          color: Color(0xFF666666),
                        ),
                      )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BzSelector extends StatefulWidget {
  final Widget ori;
  final Widget act;
  final void Function(bool) callback;
  final bool selected;

  const BzSelector(
      {Key key, this.ori, this.selected = false, this.act, this.callback})
      : super(key: key);
  @override
  _BzSelectorState createState() => _BzSelectorState();
}

class _BzSelectorState extends State<BzSelector> {
  bool selected;

  @override
  void initState() {
    selected = widget.selected;
    super.initState();
  }

  void open() {
    setState(() {
      selected = !selected;
      widget.callback(selected);
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: () {
        open();
      },
      child: selected ? widget.act : widget.ori,
    );
  }
}
