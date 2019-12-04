// import 'dart:async';
// import 'dart:io';

// import 'package:fluro/fluro.dart';
// import 'package:flutter/material.dart';
// import 'package:lets_meet_flutter/main.dart';
// import 'package:lets_meet_flutter/util/Global.dart';
// import 'package:sensors/sensors.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:validate/validate.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:image_cropper/image_cropper.dart';


// class LoginPage extends StatefulWidget {
//   @override
//   State < StatefulWidget > createState() {
//     loginState = _LoginPage();
//     return loginState;
//   }
// }
// List < double > _gyroscopeValues;
// StreamSubscription < dynamic > streamSubscriptions;


// GlobalKey < _MoveBG > bgImage = new GlobalKey();
// GlobalKey < _LoginPage > k_LoginPagelash = new GlobalKey();

// _LoginPage loginState;

// PageController _pageController;

// class _LoginData {
//   String email = '';
//   String password = '';
//   String first_name = "";
//   String last_name = "";
// }
// final GlobalKey < ScaffoldState > _scaffoldKey = new GlobalKey < ScaffoldState > ();
// final emailKey = new GlobalKey();

// // void _listener() {  
// //   if (_myNode.hasFocus || _myNode2.hasFocus) {
// //     // keyboard appeared 
// //     //Scrollable.ensureVisible(emailKey.currentContext);
// //     Timer(const Duration(milliseconds: 300), () {
// //       _scrollController.animateTo(200.0, curve: Curves.easeInOut, duration: Duration(milliseconds: 300));
// //     });
// //     print('ok');
// //   } else {
// //     print('hide');
// //     // keyboard dismissed
// //   }
// // }
// // FocusNode _myNode = new FocusNode()..addListener(_listener);
// // FocusNode _myNode2 = new FocusNode()..addListener(_listener);
// class LoginForm extends StatefulWidget {

//   @override
//   State < StatefulWidget > createState() => _LoginFrom();
// }
// class _LoginFrom extends State < LoginForm > {

//   final GlobalKey < FormState > _formKey = new GlobalKey < FormState > ();
//   _LoginData _data = new _LoginData();
//   Map < String,String > _form = new Map < String,String > ();
//   String _validateEmail(String value) {

//     // If empty value, the isEmail function throw a error.
//     // So I changed this function with try and catch.
//     try {
//       Validate.isEmail(value);
//       _data.email = value;
//     } catch (e) {
//       return 'The E-mail Address must be a valid email address.';
//     }

//     return null;
//   }

//   String _validatePassword(String value) {
//     if (value.length < 8) {
//       return 'The Password must be at least 8 characters.';
//     }
//     _data.password = value;

//     return null;
//   }

//   Future submit() async {
//     // First validate form.
//     print(_form);
//     if (this._formKey.currentState.validate()) {
//       _formKey.currentState.save(); // Save our form now.
//       var response = await Request.getDio().post("login", data: {
//         "Email": _form["email"],
//         "Password": _form["password"]
//       });
//       if (response.data['Code'] == 200) {
//         Global.router.navigateTo(context, "/", transition: TransitionType.fadeIn);
//         Token = response.data['Data']['Token'];
//         SharedPreferences prefs = await SharedPreferences.getInstance();
//         prefs.setString('Token', response.data['Data']['Token']);
//       } else {
//         showDialog(
//           context: context,
//           builder: (BuildContext) {
//             return AlertDialog(
//               // content: Text("額外資料: ${widget.val['LeaveMSG'].toString()}"),
//               content: Text("Please Enter Correct Email And Password"),
//               // content: Text(true?"true":"false"),
//             );
//           });
//       }
//     }
//   }
//   // ScrollController _scrollController = new ScrollController();
//   // void scrollIt() {
//   //   _scrollController.animateTo(250.0, curve: Curves.easeInOut, duration: Duration(milliseconds: 300));
//   // }
//   @override
//   Widget build(BuildContext context) {
//     final Size screenSize = MediaQuery.of(context).size;
//     final tmp = new Scaffold(
//       body: new Form(
//         key: this._formKey,
//         child: Theme(
//           data: ThemeData(platform: TargetPlatform.iOS),
//           child: Container(
//             height: MediaQuery.of(context).size.height,
//             width: MediaQuery.of(context).size.width,
//             child: ListView(
//               // controller: _scrollController,
//               children: < Widget > [
//                 Container(
//                   height: 37.4,
//                   margin: const EdgeInsets.only(bottom: 20.5),
//                     child: UglyText(src: _form, tag: "email", hint: 'email', validator: this._validateEmail,
//                     //  cb: scrollIt
//                     )
//                 ),
//                 Container(
//                   height: 37.4,
//                   child: UglyText(src: _form, tag: "password", hint: 'password', validator: this._validatePassword, obscureText: true, 
//                   // cb: scrollIt
//                   )),
//                 FullWidthButton("log in", onPressed: () {
//                   submit();
//                 }, ),
//                 Container(
//                   margin: new EdgeInsets.only(
//                     bottom: 27.0
//                   ),
//                   child: Center(
//                     child: InkWell( child: Text("forget password", style: TextStyle(color: Colors.white, fontSize: 12.0, fontFamily: "HelveticaNeue"))))),
//                 Container(
//                   margin: new EdgeInsets.only(
//                     bottom: 35.8
//                   ),
//                   child: Center(child: Text("OR", style: TextStyle(color: Colors.white, fontSize: 14.0, fontFamily: "HelveticaNeue")))),
//                 FullWidthButton('sign in with Facebook', onPressed: () {}, color: Color(0xff383DC8), ),
//                 FullWidthButton('sign in with Google', onPressed: () {}, color: Colors.white, fontColor: Color(0xFF474747), ),
//                 FullWidthButton('sign in with email', onPressed: () {
//                   loginState.ani.get('login').reverse();
//                   loginState.title = "CREATE ACCOUNT";
//                   _scaffoldKey.currentState.showBottomSheet < Null > ((BuildContext context) {
//                     return Container(color: Colors.transparent, child: RegisterView());
//                   }).closed.whenComplete(() {
//                     loginState.ani.get('login').forward();
//                     loginState.title = "LOG IN";
//                   });
//                 })
//               ],
//             ),
//           ),
//         ),
//       )
//     );

//     return Padding(
//       padding: const EdgeInsets.only(bottom: 70.0),
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//             child: new Container(
//               width: MediaQuery.of(context).size.width,
//               height: screenSize.height,
//               child: new Container(
//                 width: 375.0,
//                 height: 812.0,
//                 alignment: Alignment.bottomCenter,
//                 child: Transform(
//                   transform: Matrix4.translationValues(0.0, (1 - loginState.ani.get('login').value) * 30, 0.0),
//                   child: tmp),
//               )
//             ),
//         ),
//     );
//   }
// }


// class _LoginPage extends State < LoginPage > with TickerProviderStateMixin {



//   Widget currentView;
//   // double logoFade = 0.0;
//   // double loginFade = 0.0;

//   // bool logoVisible = true;
//   // bool loginVisible = false;

//   AniNum ani;

//   String title = "";
//   // Timer _timer;

//   // final Widget splash = Image.asset('images/logo.png');



//   List < Widget > getLayout() {
//     final Size screenSize = MediaQuery.of(context).size;
//     var a = new List < Widget > ();

//     // if (ani.get("logo").value > 0) {
//     //   a.add(Opacity(opacity: ani.get("logo").value, child: Center(child: splash)));
//     // }

//     if (ani.get("login").value > 0) {
//       a.add(Opacity(
//         opacity: ani.get("login").value,
//         child: Center(child: Container(
//           alignment: Alignment.center,
//           child: LoginForm()
//         )),
//       ));
//     }
//     return a;

//   }
//   _LoginPage() {

//     // Timer(const Duration(milliseconds: 500), () {
//     //   ani.get("logo").forward();
//     //   // setState(() {
//     //   //   logoFade = 1.0;
//     //   // });
//     // });


//     // Timer(const Duration(milliseconds: 2000), () {
//     //   ani.get("logo").reverse();
//     //   // ani.get("login").forward();
//     //   // setState(() {
//     //   //   logoFade = 0.0;
//     //   //   loginVisible = true;
//     //   // });
//     // });

//     // Timer(const Duration(milliseconds: 3000), () {
//     //   // ani.get("logo").reverse();
//     //   loginState.title = "LOG IN";
//       ani.get("login").forward();

//     //   // setState(() {
//     //   //   logoVisible = false;
//     //   //   loginFade = 1.0;
//     //   // });

//     // });

//   }



//   @override
//   void initState() {
//     // TODO: implement initState

//     ani = new AniNum(this);
//     // ani.add("logo");
//     ani.add("login");
//     // currentView = splash;
//     _pageController = new PageController();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     //streamSubscriptions.cancel();
//     //_timer.cancel();
//     _pageController.dispose();
//     super.dispose();
//   }


//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: ThemeData(canvasColor: Colors.transparent),
//       child: Scaffold(
//         resizeToAvoidBottomPadding: false,
//         body: Stack(
//           children: < Widget > [
//             MoveBG(key: bgImage),
//             SizedBox(
//               child: Container(color: Colors.black.withOpacity(0.3)),

//             ),
//             Scaffold(
//               key: _scaffoldKey,
//               resizeToAvoidBottomPadding: false,
//               backgroundColor: Colors.transparent,

//               appBar: AppBar(
//                 centerTitle: true,
//                 backgroundColor: Colors.transparent,
//                 title: Text(title, style: TextStyle(fontFamily: "HelveticaNeue", fontSize: 16.0), ),
//                 elevation: 0.0,

//               ),
//               body: Stack(
//                 children: getLayout()
//               )
//             )
//           ],
//         ),
//       ),
//     );
//   }


// }



// class ForgotPasswordView extends StatefulWidget {
//   @override
//   State < StatefulWidget > createState() => _ForgotPasswordView();


// }
// class _ForgotPasswordView extends State < ForgotPasswordView > {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       // appBar: AppBar(title: Text('CREATE ACCOUNT'), centerTitle: true, ),
//     );
//   }
// }


// class RegisterView extends StatefulWidget {
//   @override
//   State < StatefulWidget > createState() => _ResgisterView();


// }
// class _ResgisterView extends State < RegisterView > {
//   final GlobalKey < FormState > _formKey = new GlobalKey < FormState > ();
//   _LoginData _data = new _LoginData();
//   Map < String,
//   String > _form = new Map < String,
//   String > ();






//   String _validateEmail(String value) {
//     // If empty value, the isEmail function throw a error.
//     // So I changed this function with try and catch.]
//     print(value);
//     try {
//       Validate.isEmail(value);
//     } catch (e) {
//       return 'The E-mail Address must be a valid email address.';
//     }

//     return null;
//   }




//   String _validatePassword(String value) {
//     if (value.length < 8) {
//       return 'The Password must be at least 8 characters.';
//     }

//     return null;
//   }

//   void submit() {
//     // First validate form.
//     if (this._formKey.currentState.validate()) {
//       _formKey.currentState.save(); // Save our form now.

//       print('Printing the login data.');
//       print('Email: ${_data.email}');
//       print('Password: ${_data.password}');
//     }
//   }

//   Future getImage() async {

//     var image = await ImagePicker.pickImage(source: ImageSource.gallery);
//     if (this.mounted) {
//       setState(() {
//         if (image != null)
//           _cropImage(image);
//         //_image = image;
//       });
//     }
//   }

//   // getImage() async {
//   //   /*setState(() {
//   //     imageFile = null;
//   //     _platformVersion = 'Unknown';
//   //   });*/    
//   //   String result;

//   //   try {
//   //     result = await FlutterImagePickCrop.pickAndCropImage('fromGalleryCropImage');
//   //   }  catch (e) {
//   //     result = e.message;
//   //     print(e.message);
//   //   }

//   //   if (!mounted) return;

//   //   setState(() {
//   //     _image = new File(result);
//   //     // _platformMessage = result;
//   //   });
//   // }

//   Future < Null > _cropImage(File imageFile) async {

//     _image = await ImageCropper.cropImage(
//       sourcePath: imageFile.path,
//       ratioX: 1.0,
//       ratioY: 1.0,
//       maxWidth: 512,
//       maxHeight: 512,
//     );
//     if (this.mounted) {
//       setState(() {

//       });
//     }
//   }


//   File _image;
//   ScrollController _scrollController = new ScrollController();
//   // void scrollIt() {
//   //   _scrollController.animateTo(250.0, curve: Curves.easeInOut, duration: Duration(milliseconds: 300));
//   // }
//   @override
//   Widget build(BuildContext context) {
//     final Size screenSize = MediaQuery.of(context).size;
//     final tmp = new Scaffold(
//       // height: screenSize.height,
//       // padding: new EdgeInsets.all(20.0),
//       body: new Form(
//         key: this._formKey,
//         child: Theme(
//           data: ThemeData(platform: TargetPlatform.fuchsia),
//           child: Padding(
//             padding: const EdgeInsets.only(left: 8.0, right: 8.0),
//             child: new Column(
//               // controller: _scrollController,
//               children: < Widget > [
//                 Center(
//                   child: FlatButton(
//                     shape: CircleBorder(),
//                     child: Container(
//                       decoration: BoxDecoration(color: Color(0xFFF8F7F7).withOpacity(.27), borderRadius: BorderRadius.circular(90.0)),
//                       // color: Colors.red,
//                       width: 139.0,
//                       height: 139.0,
//                       child: _image != null ? new Image.file(_image, fit: BoxFit.cover, ) : Center(child: Text('my photo', style: TextStyle(color: Colors.white), )),

//                     ), onPressed: () {
//                       getImage();
//                     },
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 20.5),
//                     child: Container(height: 37.4, child: UglyText(src: _form, tag: "first_name", hint: 'first name', validator: this._validateEmail, 
//                     // cb: scrollIt
//                     ))
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 20.5),
//                     child: Container(height: 37.4, child: UglyText(src: _form, tag: "last_name", hint: 'last name', validator: this._validateEmail, 
//                     // cb: scrollIt
//                     ))
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 20.5),
//                     child: Container(height: 37.4, child: UglyText(src: _form, tag: "my_email", hint: 'my email', validator: this._validateEmail, 
//                     // cb: scrollIt
//                     ))
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 139.6),
//                     child: Container(height: 37.4, child: UglyText(src: _form, tag: "my_password", hint: 'my password', obscureText: true, validator: this._validatePassword, 
//                     // cb: scrollIt
//                     ))
//                 ),
//                 FullWidthButton('create account', onPressed: () async {
//                   String name = _form["first_name"] + " " + _form["last_name"];
//                   var response = await Request.getDio().post("register", data: {
//                     "Password": _form["my_password"],
//                     "Email": _form["my_email"],
//                     "Name": name
//                   });
//                   SharedPreferences prefs = await SharedPreferences.getInstance();
//                   prefs.setString('Token', response.data['Data']['Token']);
//                   Global.Token = response.data['Data']['Token'];
//                   var profile = await Request.getDio().get("me/get");
//                   Global.ac.fromJSON(profile.data["Data"]);
//                   Global.router.navigateTo(context, "/Home", transition: TransitionType.native);
//                 })
//               ],
//             ),
//           ),
//         ),
//       )
//     );
//     return new Container(
//       width: MediaQuery.of(context).size.width,
//       height: MediaQuery.of(context).size.height,
//       alignment: Alignment.bottomCenter,
//       child: new Container(
//         width: 375.0,
//         height: 812.0,
//         alignment: Alignment.bottomCenter,
//         child: tmp
//       )
//     );

//   }
// }

// class FullWidthButton extends StatelessWidget {

//   final VoidCallback onPressed;
//   final Color color;
//   final String text;
//   final Color fontColor;

//   const FullWidthButton(this.text, {
//     Key key,
//     @required this.onPressed,
//     this.color,
//     this.fontColor
//   }): super(key: key);


//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     final Size screenSize = MediaQuery.of(context).size;
//     return new Container(
//       height: 37.4,
//       decoration:
//       new ShapeDecoration(
//         shape: new RoundedRectangleBorder(
//           borderRadius: new BorderRadius.all(Radius.circular(14.0))
//         )
//       ),
//       width: screenSize.width,
//       child: new FlatButton(
//         shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(14.0)),
//         child: new Text(
//           // 'sign in with Facebook',
//           text,
//           style: new TextStyle(
//             color: (fontColor == null) ? Colors.white : fontColor,
//             fontFamily: "HelveticaNeue",
//             fontSize: 16.0,
//             height: 0.8
//           ),
//         ),
//         onPressed: onPressed,
//         //color: Color(0xff383DC8)
//         color: (color != null) ? color : Colors.white.withOpacity(0.5)
//       ),
//       margin: new EdgeInsets.only(
//         top: 20.0,
//         bottom: 4.0
//       ),
//     );
//   }
// }

// class _MoveBG extends State < MoveBG > {
//   Matrix4 bgT;
//   void Move(x, y) {
//     bgT = bgT = Matrix4.identity()..scale(1.5)..translate(x, y);
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     bgT = Matrix4.identity();
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Transform(
//       alignment: FractionalOffset.center,
//       transform: bgT,
//       child: Container(
//         color: Colors.black,
//         child: SizedBox.expand(child: Image.asset("images/login_background.jpg", fit: BoxFit.cover, )))
//     );
//   }
// }

// class MoveBG extends StatefulWidget {
//   const MoveBG({
//     Key key
//   }): super(key: key);
//   @override
//   State < StatefulWidget > createState() => _MoveBG();

// }


// class _FocusFormText extends State < FocusFormText > {

//   void _ensureVisible() {
//     Scrollable.ensureVisible(context);
//   }
//   @override
//   void initState() {
//     widget.focusNode.addListener(_ensureVisible);
//     super.initState();
//   }
//   @override
//   void dispose() {
//     widget.focusNode.removeListener(_ensureVisible);
//     super.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return widget.child;
//   }


// }
// class FocusFormText extends StatefulWidget {
//   final FocusNode focusNode;

//   /// The child widget that we are wrapping
//   final Widget child;
//   const FocusFormText({
//     Key key,
//     @required this.child,
//     @required this.focusNode,
//   }): super(key: key);
//   @override
//   State < StatefulWidget > createState() => _FocusFormText();


// }
// class UglyText extends StatefulWidget {

//   final String tag;
//   final Map < String, String > src;
//   final FormFieldValidator < String > validator;  
//   final String hint;
//   final bool obscureText;
//   final VoidCallback cb;


//   UglyText({
//     Key key,
//     this.tag,
//     this.validator,
//     this.hint,
//     this.src,
//     this.obscureText: false,
//     this.cb
//   }): super(key: key);
//   @override
//   State < StatefulWidget > createState() => _UglyText();


// }
// class _UglyText extends State < UglyText > {
//   Timer timer;
//   // void tListener() {
//   //   if (fNode.hasFocus) {

//   //     timer = Timer(const Duration(milliseconds: 300), () {
//   //       this.widget.cb();
//   //     });
//   //   } else {

//   //   }
//   // }

//   FocusNode fNode;
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     // fNode.removeListener(tListener);
//     if (timer != null) {
//       timer.cancel();
//     }
//     fNode.dispose();
//     super.dispose();
//   }
//   @override
//   void initState() {
//     fNode = new FocusNode();
//     // fNode.addListener((){
//     //    if (fNode.hasFocus){
//     //       fNode
//     //    }
//     // });
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     var hint = fNode.hasFocus?"":this.widget.hint;
//     return DecoratedBox(
//       decoration: BoxDecoration(border: Border.all(width: 2.0, color: Colors.white), borderRadius: BorderRadius.circular(14.0)),
//       child: new TextField(
//         style: Global.style_input,
//         focusNode: fNode,
//         // key: emailKey,
//         keyboardType: TextInputType.emailAddress, // Use email input type for emails.
//         obscureText: this.widget.obscureText,
//         textAlign: TextAlign.center,
//         decoration: new InputDecoration(
//           border: InputBorder.none,
//           hintStyle: Global.style_input,
//           hintText: hint,          
//         ),
//         // validator: this.widget.validator,
//         onChanged: (s) {
//           this.widget.src[this.widget.tag] = s;
          
//         },

//         // onSaved: (String value) {
//         //   print(value);
//         //   this.widget.src[this.widget.tag] = value;
//         // }
//       ),
//     );
//   }
// }