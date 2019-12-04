import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lets_meet_flutter/main.dart';
import 'package:lets_meet_flutter/pages/homePage.dart';
import 'package:lets_meet_flutter/pages/loginPage_new.dart';
import 'package:lets_meet_flutter/util/GIcons.dart';
import 'package:lets_meet_flutter/util/Global.dart';
import 'package:lets_meet_flutter/util/bzEngine.dart';
import 'package:lets_meet_flutter/util/countryPicker.dart';
import 'package:lets_meet_flutter/util/flutter_0917_icons.dart';
import 'package:lets_meet_flutter/util/g_c_icon_icons.dart';
import 'package:country_code_picker/country_code_picker.dart';
// import 'package:flutter_places_dialog/flutter_places_dialog.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:lets_meet_flutter/widget.dart';
import 'package:cirrus_map_view/map_view.dart';
import 'package:cirrus_map_view/static_map_provider.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:photo_view/photo_view.dart';

class EventPage extends StatefulWidget {
  final meetID;
  EventPage({Key key, this.meetID}) : super(key: key);
  @override
  EventPageState createState() => EventPageState();
}

class EventPageState extends State<EventPage> {
  Response response;
  Map<String, dynamic> meet_data = new Map<String, dynamic>();
  List<dynamic> users;
  List<dynamic> iconList = new List<dynamic>();

  Future getMeetup() async {
    response =
        await Request.getDio().get("meet/get", data: {"ID": widget.meetID});
    if (this.mounted) {
      setState(() {
        meet_data = response.data["Data"];
        if (meet_data["IconUrl"] != null) {
          iconList = jsonDecode(meet_data["IconUrl"]);
        }
      });
    }
  }

  Future getJoinedPeople() async {
    var response_users = await Request.getDio()
        .get("meet/joinedppl", data: {"ID": widget.meetID});
    if (this.mounted) {
      setState(() {
        users = response_users.data["Data"];
      });
    }
  }

  Future<Null> handleRefresh() async {
    await getMeetup();
    await getJoinedPeople();
    if (this.mounted) {
      setState(() {});
    }
    return null;
  }

  List<String> toformat(dynamic iconList) {
    if (meet_data is String) {
      return jsonDecode(iconList);
    } else {
      return new List<String>();
    }
  }

  bool is_host() {
    for (int i = 0; i < Global.ac.host_list.length; i++) {
      if (meet_data["Host_ID"] == Global.ac.host_list[i]["ID"]) return true;
    }
    return false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMeetup();
    getJoinedPeople();
    // getUser();
  }

  final GlobalKey kBotBar_event = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    print(meet_data["IconUrl"]);
    return Scaffold(
      floatingActionButton: is_host()
          ? new FloatingActionButton(
              backgroundColor: Colors.grey,
              child: Icon(Icons.edit),
              onPressed: () async {
                await Global.router.navigateTo(context,
                    "/EditEvent/${widget.meetID}/${meet_data['CategoryID']}",
                    transition: TransitionType.native);
                await getMeetup();
              },
            )
          : Container(),
      backgroundColor: Colors.white,
      body: iconList != null && meet_data != null && users != null
          ? SingleChildScrollView(
              child: Stack(
                children: <Widget>[
                  Swiper_Section(
                    iconList: iconList == null ? new List<String>() : iconList,
                  ),
                  meet_data["IconUrl"] == null
                      ? IgnorePointer(
                          child: Container(
                            height: 285.0,
                            color: meet_data["Color_Code"] != null
                                ? Color(int.parse(
                                        "0xff" + meet_data["Color_Code"]))
                                    .withOpacity(0.5)
                                : Colors.transparent,
                          ),
                        )
                      : Container(),
                  ContentSection(
                    meet_data: meet_data,
                    users: users,
                  ),
                ],
              ),
            )
          : Center(child: CircularProgressIndicator()),
      bottomNavigationBar: new BottomNavigationBarWidget(
        globalKey: kBotBar_event,
      ),
    );
  }
}

class ContentSection extends StatefulWidget {
  final Map<String, dynamic> meet_data;
  final List<dynamic> users;
  ContentSection({
    Key key,
    this.users,
    this.meet_data,
  }) : super(key: key);
  @override
  ContentSectionState createState() {
    return new ContentSectionState();
  }
}

class ContentSectionState extends State<ContentSection> {
  StaticMapProvider provider;
  Uri uri;
  List<Marker> marker_list;
  MapView mapView = new MapView();

  void showMap() {
    mapView.onMapReady.listen((_) {
      Timer(Duration(milliseconds: 200), () {
        mapView.setMarkers(marker_list);
        mapView.zoomToFit(padding: 100);
      });
    });

    mapView.show(
        new MapOptions(
            mapViewType: MapViewType.normal,
            showUserLocation: true,
            initialCameraPosition: new CameraPosition(
                new Location(
                    double.parse(widget.meet_data["Latitude"].toString()),
                    double.parse(widget.meet_data["Longitude"].toString())),
                14.0),
            title: "Event"),
        toolbarActions: [new ToolbarAction("Close", 1)]);

    mapView.onToolbarAction.listen((id) {
      if (id == 1) {
        _handleDismiss();
      }
    });
  }

  _handleDismiss() async {
    mapView.dismiss();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    marker_list = [
      Marker(
          widget.meet_data["ID"].toString(),
          widget.meet_data["Name"] ?? "",
          double.parse(widget.meet_data["Latitude"].toString()),
          double.parse(widget.meet_data["Longitude"].toString()),
          color: Colors.red)
    ];
    provider = new StaticMapProvider('AIzaSyCA3T4BDdR7Lhiqw1sZT3HBa3AvZJqtnP8');
    uri = provider.getStaticUriWithMarkersAndZoom(
      marker_list,
      center: new Location(
          double.parse(widget.meet_data["Latitude"].toString()),
          double.parse(widget.meet_data["Longitude"].toString())),
      zoomLevel: 16,
      width: 900,
      height: 400,
      maptype: StaticMapViewType.roadmap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).padding.top,
        ),
        Swiper_Text_Section(meet_data: widget.meet_data),
        Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  widget.meet_data["Category"] == 2
                      ? Padding(
                          padding: const EdgeInsets.only(right: 2.0),
                          child: Text(
                            widget.users == null
                                ? "0"
                                : widget.users.length.toString(),
                            style: TextStyle(
                              color: Color.fromRGBO(161, 161, 161, 1.0),
                              fontSize: 12.0,
                            ),
                          ),
                        )
                      : Container(),
                  widget.meet_data["CategoryID"] != 2 &&
                          widget.users.length != 0
                      ? Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: Row(
                            children: <Widget>[
                              Text(
                                widget.users.length.toString(),
                                style: TextStyle(
                                    color: Color.fromRGBO(161, 161, 161, 1.0),
                                    fontSize: 12.0),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 14.2, left: 6.0),
                                child: Text("going",
                                    style: TextStyle(
                                        color:
                                            Color.fromRGBO(161, 161, 161, 1.0),
                                        fontSize: 12.0)),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0),
              child: Container(
                height: 70.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Host(ID: int.parse(widget.meet_data["Host_ID"].toString())),
                    widget.users == null || widget.meet_data["CategoryID"] == 2
                        ? Container()
                        : Icon_list(
                            users: widget.users,
                          ),
                  ],
                ),
              ),
            ),
            Container(
                child: Detail_List_Section(
              data: widget.meet_data,
            )),
            int.parse(widget.meet_data["User_ID"].toString()) != Global.ac.id
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: FullWidthButton(
                      "SEND ENQUIRY TO HOST",
                      onPressed: () {
                        if (widget.meet_data["User_ID"] != Global.ac.id) {
                          Global.router.navigateTo(context,
                              "/ChatRoom/${widget.meet_data["User_ID"]}",
                              transition: TransitionType.native);
                        }
                      },
                      color: Colors.grey,
                    ),
                  )
                : Container(),
            SizedBox(
              height: 40.0,
            ),
            GestureDetector(
              onTap: showMap,
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200.0,
                  child: Image.network(
                     uri.toString() + "?tn=400",
                    // placeholder: (_,__){
                    //   return Container(color: Colors.grey);
                    // },
                    // errorWidget: (_,__,___){
                    //   return Image.asset(
                    //   "images/login_background.jpg",
                    //   fit: BoxFit.cover,
                    // );
                    // },
                    fit: BoxFit.cover,
                  )),
            ),
          ],
        )
      ],
    );
  }
}

class Swiper_Text_Section extends StatefulWidget {
  final Map<String, dynamic> meet_data;
  const Swiper_Text_Section({
    Key key,
    this.meet_data,
  }) : super(key: key);

  @override
  Swiper_Text_SectionState createState() {
    return new Swiper_Text_SectionState();
  }
}

class Swiper_Text_SectionState extends State<Swiper_Text_Section> {
  DynamicLinkParameters parameters;
  Uri dynamicLink;

  bool isLiked;
  bool checkLiked(liked_array) {
    if (widget.meet_data["ID"] != null) {
      setState(() {
        if (liked_array.contains(widget.meet_data["ID"])) {
          isLiked = true;
          // _showToast(context, "Add to favourites");
        } else {
          isLiked = false;
          // _showToast(context, "Cancel from favourites");
        }
      });
    }
  }

  bool checkJoinedList() {
    if (Global.ac.joined_list.contains(widget.meet_data["ID"]) == true) {
      return true;
    } else {
      return false;
    }
  }

  Future<Null> joinMeetup() async {
    await Request.getDio()
        .post("me/meetup/join", data: {"MeetupID": widget.meet_data["ID"]});
    await getUser();
    if (this.mounted) {
      setState(() {});
    }
    if (checkJoinedList()) {
      _showToast(context, "You have joined this meetup");
    } else {
      _showToast(context, "You have left this meetup");
    }
  }

  void _showToast(BuildContext context, String text) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(text),
        duration: new Duration(milliseconds: 500),
      ),
    );
  }

  Widget joinText() {
    if (widget.meet_data["CategoryID"] == 1) {
      return Padding(
        padding: const EdgeInsets.only(right: 7.0),
        child: Text(
            Global.ac.joined_list.contains(widget.meet_data["ID"]) == true
                ? "JOINED"
                : "JOIN",
            style: Global.swiper_sub_text),
      );
    } else if (widget.meet_data["CategoryID"] == 2) {
      return Container();
    } else if (widget.meet_data["CategoryID"] == 3) {
      return Padding(
        padding: const EdgeInsets.only(right: 7.0),
        child: Text(
            Global.ac.joined_list.contains(widget.meet_data["ID"]) == true
                ? "GOING"
                : "GO",
            style: Global.swiper_sub_text),
      );
    }
  }

  Future buildUrl(DynamicLinkParameters parameters) async {
    dynamicLink = await parameters.buildUrl();
  }

  @override
  void initState() {
    // TODO: implement initState
    checkLiked(Global.ac.liked_list);
    DynamicLinkParameters parameters = new DynamicLinkParameters(
      uriPrefix: 'meets.page.link',
      link: Uri.parse(
          "https://meetus/meet?id=" + widget.meet_data["ID"].toString()),
      androidParameters: AndroidParameters(
        packageName: 'com.basezero.letsmeet',
        minimumVersion: 1,
      ),
      iosParameters: IosParameters(
        bundleId: 'com.basezero.letsmeet',
        minimumVersion: '1',
        appStoreId: '1391576247',
      ),
    );
    buildUrl(parameters);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: 4.0,
      ),
      child: Container(
        height: 240.0,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    padding: EdgeInsets.only(top: 4.0),
                    icon: (Icon(
                      Icons.keyboard_arrow_left,
                      color: Colors.white,
                      size: 35.0,
                    )),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  GestureDetector(
                    onTap: () {
                      final RenderBox box = context.findRenderObject();
                      Share.share(
                          // "Check Out " +
                          //     widget.meet_data["EventName"] +
                          //     "\n meets.page.link/?link=https://meetus/meet?id=" +
                          //     widget.meet_data["ID"].toString(),
                          "Check Out " +
                              widget.meet_data["EventName"] + "\n" +
                          dynamicLink.toString(),
                          sharePositionOrigin:
                              box.localToGlobal(Offset.zero) & box.size);
                    },
                    child: Icon(
                      Flutter_0917_icons.output,
                      size: 24.0,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
                child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: IgnorePointer(
                  child: Text(
                    widget.meet_data["EventName"],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28.0,
                    ),
                  ),
                ),
              ),
            )),
            Container(
              height: 55.0,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(left: 7.5),
                        child: GestureDetector(
                          onTap: () async {
                            await Request.getDio().patch("meetup/like",
                                data: {"Meetup_ID": widget.meet_data["ID"]});
                            await getUser();
                            if (this.mounted) {
                              setState(() {
                                checkLiked(Global.ac.liked_list);
                                if (Global.ac.liked_list
                                    .contains(widget.meet_data["ID"])) {
                                  _showToast(context, "Add to favourites");
                                } else {
                                  _showToast(context, "Cancel from favourites");
                                }
                              });
                              if (widget.meet_data["CategoryID"] == 1) {
                                if (Global.kMeetListViewSearch_meet
                                        .currentState !=
                                    null) {
                                  Global.kMeetListViewSearch_meet.currentState
                                      .setState(() {
                                    Global.kMeetListViewSearch_meet.currentState
                                        .get_meetup_list();
                                  });
                                }
                              } else if (widget.meet_data["CategoryID"] == 2) {
                                if (Global.kMeetListViewSearch_book != null) {
                                  Global.kMeetListViewSearch_book.currentState
                                      .setState(() {
                                    Global.kMeetListViewSearch_book.currentState
                                        .get_meetup_list();
                                  });
                                }
                              } else if (widget.meet_data["CategoryID"] == 3) {
                                if (Global.kMeetListViewSearch_volunteer
                                        .currentState !=
                                    null) {
                                  Global.kMeetListViewSearch_volunteer
                                      .currentState
                                      .setState(() {
                                    Global.kMeetListViewSearch_volunteer
                                        .currentState
                                        .get_meetup_list();
                                  });
                                }
                              }
                            }
                          },
                          child: Container(
                            height: 40.0,
                            width: 90.0,
                            color: Colors.transparent,
                            alignment: Alignment.centerLeft,
                            child: isLiked == true
                                ? Icon(
                                    Icons.star,
                                    color: Colors.white,
                                    size: 25.0,
                                  )
                                : Icon(
                                    Icons.star_border,
                                    color: Colors.white,
                                    size: 25.0,
                                  ),
                          ),
                        )),
                    GestureDetector(
                      onTap: () {
                        if (widget.meet_data["CategoryID"] != 2) {
                          joinMeetup();
                          Global.keyContentSection.currentState.handleRefresh();
                        }
                      },
                      child: Container(
                        width: 90.0,
                        height: 40.0,
                        color: Colors.transparent,
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            joinText(),
                            widget.meet_data["CategoryID"] != 2
                                ? AbsorbPointer(
                                    child: Global.ac.joined_list
                                            .contains(widget.meet_data["ID"])
                                        ? Icon(
                                            Icons.add_circle,
                                            color: Colors.white,
                                            size: 24.0,
                                          )
                                        : Icon(
                                            GIcons.add,
                                            color: Colors.white,
                                            size: 24.0,
                                          ),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
