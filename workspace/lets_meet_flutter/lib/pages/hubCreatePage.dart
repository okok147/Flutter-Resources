import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lets_meet_flutter/main.dart';
import 'package:lets_meet_flutter/pages/loginPage_new.dart';
import 'package:lets_meet_flutter/util/Flutter_1101.dart';
import 'package:lets_meet_flutter/util/GIcons.dart';
import 'package:lets_meet_flutter/util/Global.dart';
import 'package:lets_meet_flutter/util/flutter_0824_icons.dart';
import 'package:lets_meet_flutter/util/flutter_0917_icons.dart';
import 'package:lets_meet_flutter/util/g_c_icon_icons.dart';
import 'package:lets_meet_flutter/util/my_flutter_app_icons.dart';
import 'package:lets_meet_flutter/widget.dart';

class HubCreatePage extends StatefulWidget {
  final int host_id;
  const HubCreatePage({
    Key key,
    this.host_id,
  }) : super(key: key);
  @override
  _HubCreatePageState createState() => _HubCreatePageState();
}

class _HubCreatePageState extends State<HubCreatePage> {
  final _formKey = GlobalKey<FormState>();
  CreateForm createForm;
  List<dynamic> image_list = [];
  List<dynamic> logo_list = [];
  bool isLoading = false;

  Future uploadPhoto(int id, List<dynamic> image_list) async {
    FormData formdata = new FormData.from({
      // "icon": new UploadFileInfo(image, "icon.jpg"),
      "ID": id
    });
    for (int i = 0; i < image_list.length; i++) {
      formdata.add("icon_$i", new UploadFileInfo(image_list[i], "icon_$i.jpg"));
    }
    formdata.add("length", image_list.length);
    var response = await Request.uploadFile()
        .post("user/hub/upload/image", data: formdata);
    if (response.data["Code"] == 200) {
      if (this.mounted) {
        setState(() {});
      }
    }
  }

  Future uploadLogo(int id, List<dynamic> image_list) async {
    FormData formdata = new FormData.from({
      // "icon": new UploadFileInfo(image, "icon.jpg"),
      "ID": id
    });
    for (int i = 0; i < image_list.length; i++) {
      formdata.add("icon_$i", new UploadFileInfo(image_list[i], "icon_$i.jpg"));
    }
    formdata.add("length", image_list.length);
    var response = await Request.uploadFile()
        .post("user/hub/upload/logo", data: formdata);
    if (response.data["Code"] == 200) {
      if (this.mounted) {
        setState(() {});
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createForm = new CreateForm();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ADD A NEW HUB",
          style: TextStyle(
              fontFamily: "HelveticaNeue", color: Colors.black, fontSize: 17.0),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: IconButton(
              icon: Icon(
                Icons.keyboard_arrow_left,
                color: Colors.black,
                size: 40.0,
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    child: AlertDialog(
                      contentPadding: const EdgeInsets.all(16.0),
                      content: new Row(
                        children: <Widget>[Text("Do you want to discard?")],
                      ),
                      actions: <Widget>[
                        new FlatButton(
                            child: const Text('CANCEL'),
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                        new FlatButton(
                            child: const Text('OK'),
                            onPressed: () async {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            })
                      ],
                    ),
                  );
              },
            )),
      ),
      body: isLoading == true? Center( child: CircularProgressIndicator(),): Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(left: 24.0, right: 24.0),
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  createForm.create_input(
                      title: "Name",
                      hint_text: "Name of Hub",
                      icon: Flutter_0824_icons.group,
                      isCompulsory: true,
                      tag: "Name"),
                  createForm.create_google_picker(
                      title: "Location of Hub",
                      hint_text: "Address",
                      icon: GIcons.location,
                      isCompulsory: true,
                      tag: "Location"),
                  createForm.create_input(
                      title: "Days + Hours",
                      hint_text: "Examples",
                      isCompulsory: true,
                      icon: MyFlutterApp.add____2,
                      tag: "Open_hour"),
                  createForm.create_input(
                      title: "Contact Number",
                      hint_text: "Phone Number",
                      isCompulsory: true,
                      icon: GIcons.phone,
                      tag: "Phone"),
                  createForm.create_input(
                      title: "Contact Person",
                      hint_text: "Name of Contact Person",
                      icon: GIcons.profile,
                      isCompulsory: true,
                      tag: "Contact_Person"),
                  createForm.create_input(
                      title: "Charges",
                      hint_text: "Any charges of freewill donation accepted",
                      icon: MyFlutterApp.add____1,
                      isCompulsory: true,
                      tag: "Price"),
                  createForm.create_input(
                      title: "Description of Hub",
                      hint_text: "Description of Facilities",
                      icon: Flutter_0824_icons.doc,
                      isCompulsory: true,
                      tag: "Description"),
                  createForm.create_input(
                      title: "Number Of Seats",
                      hint_text: "Number of Seats Available",
                      isCompulsory: true,
                      icon: Flutter_1101.add____7,
                      tag: "Number_Of_Seats",
                      textInputType: TextInputType.number),
                  createForm.create_upload(
                    title: "Upload Photos (max.4)",
                    icon: GIcons.add,
                    tag: "Photo",
                  ),
                  createForm.create_upload(
                      title: "Upload Logo",
                      icon: GIcons.add,
                      tag: "Logo",
                      max_number: 1),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 48.9),
                    child: Center(
                      child: FullWidthButton(
                        "ADD",
                        color: Colors.grey,
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              isLoading = true;    
                            });
                            if (createForm.DATA["Photo"] != null) {
                              // image = createForm.DATA["Photo"];
                              image_list = createForm.DATA["Photo"];
                              createForm.DATA.remove("Photo");
                            }
                            if (createForm.DATA["Logo"] != null) {
                              // image = createForm.DATA["Photo"];
                              logo_list = createForm.DATA["Logo"];
                              createForm.DATA.remove("Logo");
                            }
                            createForm.DATA["Host_ID"] = widget.host_id;
                            var response = await Request.getDio().post(
                                "hub/create",
                                data: {"hub": createForm.DATA});
                            if (image_list.length != 0) {
                              await uploadPhoto(
                                  response.data["Data"]["ID"], image_list);
                            }
                            if (logo_list.length != 0) {
                              await uploadLogo(
                                  response.data["Data"]["ID"], logo_list);
                            }
                            setState(() {
                              isLoading = false;    
                            });
                            Navigator.pop(context);
                          }
                        },
                      ),
                      // RaisedButton(
                      //   onPressed: () async {
                      //     if (_formKey.currentState.validate()) {
                      //       setState(() {
                      //         isLoading = true;    
                      //       });
                      //       if (createForm.DATA["Photo"] != null) {
                      //         // image = createForm.DATA["Photo"];
                      //         image_list = createForm.DATA["Photo"];
                      //         createForm.DATA.remove("Photo");
                      //       }
                      //       if (createForm.DATA["Logo"] != null) {
                      //         // image = createForm.DATA["Photo"];
                      //         logo_list = createForm.DATA["Logo"];
                      //         createForm.DATA.remove("Logo");
                      //       }
                      //       createForm.DATA["Host_ID"] = widget.host_id;
                      //       var response = await Request.getDio().post(
                      //           "hub/create",
                      //           data: {"hub": createForm.DATA});
                      //       if (image_list.length != 0) {
                      //         await uploadPhoto(
                      //             response.data["Data"]["ID"], image_list);
                      //       }
                      //       if (logo_list.length != 0) {
                      //         await uploadLogo(
                      //             response.data["Data"]["ID"], logo_list);
                      //       }
                      //       setState(() {
                      //         isLoading = false;    
                      //       });
                      //       Navigator.pop(context);
                      //     }
                      //   },
                        // child: 
                        // Container(
                        //     height: 40.0,
                        //     width: 160.0,
                        //     child: Center(
                        //         child: Text(
                        //       "Add",
                        //       style: TextStyle(
                        //           color: Colors.white, fontSize: 14.0),
                        //     )
                        //     )
                        //     ),
                        // color: Color(0xff525fcb),
                      // ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
