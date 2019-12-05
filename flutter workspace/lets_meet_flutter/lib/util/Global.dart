import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:lets_meet_flutter/main.dart';
import 'package:lets_meet_flutter/pages/eventPage.dart';
import 'package:lets_meet_flutter/pages/homePage.dart';
import 'package:lets_meet_flutter/widget.dart';
import 'package:cirrus_map_view/static_map_provider.dart';
import 'package:place_picker/place_picker.dart';

class Global {
  static String Token = "noTOKEN";
  static int index = 2;
  static final router = new Router();
  static BuildContext context;
  static int selected_host_id;
  static AC ac = new AC();
  // static const baseUrl = "http://192.168.1.43:45419/";
  static const baseUrl = "http://god.ibasezero.com:45419/";
  static GlobalKey<EventPageState> keyContentSection =
      new GlobalKey<EventPageState>();
  // static GlobalKey kBotBar = new GlobalKey();
  static final GlobalKey<HomePageState> kHomePage = new GlobalKey();
  static final GlobalKey kBotBar = new GlobalKey();
  static final GlobalKey<ScaffoldState> sc = new GlobalKey();
  static final GlobalKey<HubCategoryPageState> hub_category = new GlobalKey();
  static final GlobalKey<MeetListView_SearchState> kMeetListViewSearch_meet =
      new GlobalKey();
  static final GlobalKey<MeetListView_SearchState>
      kMeetListViewSearch_volunteer = new GlobalKey();
  static final GlobalKey<MeetListView_SearchState> kMeetListViewSearch_book =
      new GlobalKey();
  static final GlobalKey<Swiper_SectionState> kSwiper = new GlobalKey();
  static final List colors = [
    Color(0xffb89780).withOpacity(0.5),
    Color(0xff4F37BC).withOpacity(0.5),
    Color(0xffea6a3d).withOpacity(0.5),
    Color(0xff59a16a).withOpacity(0.5),
    Color(0xff11a9aa).withOpacity(0.5),
    Color(0xff336244).withOpacity(0.5),
    Color(0xffeb4b4b).withOpacity(0.5),
    Color(0xffd9c343).withOpacity(0.5),
    Color(0xff42147a).withOpacity(0.5),
    Color(0xffe0955d).withOpacity(0.5),
    Color(0xffbc63b4).withOpacity(0.5),
    Color(0xff7fbb6d).withOpacity(0.5),
    Color(0xff7074d0).withOpacity(0.5),
    Color(0xff4dbee8).withOpacity(0.5),
    Color(0xffc1db6d).withOpacity(0.5),
    Color(0xffec6e76).withOpacity(0.5),
    Color(0xff7b6352).withOpacity(0.5),
    Color(0xff001ea9).withOpacity(0.5),
    Color(0xff69a5e6).withOpacity(0.5),
    Color(0xff2a5e8f).withOpacity(0.5),
    Color(0xffba7549).withOpacity(0.5)
  ];
  static bool remember_me = false;
  static StaticMapProvider provider =
      new StaticMapProvider('AIzaSyDeKVY6XnuyrxmfmU4fRJ5gqrL56yMHNEc');
  static List<dynamic> typeList;
  static Map<String, List<VoidCallback>> renewCallback = new Map();

  static addRenewListener(String s, VoidCallback cb) {
    renewCallback[s] = renewCallback[s] ?? [];
    renewCallback[s].add(cb);
  }

  static removeRenewListener(String s, VoidCallback cb) {
    //renewCallback[s] = renewCallback[s]??[];
    renewCallback[s].remove(cb);
  }

  static callRenewListener(String s) {
    if (renewCallback[s] != null) {
      renewCallback[s].forEach((f) {
        f();
      });
    }
  }

  static get_type_name_by_id(int id) {
    for (int i = 0; i < typeList.length; i++) {
      if (typeList[i]["ID"] == id) return typeList[i]["Type"];
    }
  }

  static const TextStyle stlye_title = TextStyle(
      color: Colors.white, fontSize: 14.0, fontFamily: "HelveticaNeue");

  static const TextStyle swiper_sub_text = TextStyle(
      color: Colors.white, fontSize: 12.0, fontFamily: "HelveticaNeue");

  static const TextStyle stlye_subTitle = TextStyle(
      color: Colors.white, fontSize: 11.0, fontFamily: "HelveticaNeue");

  static const TextStyle stlye_subTitle_time = TextStyle(
      color: Colors.white, fontSize: 9.0, fontFamily: "HelveticaNeue");

  static const TextStyle stlye_title_not_approve = TextStyle(
      color: Color(0xFFD3D3D3),
      // color: Colors.white,
      fontSize: 14.0,
      fontFamily: "HelveticaNeue");

  static const TextStyle stlye_subTitle_not_approve = TextStyle(
      color: Color(0xFFD3D3D3), fontSize: 11.0, fontFamily: "HelveticaNeue");

  static const TextStyle stlye_subTitle_time_not_approve = TextStyle(
      color: Color(0xFFD3D3D3), fontSize: 10.0, fontFamily: "HelveticaNeue");

  static const TextStyle style_hubText = TextStyle(
      color: Color.fromRGBO(96, 96, 96, 1.0),
      fontSize: 14.0,
      height: 1.2,
      fontFamily: "HelveticaNeue");

  static const TextStyle style_hubDetail = TextStyle(
    color: Color.fromRGBO(96, 96, 96, 1.0),
    fontSize: 12.0,
    height: 1.2,
    fontFamily: "HelveticaNeue",
  );

  static const TextStyle stlye_sliderTitle = TextStyle(
      color: Color(0xFFA1A1A1), fontSize: 13.0, fontFamily: "HelveticaNeue");

  static const TextStyle style_bottomBarActive =
      TextStyle(color: Color(0xFF4F5A9C), fontSize: 9.0);
  static const TextStyle style_bottomBar = TextStyle(fontSize: 9.0);

  static const TextStyle style_input = TextStyle(
      color: Colors.white,
      fontSize: 17.0,
      height: 0.8,
      fontFamily: "HelveticaNeue");

  static const TextStyle style_profile_title = TextStyle(
    color: Color(0xFF7D7C7C),
    // color: Colors.red,
    height: 1.2,
    fontSize: 17.0,
    fontFamily: "HelveticaNeue",
  );
  static const TextStyle style_profile = TextStyle(
      color: Color(0xFF7D7C7C),
      // color: Colors.red,
      height: 1.2,
      fontSize: 15.0,
      fontFamily: "HelveticaNeue",
      fontWeight: FontWeight.w300);
  static const TextStyle create_title = TextStyle(
    color: Colors.black,
    fontSize: 14.0,
    fontFamily: "HelveticaNeue",
  );

  static const TextStyle create_hint = TextStyle(
    color: Color(0xFFC9C9C9),
    fontSize: 14.0,
    fontFamily: "HelveticaNeue",
  );

  static const TextStyle create_button = TextStyle(
    color: Color(0xFF606060),
    fontSize: 14.0,
    fontFamily: "HelveticaNeue",
  );

  static dynamic update_message;
  static dynamic update_message_tile;
  static dynamic get_unread_number;
}

class AC {
  String name;
  List host_ID;
  List joined_list;
  List liked_list;
  List<dynamic> host_list = new List<dynamic>();
  int id;
  bool isHost = false;

  AC fromJSON(obj) {
    name = obj["Name"];
    if (jsonDecode(obj["Host_ID"]) == null) {
      // host_ID == new List();
    } else {
      host_ID = jsonDecode(obj["Host_ID"]);
      joined_list = obj["joined_list"];
    }
    liked_list = jsonDecode(obj["Liked"]);
    host_list = obj["host_list"];
    id = int.parse(obj["ID"].toString());

    return this;
  }
}

Future<LocationResult> showRealPlacePicker(BuildContext context) async {
  LocationResult result = await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) =>
          PlacePicker("AIzaSyDeKVY6XnuyrxmfmU4fRJ5gqrL56yMHNEc")));

  // Handle the result in your way
  print(result);
  return result;
}
