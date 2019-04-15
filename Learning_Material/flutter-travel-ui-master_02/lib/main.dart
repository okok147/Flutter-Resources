import 'package:flutter/material.dart';
import 'package:travelui/ui/signin_page.dart';
import 'package:travelui/ui/signup_page.dart';

void main() {
//  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//
//    statusBarColor: Colors.transparent
//
//  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(fontFamily: 'Lato'),
      home: SignInSignUpPage(),
    );
  }
}

class SignInSignUpPage extends StatefulWidget {
  @override
  _SignInSignUpPageState createState() => new _SignInSignUpPageState();
}

class _SignInSignUpPageState extends State<SignInSignUpPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Column(
        children: <Widget>[
          Flexible(
            flex: 4,
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.only(bottom: 48.0),
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "Travel App",
                    style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w200,
                        fontSize: 42.0),
                    textAlign: TextAlign.center,
                  ),



                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Best way to organize travels",
                      style: TextStyle(color: Colors.grey, fontSize: 12.0),
                      textAlign: TextAlign.center,
                    ),
                  )



                ],
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[

                    //Sign Up Button
                    InkWell(
                      onTap: () {

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                SignUpPage()));
                      },
                      child: Container(
                        height: 60.0,
                        margin: EdgeInsets.only(
                            left: 24.0, right: 24.0, top: 12.0, bottom: 6.0),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                            gradient: LinearGradient(colors: [
                              Color.fromRGBO(50, 145, 249, 1.0),
                              Color.fromRGBO(72, 197, 247, 1.0)
                            ])),
                        alignment: Alignment.center,
                        child: Text(
                          "Sign Up",
                          style: TextStyle(color: Colors.white, fontSize: 22.0),
                        ),
                      ),


                    ),

                    //Sign In button
                    InkWell(
                      onTap: (){

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SignInPage()));
                        },
                      child: Container(
                        height: 60.0,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(
                            left: 24.0, right: 24.0, top: 6.0, bottom: 12.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30.0)),
                            color: Colors.transparent,
                            border: Border.all(
                              color: Colors.blue,
                              width: 1.0,
                            )),
                        child: Text(
                          "Sign In",
                          style: TextStyle(color: Colors.blue, fontSize: 22.0),
                        ),
                      ),
                    ),




                  ],


                )),
          ),
        ],
      ),
    );
  }
}
