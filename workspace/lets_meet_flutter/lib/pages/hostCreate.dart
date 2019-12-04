import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html_view/flutter_html_view.dart';
import 'package:lets_meet_flutter/main.dart';
import 'package:lets_meet_flutter/pages/loginPage_new.dart';
import 'package:lets_meet_flutter/util/GIcons.dart';
import 'package:lets_meet_flutter/util/Global.dart';
import 'package:lets_meet_flutter/util/flutter_0824_icons.dart';
import 'package:lets_meet_flutter/util/g_c_icon_icons.dart';
import 'package:lets_meet_flutter/widget.dart';

class CreateHost extends StatefulWidget {
  final int edit_id;

  const CreateHost({Key key, this.edit_id}) : super(key: key);
  @override
  _CreateHostState createState() => _CreateHostState();
}

class _CreateHostState extends State<CreateHost> {
  final _formKey = GlobalKey<FormState>();
  CreateForm createForm;
  List<dynamic> image_list = [];
  bool isLoading = false;
  String html = "Loading...";
  Map <String, dynamic> host = new Map<String, dynamic>();

  Future uploadPhoto(int id, List<dynamic> image_list) async {
    FormData formdata = new FormData.from({
      // "icon": new UploadFileInfo(image, "icon.jpg"),
      "ID": id
    });
    for (int i = 0; i < image_list.length; i++) {
      formdata.add("icon_$i", new UploadFileInfo(image_list[i], "icon_$i.jpg"));
    }
    formdata.add("length", image_list.length);
    var response =
        await Request.uploadFile().post("host/upload/image", data: formdata);
    if (response.data["Code"] == 200) {
      if (this.mounted) {
        setState(() {});
      }
    }
  }

  Future get_cms_apply_to_be_a_host() async {
    var response = await Request.getDio().get("others/get", data: {
      "ID": 6
    });
    if(response.data["Code"] == 200){
      if (this.mounted) {
        setState(() {
          html = response.data["Data"];
        });
      }
    }    
  }

   Future getHost() async {
    Response response = await Request.getDio().get("host/get", data: {"ID": widget.edit_id});
    if (this.mounted) {
      setState(() {
        host = response.data["Data"];
        host.forEach((key, value) => 
          createForm.DATA[key] = value
        );
        print(createForm.DATA);
      });
    }
  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_cms_apply_to_be_a_host();
    createForm = new CreateForm();
    if(widget.edit_id != null){
      getHost();
    }
  }

  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      appBar: AppBar(
        title: Text(
          widget.edit_id ==null ?"APPLY TO BE A HOST": "Edit Host",
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
      body: isLoading == true || (createForm.DATA.isEmpty == true && widget.edit_id !=null)
          ? Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        HtmlView(
                      data: html,
                    ),
                        createForm.create_input(
                            title: "Name of Organization/Church/Group",
                            hint_text: "Name of Organization/Church/Group",
                            icon: GCIcon.book,
                            isCompulsory: true,
                            tag: "Name"),
                        // createForm.create_input(
                        //     title: "Years Formed",
                        //     hint_text: "Examples",
                        //     icon: Icons.account_balance,
                        //     tag: "Year"),
                        createForm.create_input(
                            title: "Contact Person",
                            hint_text: "Name of Contact Person",
                            icon: GCIcon.profile,
                            isCompulsory: true,
                            tag: "Director"),
                        createForm.create_input(
                            title: "Contact Number",
                            hint_text: "Phone Number",
                            isCompulsory: true,
                            icon: GIcons.phone,
                            tag: "Phone_Number"),
                        createForm.create_upload(
                            icon: Icons.photo,
                            title: "Upload Photos",
                            tag: "Photo"),
                        createForm.create_google_picker(
                            title: "Location",
                            hint_text: "Address",
                            isCompulsory: true,
                            icon: GIcons.location,
                            tag: "Address"),
                        createForm.create_input(
                            title: "Website",
                            hint_text: "Website",
                            isCompulsory: true,
                            icon: GIcons.website,
                            tag: "Website"),
                        createForm.create_input(
                            title: "Email",
                            hint_text: "Email",
                            isCompulsory: true,
                            icon: GIcons.mail,
                            tag: "Email"),
                        // createForm.create_input(
                        //     title: "Approximate Number of Members",
                        //     hint_text: "Examples",
                        //     icon: Icons.group,
                        //     tag: "Number_Members"),
                        createForm.create_input(
                            title: "Activities / Services",
                            hint_text: "Activities / Services",
                            isCompulsory: true,
                            icon: Icons.directions_run,
                            tag: "Activities"),
                        createForm.create_textarea(
                            title: "Mission of Organization/Church/Group",
                            icon: Flutter_0824_icons.doc,
                            hint_text: "mission of organization/church/group",
                            isCompulsory: true,
                            tag: "Description"),
                        widget.edit_id == null?FullWidthButton(
                          "APPLY TO BE A HOST",
                          color: Colors.grey,
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              if (createForm.DATA["Photo"] != null) {
                                image_list = createForm.DATA["Photo"];
                                createForm.DATA.remove("Photo");
                              }
                              var response = await Request.getDio().post(
                                  "host/create",
                                  data: {"host": createForm.DATA});
                              await uploadPhoto(
                                  response.data["Data"]["ID"], image_list);
                              var profile =
                                  await Request.getDio().get("me/get");
                              Global.ac.fromJSON(profile.data["Data"]);
                              setState(() {
                                isLoading = false;
                              });
                              Navigator.pop(context);
                              // Navigator.pop(context);
                            }
                          },
                        ):FullWidthButton(
                          "EDIT HOST",
                          color: Colors.grey,
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              if (createForm.DATA["Photo"] != null) {
                                image_list = createForm.DATA["Photo"];
                                createForm.DATA.remove("Photo");
                              }
                              var response = await Request.getDio().patch(
                                  "host/edit",
                                  data: {"host": createForm.DATA, "host_ID": widget.edit_id});
                              await uploadPhoto(
                                  response.data["Data"]["ID"], image_list);
                              var profile =
                                  await Request.getDio().get("me/get");
                              Global.ac.fromJSON(profile.data["Data"]);
                              setState(() {
                                isLoading = false;
                              });
                              Navigator.pop(context);
                              // Navigator.pop(context);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
