import 'package:flutter/material.dart';


import 'package:firebase_auth/firebase_auth.dart';
import 'services/usermanagement.dart';
import 'package:flare_flutter/flare_actor.dart';


class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}



class _SignupPageState extends State <SignupPage> {


  String _email;
  String _password;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(

      body: new Stack(










        children: <Widget>[


          Container(


            padding: EdgeInsets.all(55.0),
            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[



                TextField (
                  decoration: InputDecoration(hintText: 'Email',border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(const Radius.circular(30.0))
                  )),
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
                ),
                SizedBox (height: 30.0),
                RaisedButton (


                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)
                  ),
                  child: Text('Sign Up'),
                  color: Colors.blue,
                  textColor: Colors.white,
                  elevation: 7.0,
                  onPressed: (){

                    FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                        email: _email, password: _password)
                        .then((signedInUser)  {
                      UserManagement().storeNewUser(signedInUser, context);


                    })
                        .catchError((e){
                          print(e);
                    });

                  },
                )
              ],
            ),
          ),

        ],


      ),



    );
  }
}



