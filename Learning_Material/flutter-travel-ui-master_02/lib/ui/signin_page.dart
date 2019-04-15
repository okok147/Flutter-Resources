import 'package:flutter/material.dart';
import 'package:travelui/ui/dashboard.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => new _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
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
                        height: 150.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: RichText(
                          text: TextSpan(children: <TextSpan>[
                            TextSpan(
                                text: "Don't have an account ? ",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 14.0)),
                            TextSpan(
                                text: "Create Now",
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
                height: 200.0,
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
                              hintText: 'Name or E-mail',
                              labelText: 'Name or E-mail',
                              suffixIcon: Icon(Icons.person)),
                          keyboardType: TextInputType.text,
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
            top: MediaQuery.of(context).size.height / 2 - 80.0 + 200.0 - 30.0,
            child: InkWell(
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            DashboardPage()));

              },

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
                  "Sign In",
                  style: TextStyle(color: Colors.white, fontSize: 22.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
