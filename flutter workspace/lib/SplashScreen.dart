import 'dart:async';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'util/Global.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> animation;
  CurvedAnimation curve;

  AnimationController _controller2;
  Animation<double> animation2;
  CurvedAnimation curve2;

  AnimationController _controller3;
  Animation<double> animation3;
  CurvedAnimation curve3;

  bool loading = false;

  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return false;
    else
      return true;
  }

  @override
  void initState() {
    super.initState();

    renew();
  }

  void renew() async{
    
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    curve = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    animation = Tween(begin: 0.0, end: 1.0).animate(curve)
      ..addListener(() {
        setState(() {});
      });

    _controller3 =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    curve3 = CurvedAnimation(parent: _controller3, curve: Curves.easeOut);
    animation3 = Tween(begin: 0.0, end: 1.0).animate(curve3)
      ..addListener(() {
        setState(() {});
      });

    _controller2 =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    curve2 = CurvedAnimation(parent: _controller2, curve: Curves.easeOut);
    animation2 = Tween(begin: 0.0, end: 1.0).animate(curve2)
      ..addListener(() {
        // print(MediaQuery.of(context).size.height);

        if (_controller2.status == AnimationStatus.completed) {
          FocusScope.of(context).requestFocus(fs1);
          print(MediaQuery.of(context).viewInsets.bottom);
        }
        setState(() {});
      });
      
      //await Future.delayed(Duration(milliseconds: 10000));
      //Global.api(context).getProfile();
      
   
    Global.api(context).getProfile().then((r) async {
      print(r);
      if (r.Code == 200  ) {
        Timer(Duration(seconds: 1), () {
          Global.router.navigateTo(context, "/MainPage",
              transition: TransitionType.fadeIn, replace: true);
        });
      } else if (r.Code == 1001 || r.Code==1071 ) {
        Timer(Duration(seconds: 1), () {
          _controller.forward(from: 0.0);
        });
      } else {
        await Global.showAlert(r.Msg ?? "未連接網絡，請重試",context: context).then((f) {
          Global.router.navigateTo(context, "/ErrorPage",
              transition: TransitionType.fadeIn, replace: true);
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _controller2.dispose();
    _controller3.dispose();
  }

  FocusNode fs1 = new FocusNode();
  FocusNode fs2 = new FocusNode();
  FocusNode fs3 = new FocusNode();
  FocusNode fs4 = new FocusNode();

  PageController pageController = new PageController();
  String code = "";
  String phone = "";
  String password = "";
  String name = "";
  String email = "";
  @override
  Widget build(BuildContext context) {
    var ww = MediaQuery.of(context).size.width;
    var hh = MediaQuery.of(context).size.height;
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: new GestureDetector(
          onTap: () {
            print("?");
            // FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Stack(
            children: <Widget>[
              Image.asset(
                "images/login.png",
                fit: BoxFit.cover,
                width: ww,
                height: hh,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: InkResponse(
                      child: Center(
                          child: Transform.scale(
                              scale: 1.0 -
                                  (animation.value) * .1 -
                                  (animation2.value) * .9,
                              child: Logo1())),
                      //  onTap: (){
                      //     _controller.forward( from: 0.0);
                      //  },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: Container(
                        child: Text("司機APP",
                            style:
                                TextStyle(color: Colors.white, fontSize: 25.0)),
                      ),
                    ),
                  ),
                  Container(
                    child: PhysicalModel(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(30.0)),
                      elevation: 8.0,
                      child: InkResponse(
                        onTap: () {
                          _controller2.forward();
                        },
                        child: Container(
                          width: ww,
                          height: 200.0 * animation.value +
                              (hh - 300) * animation2.value,
                          child: PageView(
                            controller: pageController,
                            physics: NeverScrollableScrollPhysics(),
                            onPageChanged: (n) {
                              if (n == 0) {
                                FocusScope.of(context).requestFocus(fs1);
                              }
                              if (n == 1) {
                                FocusScope.of(context).requestFocus(fs3);
                              }
                              if (n == 2) {
                                FocusScope.of(context).requestFocus(fs3);
                              }
                              if (n == 3) {
                                FocusScope.of(context).requestFocus(fs4);
                              }
                            },
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 23.0, horizontal: 37.0),
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          "輸入你的車牌",
                                          style: Global.login_1,
                                        ),
                                      ],
                                    ),
                                  ),
                                  // SizedBox(height: 35.0,),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 35.0, vertical: 0.0),
                                    child: TextField(
                                      focusNode: fs1,
                                      onChanged: (s) {
                                        email = s;
                                        _controller3.forward();
                                      },
                                      enabled: !loading &&
                                          _controller2.status ==
                                              AnimationStatus.completed,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                          hintText: "輸入你的車牌",
                                          hintStyle: Global.login_2,
                                          prefixIcon: Icon(
                                            Icons.label,
                                            color: Color(0xFFF8B903),
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 23.0, horizontal: 37.0),
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          "請輸入您的密碼",
                                          style: Global.login_1,
                                        ),
                                      ],
                                    ),
                                  ),
                                  // SizedBox(height: 35.0,),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 35.0, vertical: 0.0),
                                    child: TextField(
                                      focusNode: fs3,
                                      onChanged: (s) {
                                        password = s;
                                        if (password.length >= 4) {
                                          _controller3.forward();
                                        } else {
                                          _controller3.reverse();
                                        }
                                      },
                                      enabled: !loading &&
                                          _controller2.status ==
                                              AnimationStatus.completed,
                                      keyboardType: TextInputType.text,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                          hintText: "輸入您的密碼",
                                          hintStyle: Global.login_2,
                                          prefixIcon: Icon(
                                            Icons.lock,
                                            color: Color(0xFFF8B903),
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Positioned(
                  width: 50.0,
                  height: 50.0,
                  right: 28.0,
                  bottom: hh / 2,
                  child: Transform.scale(
                    scale: animation3.value,
                    child: Offstage(
                      offstage:
                          _controller2.status != AnimationStatus.completed,
                      child: new RaisedButton(
                        color: Color(0xFFF8B903),
                        onPressed: () async {
                          if (!loading) {
                            loading = true;
                            setState(() {});
                            await Future.delayed(Duration(seconds: 1));
                            if (pageController.page == 0) {
                              var r = await Global.api(context)
                                  .adminLogin({"email": email});
                              if (r.Code == 200) {
                                _controller3.reverse();
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());
                                pageController.animateToPage(1,
                                    duration: Duration(milliseconds: 1000),
                                    curve: ElasticOutCurve());
                              } else {
                                await Global.showAlert(r.Msg);
                              }
                            }
                            print(pageController.page);

                            if (pageController.page == 1) {
                              var r = await Global.api(context).adminLogin(
                                  {"email": email, "password": password});
                              if (r.Code == 200) {
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());
                                _controller3.reverse();
                                Global.router.navigateTo(context, "/MainPage",
                                    transition: TransitionType.fadeIn,
                                    replace: true);
                              } else {
                                await Global.showAlert(r.Msg);
                              }
                            }
                            loading = false;
                            setState(() {});
                          }
                        },
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                        child: Transform.scale(
                            scale: 2.0 * _controller2.value,
                            child: loading
                                ? Container(
                                    height: 10.0,
                                    width: 10.0,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 1.0,
                                      valueColor:
                                          new AlwaysStoppedAnimation<Color>(
                                              Colors.white),
                                    ))
                                : Icon(
                                    Icons.keyboard_arrow_right,
                                    size: 18.0,
                                    color: Colors.white,
                                  )),
                      ),
                    ),
                  )),
              Global.debug
                  ? Positioned(
                      top: 40.0,
                      child: RaisedButton(
                        onPressed: () {
                          Global.router.navigateTo(context, "/ErrorPage",
                              transition: TransitionType.fadeIn, replace: true);
                        },
                      ),
                    )
                  : Container(),
            ],
          ),
        ));
  }
}

class Logo1 extends StatefulWidget {
  @override
  _Logo1State createState() => _Logo1State();
}

class _Logo1State extends State<Logo1> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> animation;
  CurvedAnimation curve;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    curve = CurvedAnimation(parent: _controller, curve: Curves.bounceOut);
    animation = Tween(begin: 0.5, end: 1.0).animate(curve)
      ..addListener(() {
        setState(() {});
      });
    _controller.forward(from: 0.0);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "images/logo1.png",
      width: 264.0 * animation.value,
      height: 249.0,
    );
  }
}
