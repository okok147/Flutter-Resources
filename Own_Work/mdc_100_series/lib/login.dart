import 'package:flutter/material.dart';
import 'package:Shrine/home.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: SafeArea(
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 58.0),
        children: <Widget>[
          SizedBox(height: 80.0),
          Column(
            children: <Widget>[
              //An image of Shrine's logo
              Image.asset('assets/diamond.png'),
              SizedBox(height: 16.0),

              //The name of the app(Shrine)
              Text('Login SHRINE'),
            ],
          ),
          SizedBox(height: 120.0),

          //Two text fields,one for entering a username and the other for a password
          TextField(
            controller: _usernameController,
            decoration: InputDecoration(
              filled: true,
              labelText: 'UserName',
            ),
          ),

          SizedBox(height: 12.0),
          TextField(
            controller: _passwordController,
            decoration: InputDecoration(
              filled: true,
              labelText: 'Password',
            ),
            obscureText: true,
          ),
          SizedBox(height: 16.0),

          //Two buttons
          ButtonBar(
            children: <Widget>[
              FlatButton(
                child: Text('CANCEL'),
                onPressed: () {
                  _usernameController.clear();
                  _passwordController.clear();
                },
              ),
              RaisedButton(
                child: Text('NEXT'),
                onPressed: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new HomePage()));
                },
              )
            ],
          )
        ],
      ),
    ));
  }
}
