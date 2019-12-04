import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lets_meet_flutter/main.dart';
import 'package:lets_meet_flutter/util/Global.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validate/validate.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State < RegisterPage > {
  final GlobalKey < FormState > formKey = new GlobalKey < FormState > ();
  _RegisterData _data = new _RegisterData();
  Map < String,
  String > form = new Map < String,
  String > ();
  File _image;
  bool isLoading = false;


  Future submit() async { // Save our form now.
    setState(() {
          isLoading = true;
        });
    var response = await Request.getDio().post("register", data: {
      "Email": form["email"],
      "Password": form["password"],
      "Name": form["first_name"] + form["last_name"],
      "First_Name": form["first_name"],
      "Last_Name": form["last_name"],
    });
    if (response.data['Code'] == 200) {
      Global.Token = response.data['Data']['Token'];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('Token', response.data['Data']['Token']);
      await getUser();
      await uploadPhoto();
          setState(() {
          isLoading = false;
        });
      Global.router.navigateTo(context, "/Home", transition: TransitionType.fadeIn, replace: true);
    } else {
          setState(() {
          isLoading = true;
        });
      showDialog(
        context: context,
        builder: (BuildContext) {
          return AlertDialog(
            content: Text("Failed to register"),
          );
        });
    }
  }

  Future uploadPhoto() async {
    FormData formdata = new FormData.from({
      "icon": new UploadFileInfo(_image, "icon.jpg"),
      "ID": Global.ac.id
    });
    // formdata.add("photo", new UploadFileInfo(_image, 'photo.jpg'));
    if(_image != null)
      var response = await Request.uploadFile().post("me/upload/image", data:formdata);
  }

  

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    _image = image;
    if (_image != null) {
      if(this.mounted){
        setState(() {});
      }      
    }

    // uploadPhoto();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: isLoading == false ? Stack(
        children: < Widget > [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset("images/login_background.jpg", fit: BoxFit.cover, ),
          ),
          Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  // alignment: Alignment.bottomCenter,
                  child: SingleChildScrollView(
                    child: Column(
                      // controller: _scrollController,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: < Widget > [
                        SafeArea(child: Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                            child: Text("CREATE ACCOUNT", style: Global.stlye_title, ),
                        )),
                        Column(
                          children: < Widget > [
                            Column(
                              children: < Widget > [
                                Padding(
                                  padding: const EdgeInsets.only(top: 51.0, bottom: 80.7),
                                    child: Center(
                                      child: FlatButton(
                                        shape: CircleBorder(),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Color(0xFFF8F7F7).withOpacity(.27),
                                            borderRadius: BorderRadius.circular(90.0),
                                            image: _image != null ? new DecorationImage(fit: BoxFit.fill,image: new AssetImage(_image.path)):null
                                            
                                          ),
                                          // color: Colors.red,
                                          
                                          width: 139.0,
                                          height: 139.0,
                                          child:
                                          _image != null ? null :
                                          Center(child: Text('my photo', style: TextStyle(color: Colors.white), )),
                                        ), onPressed: getImage
                                      ),
                                    ),
                                ),
                              ],
                            ),
                            Column(
                              children: < Widget > [
                                Container(
                                  height: 37.4,
                                  margin: const EdgeInsets.only(bottom: 20.5),
                                    child: UglyText(src: form, tag: "first_name", hint: 'first name', )
                                ),
                                Container(
                                  height: 37.4,
                                  margin: const EdgeInsets.only(bottom: 20.5),
                                    child: UglyText(src: form, tag: "last_name", hint: 'last name', )
                                ),
                                Container(
                                  height: 37.4,
                                  margin: const EdgeInsets.only(bottom: 20.5),
                                    child: UglyText(src: form, tag: "email", hint: 'my email',  )
                                ),
                                Container(
                                  height: 37.4,
                                  margin: const EdgeInsets.only(bottom: 140.0),
                                    child: UglyText(src: form, tag: "password", hint: 'my password', obscureText: true, )
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 72.0),
                                  child: FullWidthButton('create account', onPressed: submit, ),
                                ),
                              ],
                            ),
                          ]
                        ),

                      ],
                    ),
                  ),
                ),
            ),
          ),
        ],
      ): Center( child: CircularProgressIndicator(),)
    );
  }
}

class FullWidthButton extends StatelessWidget {

  final VoidCallback onPressed;
  final Color color;
  final String text;
  final Color fontColor;

  const FullWidthButton(this.text, {
    Key key,
    @required this.onPressed,
    this.color,
    this.fontColor
  }): super(key: key);


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final Size screenSize = MediaQuery.of(context).size;
    return new Container(
      height: 37.4,
      decoration:
      new ShapeDecoration(
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.all(Radius.circular(14.0))
        )
      ),
      width: screenSize.width,
      child: new FlatButton(
        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(14.0)),
        child: new Text(
          // 'sign in with Facebook',
          text,
          style: new TextStyle(
            color: (fontColor == null) ? Colors.white : fontColor,
            fontFamily: "HelveticaNeue",
            fontSize: 16.0,
            height: 0.8
          ),
        ),
        onPressed: onPressed,
        //color: Color(0xff383DC8)
        color: (color != null) ? color : Colors.white.withOpacity(0.5)
      ),
      margin: new EdgeInsets.only(
        top: 20.0,
        bottom: 4.0
      ),
    );
  }
}

class UglyText extends StatefulWidget {

  final String tag;
  final Map < String, String > src;
  final FormFieldValidator < String > validator;
  final String hint;
  final bool obscureText;
  final VoidCallback cb;


  UglyText({
    Key key,
    this.tag,
    this.validator,
    this.hint,
    this.src,
    this.obscureText: false,
    this.cb
  }): super(key: key);
  @override
  State < StatefulWidget > createState() => _UglyText();


}
class _UglyText extends State < UglyText > {

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
    fNode = new FocusNode();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var hint = fNode.hasFocus ? "" : this.widget.hint;
    return DecoratedBox(
      decoration: BoxDecoration(border: Border.all(width: 2.0, color: Colors.white), borderRadius: BorderRadius.circular(14.0)),
      child: new TextField(
        autocorrect: false,
        style: Global.style_input,
        focusNode: fNode,
        keyboardType: TextInputType.emailAddress, // Use email input type for emails.
        obscureText: this.widget.obscureText,
        textAlign: TextAlign.center,
        decoration: new InputDecoration(
          border: InputBorder.none,
          hintStyle: Global.style_input,
          hintText: hint,
        ),
        onChanged: (s) {
          this.widget.src[this.widget.tag] = s;
        },
        // onSaved: (String value) {
        //   print(value);
        //   this.widget.src[this.widget.tag] = value;
        // }
        // validator: (value) {
        //   if (value.isEmpty) {
        //     return 'Please enter some text';
        //   }
        // },
      ),
    );
  }
}

class _RegisterData {
  String email = '';
  String password = '';
  String first_name = "";
  String last_name = "";
}