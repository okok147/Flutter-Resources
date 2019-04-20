

import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => new _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Color.fromRGBO(50, 145, 249, 1.0),
                        Color.fromRGBO(72, 197, 247, 1.0)
                      ])),
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 250.0,
                      ),
                      Container(
                        height: 60.0,
                        width: MediaQuery.of(context).size.width - 96.0,
                        margin: EdgeInsets.only(
                            left: 24.0, right: 24.0, top: 12.0, bottom: 6.0),
                        decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.all(Radius.circular(30.0)),
                            color: Color.fromRGBO(30, 61, 168, 1.0)),
                        alignment: Alignment.center,
                        child: RichText(
                          text: TextSpan(children: <TextSpan>[
                            TextSpan(
                                text: "Sign Up With ",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14.0)),
                            TextSpan(
                                text: "Facebook",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18.0))
                          ]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: RichText(
                          text: TextSpan(children: <TextSpan>[
                            TextSpan(
                                text: "Aleady have an account ? ",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 14.0)),
                            TextSpan(
                                text: "Sign In",
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 14.0,
                                    letterSpacing: 0.5))
                          ]),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 2 - 80.0,
            left: 12.0,
            right: 12.0,
            child: Container(
                height: 300.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  color: Colors.white,
                ),
                child: Card(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 28.0, right: 28.0, top: 14.0, bottom: 7.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                              labelStyle: TextStyle(color: Colors.grey),
                              filled: false,
                              hintText: 'Full name',
                              labelText: 'Full Name',
                              suffixIcon: Icon(Icons.person)),
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 28.0, right: 28.0, bottom: 7.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            filled: false,
                            suffixIcon: Icon(Icons.email),
                            labelStyle: TextStyle(color: Colors.grey),
                            hintText: 'Email',
                            labelText: 'Email',
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 28.0, right: 28.0, bottom: 7.0),
                        child: TextFormField(
                          obscureText: true,
                          decoration: const InputDecoration(
                            filled: false,
                            labelStyle: TextStyle(color: Colors.grey),
                            suffixIcon: Icon(Icons.lock),
                            hintText: 'Password',
                            labelText: 'Password',
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                    ],
                  ),
                )),
          ),
          Positioned(
            right: 24.0,
            left: 24.0,
            top: MediaQuery.of(context).size.height / 2 - 80.0 + 300.0 - 30.0,
            child: Container(
              height: 60.0,
              width: MediaQuery.of(context).size.width - 48.0,
              margin: EdgeInsets.only(left: 24.0, right: 24.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
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
        ],
      ),
    );
  }
}
