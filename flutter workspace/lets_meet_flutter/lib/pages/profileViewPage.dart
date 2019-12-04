import 'dart:async';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lets_meet_flutter/main.dart';
import 'package:lets_meet_flutter/pages/loginPage_new.dart';
import 'package:lets_meet_flutter/util/Global.dart';
import 'package:lets_meet_flutter/util/flutter_0824_icons.dart';
import 'package:lets_meet_flutter/util/g_c_icon_icons.dart';

class ProfileViewPage extends StatefulWidget {
  final int user_id;
  const ProfileViewPage({Key key, this.user_id}) : super(key: key);
  @override
  _ProfileViewPageState createState() => _ProfileViewPageState();
}

class _ProfileViewPageState extends State<ProfileViewPage> {
  Map<String, dynamic> user;

  String get_gender(int gender_id) {
    if (gender_id == 1) {
      return "Male";
    } else if (gender_id == 2) {
      return "Female";
    }
  }

  String get_marital_status(int marital_status_id) {
    if (marital_status_id == 1) {
      return "single";
    } else if (marital_status_id == 2) {
      return "married";
    }
  }

  Future getUser() async {
    var response = await Request.getDio()
        .get("user/profile/get", data: {"User_ID": widget.user_id});
    user = response.data["Data"];
    setState(() {
      user = response.data["Data"];
      if (user["Birth"] != null) {
        String date = DateTime.parse(response.data["Data"]["Birth"])
                .year
                .toString() +
            "-" +
            DateTime.parse(response.data["Data"]["Birth"]).month.toString() +
            "-" +
            DateTime.parse(response.data["Data"]["Birth"]).day.toString();
        user["Birth"] = date;
      }

      user["Gender_Name"] = response.data["Data"]["Gender"];
      user["Marital_Name"] =
          response.data["Data"]["Marital"];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Transform.translate(
            offset: Offset(0.0, 8.0),
            child: Image.asset(
              'images/meet_us.png',
              height: 200.0,
              width: 200.0,
              fit: BoxFit.cover,
              alignment: Alignment.center,
            )),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_arrow_left,
            color: Colors.grey,
            size: 48.0,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: user != null
          ? ListView(
              children: <Widget>[
                Center(
                  child: Container(
                    width: 125.0,
                    height: 125.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(63.0)),
                      child: user["IconUrl"] == null
                          ? Image.asset(
                              'images/placeholder.png',
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              Global.baseUrl + user["IconUrl"],
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
                Column(
                  children: <Widget>[
                    Center(
                        child: Padding(
                      padding: const EdgeInsets.only(bottom: 43.0, top: 13.0),
                      child: Text(
                        user["Name"],
                        style: Global.style_profile_title,
                      ),
                    )),
                    ProfileTile(
                      icon: GCIcon.profile,
                      value: user["Name"],
                    ),
                    ProfileTile(
                      icon: GCIcon.mail,
                      value: user["Email"],
                    ),
                    ProfileTile(
                      icon: GCIcon.phone,
                      value: user["Phone"],
                    ),
                    ProfileTile(
                      icon: GCIcon.gender,
                      value: user["Gender_Name"],
                    ),
                    ProfileTile(
                      icon: GCIcon.b_day,
                      value: user["Birth"],
                    ),
                    ProfileTile(
                      icon: GCIcon.marital_status,
                      value: user["Marital_Name"],
                    ),
                    ProfileTile(
                      icon: GCIcon.location,
                      value: user["HomeTown"],
                    ),
                    ProfileTile(
                      icon: GCIcon.book,
                      value: user["LiveLocation"],
                    ),
                    ProfileTile(
                      icon: Flutter_0824_icons.work_location,
                      value: user["WorkLocation"],
                    ),
                    ProfileTile(
                      icon: GCIcon.job,
                      value: user["Profession"],
                    ),
                    ProfileTile(
                      icon: GCIcon.religion,
                      value: user["Religion"],
                    ),
                    ProfileTile(
                      icon: GCIcon.favorite_activities,
                      value: user["FavActivity"],
                    ),
                    ProfileTile(
                      icon: GCIcon.description,
                      value: user["Share"],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 15.0),
                      child: FullWidthButton(
                        "START CONVERSATION",
                        onPressed: () {
                          if (user["ID"] != Global.ac.id) {
                            Global.router.navigateTo(
                                context, "/ChatRoom/${user["ID"]}",
                                transition: TransitionType.fadeIn);
                          }
                        },
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

class ProfileTile extends StatefulWidget {
  final IconData icon;
  final String value;
  ProfileTile({
    Key key,
    @required this.icon,
    @required this.value,
  }) : super(key: key);
  @override
  _ProfileTileState createState() => _ProfileTileState();
}

class _ProfileTileState extends State<ProfileTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 40.0,
      child: FlatButton(
        padding: EdgeInsets.only(right: 10.5),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 22.2),
              child: Icon(widget.icon, color: Color(0xff999999), size: 30.0,),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 25.1),
                child: Text(
                  widget.value != null ? widget.value : "-",
                  style: Global.style_profile,
                  softWrap: true,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
