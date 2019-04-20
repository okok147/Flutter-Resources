
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State <LoginPage> {


  String _email;
  String _password;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(

      body: Center(
        child: Container(
          padding: EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField (
                decoration: InputDecoration(hintText: 'Email'),
                onChanged: (value) {
                  setState(() {
                    _email = value;
                  });
                },
              ),
              SizedBox(height: 15.0),
              TextField (
                decoration: InputDecoration(hintText: 'Password'),
                onChanged: (value) {
                  setState(() {
                    _password = value;
                  });
                },
                obscureText: true,
              ),
              SizedBox (height: 20.0),
              RaisedButton (
                child: Text('Login'),
                color: Colors.blue,
                elevation: 7.0,
                onPressed: () {



                  //use firebase to signin,then push
                  FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: _email,
                      password: _password).then((FirebaseUser user) {
                    Navigator.of(context).pushReplacementNamed('/homepage');
                  }).catchError((e) {
                    print(e);
                  });

                },
              ),
              SizedBox (height: 15.0),
              Text ('Don\' t have an account?'),
              SizedBox (height: 10.0),
              RaisedButton (
                child: Text('Sign Up'),
                color: Colors.blue,
                textColor: Colors.white,
                elevation: 7.0,
                onPressed: (){
                  Navigator.of(context).pushNamed('/signup');

                },
              )
            ],
          ),
        ),
      ),



    );
  }
}