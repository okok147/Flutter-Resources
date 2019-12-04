import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lets_meet_flutter/main.dart';
import 'package:lets_meet_flutter/pages/loginPage_new.dart';
import 'package:lets_meet_flutter/util/GIcons.dart';
import 'package:lets_meet_flutter/util/Global.dart';
import 'package:lets_meet_flutter/util/bzEngine.dart';
import 'package:lets_meet_flutter/util/countryPicker.dart';
import 'package:lets_meet_flutter/util/flutter_0824_icons.dart';
import 'package:lets_meet_flutter/util/flutter_0917_icons.dart';
import 'package:lets_meet_flutter/util/g_c_icon_icons.dart';
import 'package:country_code_picker/country_code_picker.dart';
// import 'package:google_places_picker/google_places_picker.dart';
// import 'package:flutter_places_dialog/flutter_places_dialog.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:lets_meet_flutter/widget.dart';
import 'package:cirrus_map_view/map_view.dart';
import 'package:cirrus_map_view/marker.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class HostPage extends StatefulWidget {
  final int hostID;
  const HostPage({Key key, this.hostID}) : super(key: key);
  @override
  _HostPageState createState() => _HostPageState();
}

class _HostPageState extends State<HostPage> {
  Map <String, dynamic> host = new Map<String, dynamic> ();
  StaticMapProvider provider;
  Uri uri;
  List<Marker> marker_list;
  List<dynamic> users;
  Map<String, dynamic> hub;
  final GlobalKey kBotBar_host = new GlobalKey();
  

  Future getHost() async {
    var response = await Request.getDio().get("host/get", data: {"ID": widget.hostID});
    host = response.data["Data"];
    if (this.mounted) {
      setState(() {
        // if(Global.kSwiper.currentState.mounted){
        //   Global.kSwiper.currentState.handleRefresh();
        // }
        
      });
    }
  }

  Future getUsers() async {
    var response_users = await Request.getDio()
        .get("host/get/users", data: {"Host_ID": widget.hostID});
    users = response_users.data["Data"];
    if (this.mounted) {
      setState(() {});
    }
  }

  Future getHub() async {
    var response_hub = await Request.getDio()
        .get("host/get/hub", data: {"Host_ID": widget.hostID});
    if (response_hub.data["Data"] != -1) {
      //the host is link to a hub
      if (this.mounted) {
        setState(() {
          hub = response_hub.data["Data"];
        });
      }
    }
  }

  Future startMap() async {
    await getHub();
    await getHost();
    if (host.containsKey("Latitude") &&
        host.containsKey("Longitude")) {
      host["Latitude"] =
          double.parse(host["Latitude"].toString());
      host["Longitude"] =
          double.parse(host["Longitude"].toString());
      marker_list = [
        Marker(host["ID"].toString(), host["Name"],
            host["Latitude"], host["Longitude"],
            color: Colors.red),
      ];
      if (hub != null) {
        marker_list.add(new Marker(
            hub["ID"].toString(),
            hub["Name"]??"",
            double.parse(hub["Latitude"].toString()),
            double.parse(hub["Longitude"].toString()),
            color: Colors.blue));
      }
      provider =
          new StaticMapProvider('AIzaSyCA3T4BDdR7Lhiqw1sZT3HBa3AvZJqtnP8');
      uri = provider.getStaticUriWithMarkersAndZoom(
        marker_list,
        center: new Location(
            host["Latitude"], host["Longitude"]),
        zoomLevel: 16,
        width: 900,
        height: 400,
        maptype: StaticMapViewType.roadmap,
      );
    } else {
      uri = null;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startMap();
    getUsers();
  }

  bool is_host(){
    for(int i = 0; i < Global.ac.host_list.length; i++){
      if(host["ID"] == Global.ac.host_list[i]["ID"]) return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: host.isEmpty || users == null
          ? Center(child: CircularProgressIndicator())
          : Content_Section(
              hostID: widget.hostID,
              data: host,
              users: users,
              uri: uri,
              marker_list: marker_list,
              hub: hub,
            ),
            
      floatingActionButton:  is_host()?new FloatingActionButton(
        backgroundColor: Colors.grey,
        child: Icon(Icons.edit),
        onPressed: () async {
          await Global.router.navigateTo(context, "/EditHost/${widget.hostID}",
              transition: TransitionType.native);
              await getHost();
              

        },
      ):Container(),
      bottomNavigationBar: BottomNavigationBarWidget(
        globalKey: kBotBar_host,
      ),
    );
  }
}

class Content_Section extends StatefulWidget {
  final int hostID;
  final Uri uri;
  Map<String, dynamic> data = new Map<String, dynamic>();
  final List<dynamic> users;
  final List<Marker> marker_list;
  final Map<String, dynamic> hub;
  Content_Section({
    Key key,
    this.hostID,
    this.data,
    this.users,
    this.uri,
    this.marker_list,
    this.hub,
  }) : super(key: key);

  @override
  Content_SectionState createState() {
    return new Content_SectionState();
  }
}

class Content_SectionState extends State<Content_Section> {
  GlobalKey<MeetListViewState> keyMeetListView_host =
      new GlobalKey<MeetListViewState>();
  bool isPressed = true;

  void showMap() {
    MapView mapView = new MapView();
    mapView.show(
        new MapOptions(
            mapViewType: MapViewType.normal,
            showUserLocation: true,
            initialCameraPosition: new CameraPosition(
                new Location(widget.data["Latitude"], widget.data["Longitude"]),
                14.0),
            title: "Host"),
        toolbarActions: [new ToolbarAction("Close", 1)]);
    mapView.onToolbarAction.listen((id) {
      if (id == 1) {
        mapView.dismiss();
      }
    });
    mapView.setMarkers(widget.marker_list);
    Timer(Duration(milliseconds: 200), () {
      mapView.zoomToFit(padding: 100);
    });
    mapView.onTouchAnnotation.listen((annotation) {
      mapView.dismiss();
      Global.router.navigateTo(context, "/Hub/${annotation.id}",
          transition: TransitionType.native);
    });
  }

  Future<Null> _launched;

  Future<Null> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    } else {
      showDialog(
          context: context,
          child: AlertDialog(
            content: Text("Failed to access to the website"),
          ));
    }
  }

  Future<Null> _launchTelephone(String telephone) async {
    if (await canLaunch("tel:" + telephone)) {
      await launch("tel:" + telephone);
    } else {
      showDialog(
          context: context,
          child: AlertDialog(
            content: Text("Failed to dial"),
          ));
    }
  }

  Future<Null> _launchEmail(String email) async {
    if (await canLaunch("mailto:" + email)) {
      await launch("mailto:" + email);
    } else {
      showDialog(
          context: context,
          child: AlertDialog(
            content: Text("Failed to dial"),
          ));
    }
  }

  void press() {
    if (this.mounted) {
      setState(() {
        isPressed = !isPressed;
        keyMeetListView_host.currentState.widget.isCurrent =
            !keyMeetListView_host.currentState.widget.isCurrent;
        keyMeetListView_host.currentState.get_meetup_list();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Swiper_Text_Section(
              data: widget.data,
            ),
            widget.users.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 4.0),
                          child: Text(
                            widget.users == null
                                ? ""
                                : widget.users.length.toString(),
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
                  )
                : Container(),
            widget.users.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 10.0),
                    child: Container(
                      height: 67.5,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          // Host(ID: Global.ac.host_ID[0]),
                          Icon_list(
                            users: widget.users,
                          )
                        ],
                      ),
                    ),
                  )
                : Container(),
            Padding(
              padding:
                  const EdgeInsets.only(right: 28.0, left: 28.0, top: 12.0),
              child: Container(
                child: Column(
                  children: <Widget>[
                    // new Tile_Section(
                    //   data:
                    //   widget.data["City"],
                    //   icon: GIcons.book,
                    // ),
                    new Tile_Section(
                      data: widget.data["Name"],
                      icon: GCIcon.book,
                    ),
                    // new Tile_Section(
                    //   data: widget.data["Year"],
                    //   icon: Icons.account_balance,
                    // ),
                    new GestureDetector(
                      onTap: () {
                        _launched =
                            _launchTelephone(widget.data["Phone_Number"]);
                      },
                      child: new Tile_Section(
                        data: widget.data["Phone_Number"],
                        icon: GIcons.phone,
                      ),
                    ),
                    new Tile_Section(
                      data: widget.data["Director"],
                      icon: GIcons.profile,
                    ),
                    new Tile_Section(
                      data: widget.data["Address"],
                      icon: GIcons.location,
                    ),
                    GestureDetector(
                      onTap: () {
                        _launched = _launchEmail(widget.data["Email"]);
                      },
                      child: new Tile_Section(
                        data: widget.data["Email"],
                        icon: GIcons.mail,
                      ),
                    ),
                    // new Tile_Section(
                    //   data: widget.data["Contact_Person"],
                    //   icon: GIcons.profile,
                    // ),
                    GestureDetector(
                      onTap: () {
                        _launched = _launchInBrowser(
                            "http://" + widget.data["Website"]);
                      },
                      child: new Tile_Section(
                        data: widget.data["Website"],
                        icon: GIcons.website,
                      ),
                    ),
                    // new Tile_Section(
                    //   data: widget.data["Number_Members"],
                    //   icon: Icons.group,
                    // ),
                    new Tile_Section(
                      data: widget.data["Activities"],
                      icon: Icons.directions_run,
                    ),
                    new Tile_Section(
                      data: widget.data["Description"],
                      icon: Flutter_0824_icons.doc,
                    ),
                    widget.hub != null
                        ? GestureDetector(
                            onTap: () {
                              Global.router.navigateTo(
                                  context, "/Hub/${widget.hub["ID"]}",
                                  transition: TransitionType.native);
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: Container(
                                    height: 24.0,
                                    width: 24.0,
                                    decoration: widget.hub["LogoUrl"] == null
                                        ? BoxDecoration(
                                            color: Colors.grey,
                                            shape: BoxShape.circle)
                                        : BoxDecoration(
                                            color: Colors.grey,
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image:
                                                    NetworkImage(
                                                        Global.baseUrl +
                                                            widget.hub[
                                                                "LogoUrl"])),
                                          ),
                                  ),
                                ),
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 18.0, right: 18.0),
                                    child: Text(
                                      widget.hub["Name"],
                                      style: TextStyle(
                                          fontFamily: "HelveticaNeue",
                                          color: Color(0xFF606060),
                                          fontSize: 15.0,
                                          height: 1.2),
                                      softWrap: true,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        : Container(),
                    widget.data.isNotEmpty && int.parse(widget.data["User_ID"].toString()) != Global.ac.id
                        ? FullWidthButton(
                            "SEND ENQUIRY TO HOST",
                            color: Colors.grey,
                            onPressed: () {
                              if (widget.data["User_ID"] != Global.ac.id) {
                                Global.router.navigateTo(context,
                                    "/ChatRoom/${widget.data["User_ID"]}",
                                    transition: TransitionType.native);
                              }
                            },
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 50.0, left: 11.0, right: 11.0),
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
                        child: Text(
                          "CURRENT",
                          style: TextStyle(
                              color:
                                  isPressed ? Colors.white : Color(0xFFA2A2A2),
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
                            color:
                                isPressed ? Colors.white : Color(0xFFA2A2A2)),
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
            Container(
                child: MeetListView(
              5,
              hasSearchBar: false,
              canScroll: false,
              isList: false,
              host_ID: widget.hostID,
              isCurrent: isPressed,
              key: keyMeetListView_host,
            )),
            Padding(
              padding:
                  const EdgeInsets.only(left: 10.2, right: 10.2, bottom: 10.0),
              child: GestureDetector(
                onTap: showMap,
                child: Container(
                    height: 250.0,
                    width: MediaQuery.of(context).size.width,
                    child: widget.uri == null
                        ? Image.asset(
                            "images/login_background.jpg",
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            widget.uri.toString(),
                            fit: BoxFit.cover,
                          )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Swiper_Text_Section extends StatefulWidget {
  Map<String, dynamic> data = new Map<String, dynamic>();
  List<dynamic> iconList = new List<dynamic>();
  Swiper_Text_Section({Key key, this.data}) : super(key: key);

  @override
  Swiper_Text_SectionState createState() {
    return new Swiper_Text_SectionState();
  }
}

List<dynamic> toformat(dynamic data){
  if(data != null){
    return jsonDecode(data);
  }else{
    return new List<dynamic>();
  }
}

class Swiper_Text_SectionState extends State<Swiper_Text_Section> {
  DynamicLinkParameters parameters;
  Uri dynamicLink;
  bool isLike = false;

    Future buildUrl(DynamicLinkParameters parameters) async {
    dynamicLink = await parameters.buildUrl();
  }

  @override
  void initState() {
    // TODO: implement initState
    DynamicLinkParameters parameters = new DynamicLinkParameters(
      uriPrefix: 'meets.page.link',
      link: Uri.parse(
          "https://meetus/host?id=" + widget.data["ID"].toString()),
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
    return Stack(
      children: <Widget>[
        Swiper_Section(
          alignment: Alignment.bottomRight,
          iconList: toformat(widget.data["IconUrl"]),
        ),
        Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: Container(
            height: 240.0,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        padding: EdgeInsets.only(right: 9.0),
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
                          Share.share("Check Out " + widget.data["Name"] + "\n" +  dynamicLink.toString(),
                              sharePositionOrigin:
                                  box.localToGlobal(Offset.zero) & box.size);
                        },
                        child: Icon(
                          Flutter_0917_icons.output,
                          color: Colors.white,
                          size: 24.0,
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                      child: Center(
                    child: Text(
                      widget.data["Name"],
                      style: TextStyle(color: Colors.white, fontSize: 28.0),
                    ),
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.8),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        icon: (isLike == true)
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
                        onPressed: () {
                          setState(() {
                            isLike = !isLike;
                          });
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
