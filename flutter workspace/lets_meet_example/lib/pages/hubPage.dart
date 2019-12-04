import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/flutter_advanced_networkimage.dart';
import 'package:lets_meet_flutter/main.dart';
import 'package:lets_meet_flutter/util/Flutter_1101.dart';
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
import 'package:lets_meet_flutter/util/my_flutter_app_icons.dart';
import 'package:lets_meet_flutter/widget.dart';
import 'package:cirrus_map_view/map_view.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_advanced_networkimage/transition_to_image.dart'
    show TransitionToImage;

class HubPage extends StatefulWidget {
  final int hub_id;

  const HubPage({Key key, this.hub_id}) : super(key: key);
  @override
  _HubPageState createState() => _HubPageState();
}

class _HubPageState extends State<HubPage> {
  final GlobalKey kBotBar_hub = new GlobalKey();
  Map<String, dynamic> data;
  Map<String, dynamic> host_data;
  StaticMapProvider provider;
  Uri uri;
  List<Marker> marker_list = [];

  Future getHub() async {
    Response response =
        await Request.getDio().get("hub/get", data: {"ID": widget.hub_id});
    if (response.data["Code"] == 200) {
      if (this.mounted) {
        setState(() {
          data = response.data["Data"];
          if (data.containsKey("IconUrl")) {
            data["IconUrl"] = jsonDecode(data["IconUrl"]);
          }
        });
      }
    }
    marker_list.add(new Marker(
        "1",
        data["Name"],
        double.parse(data["Latitude"].toString()),
        double.parse(data["Longitude"].toString()),
        color: Colors.red));
    if (data["Host_ID"] != null && data["Host_ID"] != -1) {
      Response response_host =
          await Request.getDio().get("host/get", data: {"ID": data["Host_ID"]});
      if (response.data["Code"] == 200) {
        if (this.mounted) {
          setState(() {
            host_data = response_host.data["Data"];
            marker_list.add(new Marker(
                host_data["ID"].toString(),
                host_data["Name"]??"",
                double.parse(host_data["Latitude"].toString()),
                double.parse(host_data["Longitude"].toString()),
                color: Colors.blue));
          });
        }
      }
    }
    provider = new StaticMapProvider('AIzaSyCA3T4BDdR7Lhiqw1sZT3HBa3AvZJqtnP8');
    uri = provider.getStaticUriWithMarkersAndZoom(
      marker_list,
      center: new Location(double.parse(data["Latitude"].toString()),
          double.parse(data["Longitude"].toString())),
      zoomLevel: 16,
      width: 900,
      height: 400,
      maptype: StaticMapViewType.roadmap,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    getHub();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: data != null
          ? SingleChildScrollView(
              child: Stack(
                children: <Widget>[
                  Swiper_Section(
                    alignment: Alignment.bottomRight,
                    iconUrl: data["IconUrl"],
                  ),
                  Content_Section(
                    data: data,
                    uri: uri,
                    marker_list: marker_list,
                    host_data: host_data,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 225.0),
                        child: Container(
                          width: 111.7,
                          height: 111.7,
                          decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                  fit: BoxFit.cover,
                                  image: data.containsKey("LogoUrl")
                                      ? new CachedNetworkImageProvider(
                                          Global.baseUrl + data["LogoUrl"],
                                        )
                                      : AssetImage('images/placeholder.png'))),
                         
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          : Center(child: CircularProgressIndicator()),
      bottomNavigationBar: BottomNavigationBarWidget(
        globalKey: kBotBar_hub,
      ),
    );
  }
}

class Content_Section extends StatelessWidget {
  final Uri uri;
  final Map<String, dynamic> data;
  final List<Marker> marker_list;
  final Map<String, dynamic> host_data;
  const Content_Section({
    Key key,
    this.data,
    this.uri,
    this.marker_list,
    this.host_data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).padding.top,
        ),
        Swiper_Text_Section(hub_data: data,),
        Detail_Section(
          data: data,
          uri: uri,
          marker_list: marker_list,
          host_data: host_data,
        )
      ],
    );
  }
}

class Detail_Section extends StatefulWidget {
  final Map<String, dynamic> data;
  final Uri uri;
  final List<Marker> marker_list;
  final Map<String, dynamic> host_data;
  const Detail_Section({
    Key key,
    this.data,
    this.uri,
    this.marker_list,
    this.host_data,
  }) : super(key: key);

  @override
  Detail_SectionState createState() {
    return new Detail_SectionState();
  }
}

class Detail_SectionState extends State<Detail_Section> {
  void showMap() {
    MapView mapView = new MapView();
    mapView.show(
        new MapOptions(
            mapViewType: MapViewType.normal,
            showUserLocation: true,
            initialCameraPosition: new CameraPosition(
                new Location(double.parse(widget.data["Latitude"].toString()),
                    double.parse(widget.data["Longitude"].toString())),
                14.0),
            title: "Hub"),
        toolbarActions: [new ToolbarAction("Close", 1)]);
    mapView.onToolbarAction.listen((id) {
      if (id == 1) {
        mapView.dismiss();
      }
    });    
    mapView.setMarkers(widget.marker_list);      
    Timer(Duration(milliseconds: 250), (){      
      mapView.zoomToFit(padding:100);      
    });
    mapView.onTouchAnnotation.listen((annotation) {
      print(annotation.id);
      mapView.dismiss();
      Global.router.navigateTo(context, "/Host/${annotation.id}",
          transition: TransitionType.native);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 76.0),
      child: Column(
        children: <Widget>[
          Container(
            child: new Detail_List_Section(
              data: widget.data,
              host_data: widget.host_data,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: GestureDetector(
              onTap: showMap,
              child: Container(
                height: 200.0,
                width: MediaQuery.of(context).size.width,
                child: widget.data.containsKey("Longitude")
                    ? Image.network(
                        widget.uri.toString(),
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        "images/login_background.jpg",
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Detail_List_Section extends StatelessWidget {
  final Map<String, dynamic> data;
  final Map<String, dynamic> host_data;
  const Detail_List_Section({
    Key key,
    this.data,
    this.host_data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 16.0, left: 16.0),
          child: Column(
            children: <Widget>[
              new Tile_Section(
                data: data["Name"],
                icon: GCIcon.hub,
                isRounded: true,
              ),
              new Tile_Section(
                data: data["Location"],
                icon: GIcons.location,
              ),
              new Tile_Section(
                data: data["Open_hour"],
                icon: MyFlutterApp.add____2,
              ),
              new Tile_Section(
                data: data["Price"],
                icon: MyFlutterApp.add____1,
              ),
              new Tile_Section(
                data: data["Contact_Person"],
                icon: GIcons.profile,
              ),
              new Tile_Section(
                data: data["Phone"],
                icon: GIcons.phone,
              ),
              new Tile_Section(
                data: data["Number_Of_Seats"].toString(),
                icon: Flutter_1101.add____7,
                height: 1.5,
              ),
              new Tile_Section(
                data: data["Description"],
                icon: Flutter_0824_icons.doc,
                height: 1.5,
              ),
              host_data != null
                  ? GestureDetector(
                      onTap: () {
                        Global.router.navigateTo(
                            context, "/Host/${host_data["ID"]}",
                            transition: TransitionType.native);
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 25.0,
                            height: 25.0,
                            color: Colors.grey,
                            child: host_data["IconUrl"] != null
                                ? CachedNetworkImage(
                                    imageUrl: Global.baseUrl +
                                        jsonDecode(host_data["IconUrl"])[0],
                                    placeholder: Container(color: Colors.grey),
                                    errorWidget: Image.asset(
                                        "images/login_background.jpg", fit: BoxFit.cover,),
                                    fit: BoxFit.cover,
                                  )
                                : Container(),
                          ),
                          Flexible(
                              child: Padding(
                            padding: const EdgeInsets.only(
                                left: 18.0, right: 18.0, bottom: 20.0),
                            child: Text(
                              host_data["Name"],
                              softWrap: true,
                              style: TextStyle(
                                  fontFamily: "HelveticaNeue",
                                  color: Color(0xFF606060),
                                  fontSize: 15.0,
                                  height: 1.2),
                            ),
                          ))
                        ],
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ],
    );
  }
}

class Swiper_Text_Section extends StatefulWidget {
  final Map<String, dynamic> hub_data;
  const Swiper_Text_Section({
    Key key, this.hub_data,
  }) : super(key: key);

  @override
  Swiper_Text_SectionState createState() {
    return new Swiper_Text_SectionState();
  }
}

class Swiper_Text_SectionState extends State<Swiper_Text_Section> {
  bool isLike = false;
  DynamicLinkParameters parameters;
  Uri dynamicLink;

  Future buildUrl(DynamicLinkParameters parameters) async {
    dynamicLink = await parameters.buildUrl();
  }

  @override
  void initState() {
    // TODO: implement initState
        DynamicLinkParameters parameters = new DynamicLinkParameters(
      domain: 'meets.page.link',
      link: Uri.parse(
          "https://meetus/hub?id=" + widget.hub_data["ID"].toString()),
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
      padding: EdgeInsets.only(right: 4.0),
      child: Container(
        
        height: 240.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                    icon: Icon(
                      Icons.keyboard_arrow_left,
                      color: Colors.white,
                      size: 35.0,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                IconButton(
                  icon: Icon(
                    Flutter_0917_icons.output,
                    size: 24.0,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    final RenderBox box = context.findRenderObject();
                    Share.share("Check Out " + widget.hub_data["Name"] + "\n" + dynamicLink.toString(),
                        sharePositionOrigin:
                            box.localToGlobal(Offset.zero) & box.size);
                  },
                )
              ],
            ),
            Container(
              height: 55.0,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
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
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Swiper_Section extends StatefulWidget {
  final Alignment alignment;
  final List<dynamic> iconUrl;
  const Swiper_Section({
    this.alignment,
    Key key,
    this.iconUrl,
  }) : super(key: key);

  @override
  Swiper_SectionState createState() {
    return new Swiper_SectionState();
  }
}

class Swiper_SectionState extends State<Swiper_Section> {
  @override
  Widget build(BuildContext context) {
    double ww = MediaQuery.of(context).size.width;
    return Container(
      height: 285.0,
      width: ww,
      child: widget.iconUrl == null || widget.iconUrl.length == 1 
          ? Container(
              child: widget.iconUrl == null
                  ? Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image:
                                  AssetImage('images/login_background.jpg'))),
                    )
                  : 
                  GestureDetector(
                      onTap: () {
                        String url =
                            widget.iconUrl[0].toString().replaceFirst("/", "-");
                        print(url);
                        Global.router.navigateTo(context, "/PhotoView/${url}",
                            transition: TransitionType.fadeIn);
                      },
                      child: 
                  TransitionToImage(
                        AdvancedNetworkImage(Global.baseUrl + widget.iconUrl[0]),
                        placeholder: Image.asset('images/login_background.jpg'),
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                      )))
          : Swiper(
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: (){
                    String url =
                        widget.iconUrl[index].toString().replaceFirst("/", "-");
                    print(url);
                    Global.router.navigateTo(context, "/PhotoView/${url}",
                        transition: TransitionType.fadeIn);
                  },
                                  child: FadeInImage.assetNetwork(
                      width: 127.559,
                      height: 127.559,
                      placeholder: 'images/login_background.jpg',
                      image: Global.baseUrl + widget.iconUrl[index],
                      fit: BoxFit.cover),
                );
              },
              itemCount: widget.iconUrl != null ? widget.iconUrl.length : 1,
              pagination: new SwiperPagination(alignment: widget.alignment),
            ),
    );
  }
}
