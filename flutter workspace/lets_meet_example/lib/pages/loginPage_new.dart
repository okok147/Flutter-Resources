import 'dart:async';
import 'dart:convert';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lets_meet_flutter/main.dart';
import 'package:lets_meet_flutter/util/Global.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validate/validate.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import "package:http/http.dart" as http;

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'https://www.googleapis.com/auth/userinfo.profile',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  _LoginData _data = new _LoginData();
  Map<String, String> _form = new Map<String, String>();
  bool isLoggedIn = false;
  bool isLoading = false;
  GoogleSignInAccount _currentUser;
  String _contactText;
  String google_token;
  String forget_password_email;

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      _currentUser = account;
      google_send_token();
    });
  }

  Future google_send_token() async {
    if (this.mounted) {
      setState(() {
        isLoading = true;
      });
    }
    var response_google_user = await Request.getDio().get("google/login",
        data: {"GOOGLETOKEN": await _currentUser.authentication});
    if (response_google_user.data["Code"] == 200) {
      Global.Token = response_google_user.data['Data']['Token'];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('Token', Global.Token);
      await getUser();
      if (this.mounted) {
        setState(() {
          isLoading = false;
        });
      }
      _googleSignIn.disconnect();
      Global.router.navigateTo(context, "/Home",
          transition: TransitionType.fadeIn, replace: true);
    } else {
      if (this.mounted) {
        setState(() {
          isLoading = false;
        });
      }
      showDialog(
        context: context,
        child: AlertDialog(
          content: Text("Some Error in Google Login"),
        ),
      );
    }
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  void onLoginStatusChanged(bool isLoggedIn) {
    if (this.mounted) {
      setState(() {
        this.isLoggedIn = isLoggedIn;
      });
    }
  }

  void initiateFacebookLogin() async {
    var facebookLogin = FacebookLogin();
    var facebookLoginResult =
        await facebookLogin.logInWithReadPermissions(['email']);
    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        print("Error");
        print(facebookLoginResult.errorMessage);
        onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.cancelledByUser:
        print("CancelledByUser");
        onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.loggedIn:
        if (this.mounted) {
          setState(() {
            isLoading = true;
          });
        }
        print("LoggedIn");
        var response_facebook = await Request.getDio().get("facebook/login",
            data: {"FBTOKEN": facebookLoginResult.accessToken.token});
        if (response_facebook.data["Code"] == 200) {
          Global.Token = response_facebook.data['Data']['Token'];
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('Token', Global.Token);
          await getUser();
          if (this.mounted) {
            setState(() {
              isLoading = false;
            });
          }
          Global.router.navigateTo(context, "/Home",
              transition: TransitionType.fadeIn, replace: true);
        } else {
          if (this.mounted) {
            setState(() {
              isLoading = false;
            });
          }
          showDialog(
              context: context,
              child: AlertDialog(
                content: Text("Some Error in Facebook Login"),
              ));
        }
        break;
    }
  }

  Future submit() async {
    // First validate form.// Save our form now.
    var response = await Request.getDio().post("login",
        data: {"Email": _form["email"], "Password": _form["password"]});
    if (response.data['Code'] == 200) {
      Global.Token = response.data['Data']['Token'];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (Global.remember_me == true) {
        prefs.setString('Token', response.data['Data']['Token']);
      }
      await getUser();
      Global.router.navigateTo(context, "/Home",
          transition: TransitionType.fadeIn, replace: true);
    } else {
      showDialog(
          context: context,
          builder: (BuildContext) {
            return AlertDialog(
              // content: Text("額外資料: ${widget.val['LeaveMSG'].toString()}"),
              content: Text("Please Enter Correct Email And Password"),
              // content: Text(true?"true":"false"),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: isLoading == true
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Image.asset(
                      "images/backgroundNew.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Form(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 10.0,
                        right: 10.0,
                        top: 25.0,
                      ),
                      child: Container(
                        key: _formKey,
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        // alignment: Alignment.bottomCenter,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // controller: _scrollController,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: Text(
                                "LOG IN",
                                style: Global.stlye_title,
                              ),
                            ),
                            Column(children: <Widget>[
                              Container(
                                  height: 37.4,
                                  margin: const EdgeInsets.only(bottom: 20.5),
                                  child: UglyText(
                                    src: _form,
                                    tag: "email",
                                    hint: 'email',
                                  )),
                              Container(
                                  height: 37.4,
                                  child: UglyText(
                                    src: _form,
                                    tag: "password",
                                    hint: 'password',
                                    obscureText: true,
                                  )),
                              Row(
                                children: <Widget>[
                                  Checkbox(
                                    activeColor: Colors.white.withOpacity(0.5),
                                    value: Global.remember_me,
                                    onChanged: (bool value) {
                                      if (this.mounted) {
                                        setState(() {
                                          Global.remember_me =
                                              !Global.remember_me;
                                        });
                                      }
                                    },
                                  ),
                                  Text(
                                    "Remember Me",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                              FullWidthButton(
                                "log in",
                                color: Colors.white.withOpacity(0.5),
                                onPressed: () {
                                  submit();
                                },
                              ),
                              Container(
                                  margin: new EdgeInsets.only(bottom: 27.0),
                                  child: Center(
                                      child: InkWell(
                                          onTap: () async {
                                            showDialog(
                                              context: context,
                                              child: AlertDialog(
                                                contentPadding:
                                                    const EdgeInsets.all(16.0),
                                                content: new Row(
                                                  children: <Widget>[
                                                    new Expanded(
                                                      child: new TextField(
                                                        autocorrect: false,
                                                        onChanged: (s) {
                                                          forget_password_email =
                                                              s;
                                                        },
                                                        autofocus: true,
                                                        decoration: new InputDecoration(
                                                            labelText:
                                                                'Enter your Email Address',
                                                            hintText:
                                                                'e.g. peter@gmail.com'),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                actions: <Widget>[
                                                  new FlatButton(
                                                      child:
                                                          const Text('CANCEL'),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      }),
                                                  new FlatButton(
                                                      child: const Text('OK'),
                                                      onPressed: () async {
                                                        var response = await Request.getDio().post(
                                                            "user/forget/password",
                                                            data: {
                                                              "Email":
                                                                  forget_password_email
                                                            });
                                                        Navigator.pop(context);
                                                        if(response.data["Code"] != 200){
                                                          showDialog(
                                                            context: context,
                                                            child: AlertDialog(
                                                              content: Text("Email address is not existed"),
                                                            )
                                                          );
                                                        }
                                                      })
                                                ],
                                              ),
                                            );
                                          },
                                          child: Text("forget password",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12.0,
                                                  fontFamily:
                                                      "HelveticaNeue"))))),
                              Container(
                                  margin: new EdgeInsets.only(bottom: 35.8),
                                  child: Center(
                                      child: Text("OR",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14.0,
                                              fontFamily: "HelveticaNeue")))),
                              FullWidthButton(
                                'sign in with Facebook',
                                onPressed: () {
                                  initiateFacebookLogin();
                                },
                                color: Color(0xff383DC8),
                              ),
                              FullWidthButton(
                                'sign in with Google',
                                onPressed: () async {
                                  await _handleSignIn();
                                },
                                color: Colors.white,
                                fontColor: Color(0xFF474747),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 50.0),
                                child: FullWidthButton('sign in with email',
                                    onPressed: () {
                                  Global.router.navigateTo(context, "/Register",
                                      transition: TransitionType.native,
                                      replace: true);
                                }),
                              )
                            ]),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ));
  }
}

class FullWidthButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color color;
  final String text;
  final Color fontColor;

  const FullWidthButton(this.text,
      {Key key,
      @required this.onPressed,
      this.color = Colors.grey,
      this.fontColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final Size screenSize = MediaQuery.of(context).size;
    return new Container(
      height: 34.4,
      decoration: new ShapeDecoration(
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.all(Radius.circular(14.0)))),
      width: screenSize.width,
      child: new FlatButton(
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(14.0)),
          child: new Text(
            // 'sign in with Facebook',
            text,
            style: new TextStyle(
                color: (fontColor == null) ? Colors.white : fontColor,
                fontFamily: "HelveticaNeue",
                fontSize: 16.0,
                height: 0.8),
          ),
          onPressed: onPressed,
          //color: Color(0xff383DC8)
          color: (color != null) ? color : Colors.white.withOpacity(0.5)),
      margin: new EdgeInsets.only(top: 20.0, bottom: 4.0),
    );
  }
}

class UglyText extends StatefulWidget {
  final String tag;
  final Map<String, String> src;
  final FormFieldValidator<String> validator;
  final String hint;
  final bool obscureText;
  final VoidCallback cb;

  UglyText(
      {Key key,
      this.tag,
      this.validator,
      this.hint,
      this.src,
      this.obscureText: false,
      this.cb})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => _UglyText();
}

class _UglyText extends State<UglyText> {
  FocusNode fNode;
  @override
  void dispose() {
    // TODO: implement dispose
    // fNode.removeListener(tListener);
    fNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    Global.context = context;
    fNode = new FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var hint = fNode.hasFocus ? "" : this.widget.hint;
    return DecoratedBox(
      decoration: BoxDecoration(
          border: Border.all(width: 2.0, color: Colors.white),
          borderRadius: BorderRadius.circular(14.0)),
      child: new TextField(
        autocorrect: false,
        style: Global.style_input,
        focusNode: fNode,
        // key: emailKey,
        keyboardType:
            TextInputType.emailAddress, // Use email input type for emails.
        obscureText: this.widget.obscureText,
        textAlign: TextAlign.center,
        decoration: new InputDecoration(
          border: InputBorder.none,
          hintStyle: Global.style_input,
          hintText: hint,
        ),

        // validator: this.widget.validator,
        onChanged: (s) {
          this.widget.src[this.widget.tag] = s;
        },
        // validator: (value) {
        //   if (value.isEmpty) {
        //     return 'Please enter some text';
        //   }
        // },

        // onSaved: (String value) {
        //   print(value);
        //   this.widget.src[this.widget.tag] = value;
        // }
      ),
    );
  }
}

class _LoginData {
  String email = '';
  String password = '';
  String first_name = "";
  String last_name = "";
}
