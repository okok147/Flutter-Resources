import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lets_meet_flutter/main.dart';
import 'package:lets_meet_flutter/pages/loginPage_new.dart';
import 'package:lets_meet_flutter/util/Global.dart';
import 'package:lets_meet_flutter/widget.dart';

class ResetPasswordPage extends StatefulWidget {
  final String activationKey;

  const ResetPasswordPage({Key key, this.activationKey}) : super(key: key);
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  String new_password;
  String confirm_password;

  bool check_same_password() {
    if (new_password == confirm_password && new_password != null) return true;
    showDialog(
        context: context,
        child: AlertDialog(
          content: Text("New Password and Confirm Password should be same"),
        ));
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new PasswordTile(
                title: "New Password",
                onSaved: (text){
                  new_password = text;
                  print(new_password);
                },
              ),
              SizedBox(
                height: 48.0,
              ),
              new PasswordTile(
                title: "Confirm Password",
                onSaved: (text){
                  confirm_password = text;
                },
              ),
              SizedBox(
                height: 48.0,
              ),
              FullWidthButton(
                "Submit",
                onPressed: () async {
                  _formKey.currentState.save();
                  
                  if (_formKey.currentState.validate() &&
                      check_same_password()) {
                    var response = await Request.getDio()
                        .post("user/reset/password", data: {
                      "ActivationKey": widget.activationKey,
                      "Password": new_password
                    });
                    if (response.data["Code"] == 200) {
                      Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text('Password is changed successfully')));
                      new Timer(const Duration(milliseconds: 850), () {
                        Navigator.of(context).pop();
                      });
                    } else {
                      showDialog(
                          context: context,
                          child: AlertDialog(
                            content: Text("Unknown Error"),
                          ));
                    }
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PasswordTile extends StatelessWidget {
  final String title;
  
  ValueSetter<String> onSaved;
  
  PasswordTile({Key key, @required this.title, this.onSaved})
      : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(
              Icons.vpn_key,
              size: 24.0,
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  title,
                  softWrap: true,
                ),
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 32.0),
          child: TextFormField(
            autocorrect: false,
            onSaved:onSaved,
            obscureText: true,
            decoration: InputDecoration(
              hintText: "Enter your new password",
              hintStyle: Global.create_hint,
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'You must enter new password';
              }
              if (value.length < 6) {
                return 'Password should be more than 6 character';
              }
              
            },
          ),
        ),
      ],
    );
  }
}
