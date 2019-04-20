import 'package:flutter/material.dart';
import 'package:clone_travel_ui/ui/signin_page.dart';

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
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        //space between flexible of blue background
                        height: 134.0,
                      ),


                    ],
                  ),
                ),
              )
            ],
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 2 - 220.0,
            left: 12.0,
            right: 12.0,
            child: Container(
                height: 300.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(9.0)),
                  color: Colors.white10,
                ),
                  child: Card(

                  child: Column(
                    children: <Widget>[

                      Padding(
                        padding: const EdgeInsets.only(
                            left: 28.0, right: 28.0, top: 14.0, bottom: 7.0),
                        //Full Name Textfield
                        child: TextFormField(
                          decoration: const InputDecoration(
                              labelStyle: TextStyle(color: Colors.grey),
                              filled: false,
                              hintText: 'Full name',
                              labelText: 'Full Name',
                              suffixIcon: Icon(Icons.person_outline)),
                          keyboardType: TextInputType.text,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(
                            left: 28.0, right: 28.0, bottom: 7.0),
                        //Email Textfield
                        child: TextFormField(
                          decoration: const InputDecoration(
                            filled: false,
                            suffixIcon: Icon(Icons.alternate_email),
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
                        //Password Textfield
                        child: TextFormField(
                          //to hide the text when typing
                          obscureText: true,
                          decoration: const InputDecoration(
                            filled: false,
                            labelStyle: TextStyle(color: Colors.grey),
                            suffixIcon: Icon(Icons.lock_open),
                            hintText: 'Password',
                            labelText: 'Password',
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),



                    ],
                  ),
                  ),
                ),
          ),
          Positioned(

            right: 24.0,
            left: 24.0,
            top: MediaQuery.of(context).size.height / 2 - 215.0 + 300.0 - 50.0,
            child: Column(
              children: <Widget>[
                InkWell(
                  onTap: (){
                    print('Navigate to SignUpPage ~');
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
                  },

                  child: Container(
                    height: 60.0,
                    margin: EdgeInsets.only(left: 24.0,right: 24.0,top: 12.0,bottom: 6.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        gradient: LinearGradient(colors: [
                          Color.fromRGBO(50, 145, 248, 1.0),
                          Color.fromRGBO(71, 196, 246, 0.9)
                        ])),

                    alignment: Alignment.center,
                    child: Text('Sign Up',
                        style: TextStyle(
                            color: Colors.white,fontSize: 22.0)
                    ),
                  ),
                ),


              ],
            ),
          ),

          Positioned(

            right: 24.0,
            left: 24.0,
            top: MediaQuery.of(context).size.height / 2 - 215.0 + 384.0 - 50.0,
            child: Column(
              children: <Widget>[
                InkWell(
                  onTap: (){
                    print('Navigate to SignUpPage ~');
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
                  },

                  child: Container(
                    height: 60.0,
                    margin: EdgeInsets.only(left: 24.0,right: 24.0,top: 12.0,bottom: 6.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        gradient: LinearGradient(colors: [
                          Color.fromRGBO(50, 145, 248, 0.9),
                          Color.fromRGBO(30, 61, 168, 1.0)
                        ])),

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
                ),


              ],
            ),
          ),

          Positioned (

            right: 24.0,
            left: 24.0,
            top: MediaQuery.of(context).size.height / 2 - 215.0 + 384.0 + 50.0,
            child: Column(
              children: <Widget>[

                InkWell(
                  onTap: (){
                    print('Navigate to SigninPage now!');
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignInPage()));
                  },

                    child: RichText(
                      text: TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: "Already have an account? ",
                            style: TextStyle(
                                color: Colors.grey, fontSize: 14.0)),


                        TextSpan(
                            text: "Sign In",
                            style: TextStyle(
                                color: Colors.blueGrey, fontSize: 14.0))
                      ]),
                    ),



                ),


              ],
            ),
          )
        ],
      ),
    );
  }
}