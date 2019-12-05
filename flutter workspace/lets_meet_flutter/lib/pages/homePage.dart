import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter_html/flutter_html.dart';
import 'package:cirrus_map_view/map_view.dart';
import 'package:cirrus_map_view/marker.dart';
import 'package:cirrus_map_view/static_map_provider.dart';
import 'package:cirrus_map_view/toolbar_action.dart';
import 'package:lets_meet_flutter/pages/loginPage_new.dart';
import 'package:lets_meet_flutter/util/ColumnBuilder.dart';
import 'package:lets_meet_flutter/util/country.dart';
import 'package:lets_meet_flutter/util/flutter_0917_icons.dart';
import 'package:cirrus_map_view/map_view.dart';
import 'package:path/path.dart' as path;

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lets_meet_flutter/main.dart';
import 'package:lets_meet_flutter/pages/eventPage.dart';
import 'package:lets_meet_flutter/util/GIcons.dart';
import 'package:lets_meet_flutter/util/Global.dart';
import 'package:lets_meet_flutter/util/bzEngine.dart';
import 'package:lets_meet_flutter/util/countryPicker.dart';
import 'package:lets_meet_flutter/util/flutter_0824_icons.dart';
import 'package:lets_meet_flutter/util/g_c_icon_icons.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

// import 'package:google_places_picker/google_places_picker.dart';
// import 'package:flutter_places_dialog/flutter_places_dialog.dart';
import 'package:dio/dio.dart';
import 'package:lets_meet_flutter/widget.dart';
import 'package:share/share.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.listController}) : super(key: key);
  final PageController listController;

  void setPage(int n) {
    listController.jumpToPage(
      n,
    );
    // listController.jumpToPage(n-1);
  }

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();
  bool isHost = false;
  var search_result_data;

  Future updateFirebaseToken(fireBaseTOKEN) async {
    print("fireBaseTOKEN is ${fireBaseTOKEN}");
    var response = await Request.getDio().post("UpdateFirebaseToken", data: {
      "fireBaseTOKEN": fireBaseTOKEN,
    });
    return null;
  }

  @override
  void initState() {
    // TODO: implement initState
    //widget.listController.jumpToPage(1);
    print("init state");
    super.initState();
    _firebaseMessaging.configure(onMessage: (Map<String, dynamic> message) {
      print("onMessage: $message");
      if (Global.update_message != null) {
        print("running firebase!");
        Global.update_message();
      }
      if (Global.update_message_tile != null) {
        Global.update_message_tile();
      }
      if (Global.get_unread_number != null) {
        Global.get_unread_number();
      }
    }, onLaunch: (Map<String, dynamic> message) {
      print("onLaunch: $message");
    }, onResume: (Map<String, dynamic> message) {
      print("onResume: $message");
    });

    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
      // _firebaseMessaging.subscribeToTopic("allbus");
      print("subscribed");
    });
    _firebaseMessaging.getToken().then((String token) {
      print("Settings registered: $token");
      //_firebaseMessaging.subscribeToTopic("allbus");
      updateFirebaseToken(token);
    });

    getUser();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    widget.listController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(splashColor: Colors.white),
      child: PageView(
        scrollDirection: Axis.vertical,
        controller: widget.listController,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          HubCategoryPage(
            key: Global.hub_category,
          ),
          MeetListView_Search(
            data: search_result_data,
            title: "search for volunteer groups",
            index: 1,
            category_ID: 3,
            key: Global.kMeetListViewSearch_volunteer,
          ),
          MeetListView_Search(
            data: search_result_data,
            title: "search for meet groups",
            index: 2,
            category_ID: 1,
            key: Global.kMeetListViewSearch_meet,
          ),
          MeetListView_Search(
            data: search_result_data,
            title: "search for venues to book",
            index: 3,
            category_ID: 2,
            key: Global.kMeetListViewSearch_book,
          ),
          (Global.ac.isHost)
              ? HostProfile(
                  host_id: Global.selected_host_id,
                )
              : ProfilePage(),
        ],
      ),
    );
  }
}

class HostProfile extends StatefulWidget {
  int host_id;

  HostProfile({Key key, @required this.host_id}) : super(key: key);
  @override
  _HostProfileState createState() => _HostProfileState();
}

class _HostProfileState extends State<HostProfile> {
  bool isLoading = false;
  GlobalKey<MeetListViewState> keyMeetListView_hostAdmin =
      new GlobalKey<MeetListViewState>();
  bool isPressed = true;
  List<dynamic> users;
  List<dynamic> invite_users; //for the add other admin function
  void press() {
    if (this.mounted) {
      setState(() {
        isPressed = !isPressed;
        keyMeetListView_hostAdmin.currentState.widget.isCurrent =
            !keyMeetListView_hostAdmin.currentState.widget.isCurrent;
        keyMeetListView_hostAdmin.currentState.get_meetup_list();
      });
    }
  }

  Future getUsers() async {
    var response_users = await Request.getDio()
        .get("host/get/users", data: {"Host_ID": widget.host_id});
    users = response_users.data["Data"];
    if (this.mounted) {
      setState(() {
        isLoading = true;
      });
    }
  }

  Future getUsers_without_host() async {
    var response_users = await Request.getDio()
        .get("host/get/users_without_host", data: {"Host_ID": widget.host_id});
    invite_users = response_users.data["Data"];
    print(invite_users);
    if (this.mounted) {
      setState(() {});
    }
  }

  Future send_to_all(message) async {
    await Request.getDio().post("host/send/all",
        data: {"Host_ID": widget.host_id, "Conversation": message});
    if (this.mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return users == null
        ? Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            child: Container(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    top: 49.9,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: Text(
                          users == null ? "" : users.length.toString(),
                          style: TextStyle(
                              color: Color.fromRGBO(161, 161, 161, 1.0),
                              fontSize: 12.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Text("members",
                            style: TextStyle(
                                color: Color.fromRGBO(161, 161, 161, 1.0),
                                fontSize: 12.0)),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 12.0, right: 12.0, top: 8.0),
                  child: Container(
                    height: 67.5,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Host(ID: Global.selected_host_id),
                        Icon_list(
                          users: users,
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 11.3, right: 11.3, top: 50.0, bottom: 59.3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width / 2 - 11.3,
                          height: 30.0,
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 2.0,
                                color: isPressed
                                    ? Colors.transparent
                                    : Color(0xFFA2A2A2)),
                            color: isPressed ? Color(0xFFA2A2A2) : Colors.white,
                          ),
                          child: Container(
                            width: 57.0,
                            // color: Colors.red,
                            child: Text(
                              "CURRENT",
                              style: TextStyle(
                                  color: isPressed
                                      ? Colors.white
                                      : Color(0xFFA2A2A2),
                                  fontFamily: "HelveticaNeue",
                                  fontSize: 12.0),
                            ),
                          ),
                        ),
                        onTap: () {
                          press();
                        },
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: press,
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 2.0,
                                    color: isPressed
                                        ? Color(0xFFA2A2A2)
                                        : Colors.transparent),
                                color: isPressed
                                    ? Colors.white
                                    : Color(0xFFA2A2A2)),
                            height: 30.0,
                            child: Container(
                              width: 57.0,
                              // color: Colors.red,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "PAST",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: isPressed
                                            ? Color(0xFFA2A2A2)
                                            : Colors.white,
                                        fontFamily: "HelveticaNeue",
                                        fontSize: 12.0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                MeetListView(
                  4,
                  isList: false,
                  canEdit: false,
                  hasSearchBar: false,
                  isCurrent: isPressed,
                  host_ID: Global.selected_host_id,
                  key: keyMeetListView_hostAdmin,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 2.0),
                  child: FullWidthButton(
                    "ADD NEW HUB",
                    onPressed: () async {
                      var response_hub = await Request.getDio().get(
                          "host/get/hub",
                          data: {"Host_ID": widget.host_id});
                      if (response_hub.data["Data"] == -1) {
                        // this host is not link to the hub
                        await Global.router.navigateTo(
                            context, "/CreateHub/${widget.host_id}",
                            transition: TransitionType.fadeIn);
                      } else {
                        showDialog(
                            context: context,
                            child: AlertDialog(
                              content: Text(
                                  "You have already link to an existed hub"),
                            ));
                      }
                    },
                    color: Colors.grey,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 2.0),
                  child: FullWidthButton(
                    "ADD OTHER USERS AS ADMIN",
                    onPressed: () async {
                      await getUsers_without_host();
                      if (invite_users == null || invite_users.length == 0) {
                        showDialog(
                            context: context,
                            child: AlertDialog(
                              content: Container(
                                child: Text("No suitable user"),
                              ),
                            ));
                      } else {
                        showDialog(
                            context: context,
                            child: AlertDialog(
                                content: Container(
                              height: 300.0,
                              width: 100.0,
                              child: ListView.builder(
                                itemBuilder: (_, i) {
                                  return Icon_Add_Admin(
                                    user: invite_users[i],
                                    host_id: widget.host_id,
                                  );
                                },
                                itemCount: invite_users.length,
                              ),
                            )));
                      }
                    },
                    color: Colors.grey,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 2.0),
                  child: FullWidthButton(
                    "APPLY TO BE ANOTHER HOST",
                    onPressed: () {
                      Global.router.navigateTo(context, "/CreateHost",
                          transition: TransitionType.native);
                    },
                    color: Colors.grey,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 2.0),
                  child: FullWidthButton(
                    "MESSAGE TO ALL MEMBERS",
                    onPressed: () {
                      String text;
                      showDialog(
                        context: context,
                        child: AlertDialog(
                          contentPadding: const EdgeInsets.all(16.0),
                          content: new Row(
                            children: <Widget>[
                              new Expanded(
                                child: new TextField(
                                  autocorrect: false,
                                  onChanged: (s) {
                                    text = s;
                                  },
                                  autofocus: true,
                                  decoration: new InputDecoration(
                                      labelText: 'Message to all members',
                                      hintText: 'Write Your Text'),
                                ),
                              )
                            ],
                          ),
                          actions: <Widget>[
                            new FlatButton(
                                child: const Text('CANCEL'),
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                            new FlatButton(
                                child: const Text('SEND'),
                                onPressed: () {
                                  send_to_all(text);
                                  Navigator.pop(context);
                                })
                          ],
                        ),
                      );
                    },
                    color: Colors.grey,
                  ),
                ),
              ],
            )),
          );
  }
}

class Icon_Add_Admin extends StatefulWidget {
  final Map<String, dynamic> user;
  final int host_id;
  Icon_Add_Admin({Key key, @required this.user, this.host_id})
      : super(key: key);
  @override
  Icon_Add_AdminState createState() {
    return new Icon_Add_AdminState();
  }
}

class Icon_Add_AdminState extends State<Icon_Add_Admin> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async {
        var response = await Request.getDio().patch("host/invite",
            data: {"Host_ID": widget.host_id, "User_ID": widget.user["ID"]});
        if (response.data["Code"] == 200) {
          showDialog(
              context: context,
              child: AlertDialog(
                title: Text("Invite successfully"),
              ));
        } else if (response.data["Code"] == 2101) {
          showDialog(
              context: context,
              child: AlertDialog(
                title: Text("The Selected user has been host already"),
              ));
        }
        ;
      },
      leading: Container(
        width: 45.0,
        height: 45.0,
        color: Colors.grey,
        child: widget.user.containsKey("IconUrl") == true
            ? Image.network(
                Global.baseUrl + widget.user["IconUrl"],
                //placeholder: Container(color: Colors.grey),
                //errorWidget: Image.asset("images/login_background.jpg",fit: BoxFit.cover,),
                fit: BoxFit.cover,
              )
            : Image.asset(
                'images/placeholder.png',
                fit: BoxFit.cover,
              ),
      ),
      title: Text(widget.user["Name"]),
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int unread_number;
  File _image;
  ProfileForm form;
  GlobalKey<MeetListViewState> keyMeetListView_profile =
      new GlobalKey<MeetListViewState>();

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (this.mounted) {
      setState(() {
        _image = image;
      });
    }
    uploadPhoto();
  }

  Future uploadPhoto() async {
    FormData formdata = new FormData.from(
        {"icon": new UploadFileInfo(_image, "icon.jpg"), "ID": Global.ac.id});
    // formdata.add("photo", new UploadFileInfo(_image, 'photo.jpg'));
    var response =
        await Request.uploadFile().post("me/upload/image", data: formdata);
    if (response.data["Code"] == 200) {
      await get_profile();
      if (this.mounted) {
        setState(() {});
      }
    } else {
      showDialog(
          context: context,
          child: AlertDialog(
            content: Text("Failed to upload Icon"),
          ));
    }
  }

  _showDialog() async {
    await showDialog<String>(
      context: context,
      child: new AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        content: new Row(
          children: <Widget>[
            new Expanded(
              child: new TextField(
                autocorrect: false,
                autofocus: true,
                decoration: new InputDecoration(
                    labelText: 'Full Name', hintText: 'eg. John Smith'),
              ),
            )
          ],
        ),
        actions: <Widget>[
          new FlatButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              }),
          new FlatButton(
              child: const Text('OPEN'),
              onPressed: () {
                Navigator.pop(context);
              })
        ],
      ),
    );
  }

  void changeInput(String s) {
    _showDialog();
  }

  Map<String, String> result;
  Future<Null> get_profile() async {
    var response = await Request.getDio().get("me/get");
    form.DATA["Name"] = response.data["Data"]["Name"];
    form.DATA["First_Name"] = response.data["Data"]["First_Name"];
    form.DATA["Last_Name"] = response.data["Data"]["Last_Name"];
    form.DATA["Email"] = response.data["Data"]["Email"];
    form.DATA["Phone"] = response.data["Data"]["Phone"];
    // if (response.data["Data"]["Birth"] != null) {
    //   String date =
    //       DateTime.parse(response.data["Data"]["Birth"]).year.toString() +
    //           "-" +
    //           DateTime.parse(response.data["Data"]["Birth"]).month.toString() +
    //           "-" +
    //           DateTime.parse(response.data["Data"]["Birth"]).day.toString();
    //   form.DATA["Birth"] = date;
    // }
    form.DATA["Birth"] = response.data["Data"]["Birth"];
    form.DATA["Gender"] = response.data["Data"]["Gender"];
    form.DATA["Marital"] = response.data["Data"]["Marital"];
    form.DATA["HomeTown"] = response.data["Data"]["HomeTown"];
    form.DATA["LiveLocation"] = response.data["Data"]["LiveLocation"];
    form.DATA["WorkLocation"] = response.data["Data"]["WorkLocation"];
    form.DATA["Religion"] = response.data["Data"]["Religion"];
    form.DATA["Profession"] = response.data["Data"]["Profession"];
    form.DATA["FavActivity"] = response.data["Data"]["FavActivity"];
    form.DATA["Share"] = response.data["Data"]["Share"];
    form.DATA["IconUrl"] = response.data["Data"]["IconUrl"] != null
        ? Global.baseUrl + response.data["Data"]["IconUrl"]
        : null;
    if (this.mounted) {
      setState(() {});
    }
  }

  @override
  initState() {
    // TODO: implement initState
    get_profile();
    form = new ProfileForm();
    super.initState();
  }

  bool isPressed = false;

  void press() {
    if (this.mounted) {
      setState(() {
        isPressed = !isPressed;
        keyMeetListView_profile.currentState.widget.isSaved =
            !keyMeetListView_profile.currentState.widget.isSaved;
        keyMeetListView_profile.currentState.get_meetup_list();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return form.DATA.isEmpty
        ? Center(child: CircularProgressIndicator())
        : Padding(
            padding: const EdgeInsets.only(top: 27.0),
            child: ListView(
              children: <Widget>[
                GestureDetector(
                  onTap: getImage,
                  child: Center(
                      child: Container(
                          width: 125.0,
                          height: 125.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.grey),
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(63.0)),
                            child: form.DATA["IconUrl"] == null
                                ? Image.asset(
                                    'images/placeholder.png',
                                    fit: BoxFit.cover,
                                  )
                                : Image.network(
                                    form.DATA["IconUrl"],
                                    fit: BoxFit.cover,
                                  ),
                          ))),
                ),
                IconTheme(
                  data: IconTheme.of(context).copyWith(size: 30.0),
                  child: Column(
                    children: <Widget>[
                      Center(
                          child: Padding(
                        padding: const EdgeInsets.only(bottom: 43.0, top: 13.0),
                        child: Text(
                          form.DATA["Name"],
                          style: Global.style_profile_title,
                        ),
                      )),
                      // ListTile(leading: Icon(GCIcon.profile),title: Text('Wendy Chan',style: Global.style_profile,), onLongPress: (){changeInput('Name');},),
                      form.textField(
                          icon: GCIcon.profile,
                          tag: "Name",
                          hint: "eg. Ben Chan",
                          title: "Input Your Name"),
                      form.emailField(
                          icon: GCIcon.mail,
                          tag: "Email",
                          hint: "eg. info@ibasezero.com",
                          title: "Input Your Email"),
                      form.numberField(
                          icon: GCIcon.phone,
                          tag: "Phone",
                          hint: "eg. 12345678",
                          title: "Input Your Phone Number"),
                      form.choiceField(
                        icon: GCIcon.gender,
                        tag: "Gender",
                        hint: " ",
                        title: "gender",
                        choices: <String>["Male", "Female", "Secret"],
                      ),
                      // ListTile(leading: Icon(GCIcon.b_day),title: Text('June 4, 1989 ',style: Global.style_profile,),onTap: (){ getCountry(); },),
                      form.dateField(
                          icon: GCIcon.b_day,
                          tag: "Birth",
                          hint: "eg. 1991-03-21",
                          title: "Input Your Date of Birth"),
                      form.choiceField(
                        icon: GCIcon.marital_status,
                        tag: "Marital",
                        hint: " ",
                        title: "marital status",
                        choices: <String>["Single", "Married", "Others"],
                      ),
                      // ListTile(leading: Icon(GCIcon.marital_status),title: Text('single ',style: Global.style_profile,),onTap: (){_showAutocomplete();},),
                      //ListTile(leading: Icon(GCIcon.location),title: Text('from Vancouver  ',style: Global.style_profile,), onTap: (){showPlacePicker();},),
                      form.countryFiled(
                        icon: GCIcon.location,
                        tag: "HomeTown",
                        hint: " ",
                        title: "hometown",
                      ),

                      form.textField(
                        icon: GCIcon.book,
                        tag: "LiveLocation",
                        hint: " ",
                        title: "live location",
                      ),
                      form.textField(
                        icon: Flutter_0824_icons.work_location,
                        tag: "WorkLocation",
                        hint: " ",
                        title: "work location",
                      ),
                      form.textField(
                          icon: GCIcon.job,
                          tag: "Profession",
                          hint: "eg. secretary",
                          title: "Input Your profession"),
                      form.textField(
                        icon: GCIcon.religion,
                        tag: "Religion",
                        hint: " ",
                        title: "religion",
                      ),
                      form.textField(
                          icon: GCIcon.favorite_activities,
                          tag: "FavActivity",
                          hint: "eg. jogging, music, cuisine, dancing, reading",
                          title: "favorite activities"),
                      form.textField(
                          icon: GCIcon.description,
                          tag: "Share",
                          hint:
                              "eg. I love to share to chat with friends, and would enjoy meeting up with new people.",
                          title: "share something"),
                      //Li//stTile(leading: Icon(GCIcon.favorite_activities),title: Text('jogging, music, cuisine, dancing, reading  ',style: Global.style_profile,)),
                      //ListTile(leading: Icon(GCIcon.description),title: Text('I love to share to chat with friends, and would enjoy meeting up with new people.',style: Global.style_profile,)),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 11.0, right: 11.0, top: 60.6, bottom: 56.8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            InkWell(
                              child: Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width / 2 -
                                    11.0,
                                height: 30.9,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 2.0,
                                      color: isPressed
                                          ? Colors.transparent
                                          : Color(0xFFA2A2A2)),
                                  color: isPressed
                                      ? Color(0xFFA2A2A2)
                                      : Colors.white,
                                ),
                                child: Container(
                                  width: 50.0,
                                  child: Text(
                                    "SAVED",
                                    style: TextStyle(
                                        color: isPressed
                                            ? Colors.white
                                            : Color(0xFFA2A2A2)),
                                  ),
                                ),
                              ),
                              onTap: press,
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: press,
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 2.0,
                                          color: isPressed
                                              ? Color(0xFFA2A2A2)
                                              : Colors.transparent),
                                      color: isPressed
                                          ? Colors.white
                                          : Color(0xFFA2A2A2)),
                                  height: 30.9,
                                  child: Container(
                                    width: 43.0,
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text("PAST",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: isPressed
                                                  ? Color(0xFFA2A2A2)
                                                  : Colors.white,
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      MeetListView(
                        6,
                        isList: false,
                        hasSearchBar: false,
                        isSaved: isPressed,
                        key: keyMeetListView_profile,
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
  }
}

class HubCategoryPage extends StatefulWidget {
  HubCategoryPage({Key key}) : super(key: key);
  @override
  HubCategoryPageState createState() => HubCategoryPageState();
}

class HubCategoryPageState extends State<HubCategoryPage> {
  StaticMapProvider provider;
  Uri uri;
  List<dynamic> hub_data = [];
  List<Marker> marker_list = [];
  GlobalKey<Search_Bar_HubState> key_search_bar_hub =
      new GlobalKey<Search_Bar_HubState>();
  String html = '';

  Future get_hub_category() async {
    var response = await Request.getDio().get("others/get", data: {"ID": 5});
    if (response.data["Code"] == 200) {
      if (this.mounted) {
        setState(() {
          print(response.data["Data"]);
          html = response.data["Data"];
        });
      }
    }
  }

  showMap() {
    MapView mapView =  MapView();
    mapView.onToolbarAction.listen((id) {
      if (id == 1) {
        mapView.dismiss();
      }
    });
    // mapView.show(new MapOptions());
    mapView.show(
        new MapOptions(
            mapViewType: MapViewType.normal,
            showUserLocation: true,
            initialCameraPosition: new CameraPosition(
                new Location(double.parse(hub_data[0]["Latitude"].toString()),
                    double.parse(hub_data[0]["Longitude"].toString())),
                14.0),
            title: "Hub"),
        toolbarActions: [new ToolbarAction("Close", 1)]);

    mapView.setMarkers(marker_list);
    Timer(Duration(milliseconds: 200), () {
      mapView.zoomToFit(padding: 100);
    });
    mapView.onTouchAnnotation.listen((annotation) {
      //_handleDismiss();
      mapView.dismiss();
      Global.router.navigateTo(context, "/Hub/${annotation.id}",
          transition: TransitionType.native);
    });
  }

  Future getHub() async {
    provider = new StaticMapProvider('AIzaSyDeKVY6XnuyrxmfmU4fRJ5gqrL56yMHNEc');
    Response response = await Request.getDio().get("hub/get/all");
    if (response.data["Code"] == 200) {
      if (this.mounted) {
        setState(() {
          hub_data = response.data["Data"];
          for (int i = 0; i < hub_data.length; i++) {
            marker_list.add(new Marker(
                hub_data[i]["ID"].toString(),
                hub_data[i]["Name"] ?? "",
                double.parse(hub_data[i]["Latitude"].toString()),
                double.parse(hub_data[i]["Longitude"].toString())));
          }
          uri = provider.getStaticUriWithMarkersAndZoom(
            marker_list,
            center: new Location(
              double.parse(hub_data[0]["Latitude"].toString()),
              double.parse(hub_data[0]["Longitude"].toString()),
            ),
            zoomLevel: 18,
            width: 900,
            height: 400,
            maptype: StaticMapViewType.roadmap,
          );
        });
      }
    }
  }

  @override
  void initState() {
    getHub();
    get_hub_category();
    super.initState();
  }

  realShowMap(){


  }

  @override
  Widget build(BuildContext context) {
    print(uri.toString());
    return SingleChildScrollView(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Column(
          children: <Widget>[
            uri != null
                ? GestureDetector(
                    onTap: () async {
                      //is it normal for never using bool focus?

                        bool focus = await showMap();

                        // print('clicked the map.');
                    
                      // Global.router.navigateTo(context, "/MapView",
                      //     transition: TransitionType.native);
                      
                      

                    },
                    child: Container(
                      //this is where mapview located

                      child: Image.network(
                        uri.toString(),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : Container(height: 265.0, color: Colors.grey),
            Padding(
              padding: const EdgeInsets.only(
                  top: 14.0, left: 11.0, right: 11.0, bottom: 36.0),
              child: new Search_Bar_Hub(
                "search the hub near you",
                uri: uri,
                marker_list: marker_list,
                key: key_search_bar_hub,
              ),
            ),
            Column(
              children: <Widget>[
                Html(
                  data: html,
                ),
                ColumnBuilder(
                  itemBuilder: (BuildContext context, int index) {
                    var data = hub_data;
                    return HubTile(
                      data: hub_data[index],
                    );
                  },
                  itemCount: hub_data.isEmpty ? 0 : hub_data.length,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class HubTile extends StatelessWidget {
  final Map<String, dynamic> data;
  const HubTile({
    Key key,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: GestureDetector(
        onTap: () {
          Global.router.navigateTo(context, "/Hub/${data["ID"]}",
              transition: TransitionType.native);
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: InkWell(
                child: Container(
                  width: 54.8,
                  height: 54.8,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.cover,
                          image: data.containsKey("LogoUrl") != false
                              ? new NetworkImage(
                                  Global.baseUrl + data["LogoUrl"] + "?tn=108",
                                )
                              : AssetImage('images/placeholder.png'))),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 12.0,
                  right: 12.0,
                ),
                child: Container(
                  // height: 54.8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        data["Name"],
                        style: Global.style_hubDetail,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        data["Location"],
                        style: Global.style_hubDetail,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "Open ${data['Open_hour']}",
                        style: Global.style_hubDetail,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Search_Bar_Hub extends StatefulWidget {
  final String title;
  Uri uri;
  List<Marker> marker_list;
  Search_Bar_Hub(this.title,
      {Key key, @required this.uri, @required this.marker_list})
      : super(key: key);

  @override
  Search_Bar_HubState createState() {
    return new Search_Bar_HubState();
  }
}

class Search_Bar_HubState extends State<Search_Bar_Hub> {
  FocusNode n = new FocusNode();
  Future search_hub(search) async {
    var response =
        await Request.getDio().get("hub/search", data: {"Search": search});
    List<dynamic> search_result = response.data["Data"];
    if (this.mounted && search_result.length != 0) {
      print(search_result);
      widget.marker_list = [];
      for (int i = 0; i < search_result.length; i++) {
        widget.marker_list.add(new Marker(
            search_result[i]["ID"].toString(),
            search_result[i]["Name"] ?? "",
            double.parse(search_result[i]["Latitude"].toString()),
            double.parse(search_result[i]["Longitude"].toString())));
      }
      widget.uri = Global.provider.getStaticUriWithMarkersAndZoom(
        widget.marker_list,
        center: new Location(
          widget.marker_list[0].latitude,
          widget.marker_list[0].longitude,
        ),
        zoomLevel: 18,
        width: 900,
        height: 400,
        maptype: StaticMapViewType.roadmap,
      );
      Global.hub_category.currentState.setState(() {
        Global.hub_category.currentState.uri = widget.uri;
        Global.hub_category.currentState.marker_list = widget.marker_list;
        Global.hub_category.currentState.hub_data = search_result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 43.0,
      decoration: BoxDecoration(
          borderRadius: new BorderRadius.all(new Radius.circular(15.0)),
          color: Color.fromRGBO(239, 239, 239, 1.0)),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Icon(
              Icons.search,
              color: Color(0xffC0BFBF),
            ),
          ),
          Expanded(
            child: Padding(
                padding: const EdgeInsets.only(right: 35.0),
                child: TextField(
                  focusNode: n,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: widget.title,
                    hintStyle: TextStyle(
                        color: Color(0xffC0BFBF),
                        fontFamily: "HelveticaNeue",
                        fontSize: 18.0),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xff444444),
                      fontFamily: "HelveticaNeue",
                      fontSize: 18.0),
                  onChanged: (value) {
                    search_hub(value);
                  },
                )),
          ),
        ],
      ),
    );
  }
}

class Search_Bar extends StatefulWidget {
  final String title;
  const Search_Bar(
    this.title, {
    Key key,
  }) : super(key: key);

  @override
  Search_BarState createState() {
    return new Search_BarState();
  }
}

class Search_BarState extends State<Search_Bar> {
  Future search_meet(value) async {
    var response = await Request.getDio()
        .get("search/meet_list", data: {"category_ID": 1, "Search": value});
    if (this.mounted) {
      setState(() {
        Global.kHomePage.currentState.search_result_data =
            response.data["Data"];
        Global.kHomePage.currentState.setState(() {
          Global.kHomePage.currentState.search_result_data =
              response.data["Data"];
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 43.0,
      decoration: BoxDecoration(
          borderRadius: new BorderRadius.all(new Radius.circular(15.0)),
          color: Color.fromRGBO(239, 239, 239, 1.0)),
      child: FlatButton(
        // color:  Colors.red,
        padding: EdgeInsets.only(
          left: 8.0,
          right: 8.0,
        ),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Icon(
                Icons.search,
                color: Color(0xffC0BFBF),
              ),
            ),
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.only(right: 35.0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: widget.title,
                      hintStyle: TextStyle(
                          color: Color(0xffC0BFBF),
                          fontFamily: "HelveticaNeue",
                          fontSize: 18.0),
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color(0xff444444),
                        fontFamily: "HelveticaNeue",
                        fontSize: 18.0),
                    onChanged: (value) {
                      search_meet(value);
                    },
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

class MeetListView_Search extends StatefulWidget {
  var data;
  String title;
  int index;
  int category_ID;
  MeetListView_Search({
    Key key,
    this.data,
    this.title,
    this.index,
    this.category_ID,
  }) : super(key: key);

  @override
  MeetListView_SearchState createState() => MeetListView_SearchState();
}

class MeetListView_SearchState extends State<MeetListView_Search> {
  List data;
  Future<Null> get_meetup_list() async {
    var response = await Request.getDio()
        .get("meet/get_list", data: {"index": widget.index});
    if (this.mounted) {
      data = response.data["Data"];
      setState(() {});
    }
  }

  Future search_meet(value) async {
    var response = await Request.getDio().get("search/meet_list",
        data: {"category_ID": widget.category_ID, "Search": value});
    if (this.mounted) {
      setState(() {
        data = response.data["Data"];
      });
    }
  }

  @override
  void initState() {
    get_meetup_list();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // get_meetup_list();
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Theme(
        data: Theme.of(context).copyWith(splashColor: Colors.red),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: data == null
              ? Container()
              : ListView(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      height: 43.0,
                      decoration: BoxDecoration(
                          borderRadius:
                              new BorderRadius.all(new Radius.circular(15.0)),
                          color: Color.fromRGBO(239, 239, 239, 1.0)),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Icon(
                              Icons.search,
                              color: Color(0xffC0BFBF),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                                padding: const EdgeInsets.only(right: 35.0),
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: widget.title,
                                    hintStyle: TextStyle(
                                        color: Color(0xffC0BFBF),
                                        fontFamily: "HelveticaNeue"),
                                  ),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Color(0xff444444),
                                      fontFamily: "HelveticaNeue",
                                      fontSize: 18.0),
                                  onChanged: (value) {
                                    search_meet(value);
                                  },
                                )),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: data.isEmpty == true
                          ? Container(
                              child: Center(
                                  child: Text(
                                "No Result",
                              )),
                            )
                          : Column(
                              children: (data as List)
                                  .map((f) => MeetSlider(f))
                                  .toList(),
                            ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
