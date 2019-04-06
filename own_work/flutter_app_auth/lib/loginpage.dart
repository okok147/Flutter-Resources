import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_flare/smart_flare.dart';

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

          //distance between two sides

          padding: EdgeInsets.all(55.0),
          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField (


                decoration: InputDecoration(hintText: 'Email',border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(const Radius.circular(30.0)))),
                onChanged: (value) {
                  setState(() {
                    _email = value;
                  });
                },
              ),
              SizedBox(height: 15.0),
              TextField (
                
                
                decoration: InputDecoration(hintText: 'Password',border: new OutlineInputBorder(
                  borderRadius: const BorderRadius.all(const Radius.circular(30.0))
                )),
                
                onChanged: (value) {
                  setState(() {
                    _password = value;
                  });
                },
                obscureText: true,
              ),
              SizedBox (height: 20.0),
              RaisedButton (
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
                child: Text('Login'),
                color: Colors.lightBlueAccent,
                  textColor: Colors.white,
                  splashColor: Colors.white,
                  //the distance between widget and background
                  elevation: 7.0,
                onPressed: () {


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
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)
                ),
                child: Text('Sign Up'),
                color: Colors.blueGrey,
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