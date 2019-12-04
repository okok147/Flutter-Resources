import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:google_places_picker/google_places_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lets_meet_flutter/main.dart';
import 'package:lets_meet_flutter/pages/homePage.dart';
import 'package:lets_meet_flutter/pages/loginPage_new.dart';
import 'package:lets_meet_flutter/sampleSearch.dart';
import 'package:lets_meet_flutter/util/Flutter_1101.dart';
import 'package:lets_meet_flutter/util/GIcons.dart';
import 'package:lets_meet_flutter/util/Global.dart';
import 'package:lets_meet_flutter/util/country.dart';
import 'package:lets_meet_flutter/util/flutter_0824_icons.dart';
import 'package:lets_meet_flutter/util/flutter_0917_icons.dart';
import 'package:lets_meet_flutter/util/g_c_icon_icons.dart';
import 'package:lets_meet_flutter/util/my_flutter_app_icons.dart';
import 'package:flutter_advanced_networkimage/flutter_advanced_networkimage.dart';
import 'package:flutter_advanced_networkimage/transition_to_image.dart'
    show TransitionToImage;
import 'package:photo_view/photo_view.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart'
    as datePicker;

class Tile_Section extends StatelessWidget {
  final String data;
  final IconData icon;
  final double height;
  final String title;
  final bool isRounded;

  const Tile_Section({
    Key key,
    this.data,
    this.icon,
    this.height = 1.2,
    this.title: " ",
    this.isRounded: false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // if (icon == GIcons.volunter || icon == GIcons.book || icon == GIcons.meet) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              decoration: isRounded
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(width: 1.0, color: Color(0xFF999999)))
                  : null,
              child: Icon(
                icon,
                color: Color(0xff999999),
                size: (icon == GIcons.volunter ||
                        icon == GIcons.book ||
                        icon == GIcons.meet)
                    ? 24.0
                    : 24.0,
              )),
          Flexible(
              child: Padding(
            padding: const EdgeInsets.only(left: 14.0, right: 18.0),
            child: Text(
              data + title,
              softWrap: true,
              style: TextStyle(
                  fontFamily: "HelveticaNeue",
                  color: Color(0xFF606060),
                  fontSize: 15.0,
                  height: height),
            ),
          ))
        ],
      ),
    );
  }
  // else {
  //   return Padding(
  //     padding: const EdgeInsets.only(bottom: 12.0),
  //     child: Row(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: <Widget>[
  //         Container(
  //           decoration: isRounded
  //               ? BoxDecoration(
  //                   borderRadius: BorderRadius.circular(20.0),
  //                   border: Border.all(width: 1.0, color: Color(0xFF999999)))
  //               : null,
  //           child: Icon(
  //             icon,
  //             color: Color(0xff999999),
  //             size: 24.0,
  //           ),
  //         ),
  //         Flexible(
  //             child: Padding(
  //           padding: const EdgeInsets.only(left: 18.0, right: 18.0),
  //           child: Text(
  //             data + title,
  //             softWrap: true,
  //             style: TextStyle(
  //                 fontFamily: "HelveticaNeue",
  //                 color: Color(0xFF606060),
  //                 fontSize: 15.0,
  //                 height: height),
  //           ),
  //         ))
  //       ],
  //     ),
  //   );
  // }
  // }
}

class Swiper_Section extends StatefulWidget {
  List<dynamic> iconList;
  final int ID;
  final Alignment alignment;
  Swiper_Section({
    this.alignment,
    Key key,
    this.ID,
    @required this.iconList,
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
      child: widget.iconList.length == 0 || widget.iconList.length == 1
          ? Container(
              child: widget.iconList.length == 0
                  ? Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image:
                                  AssetImage('images/login_background.jpg'))),
                    )
                  : GestureDetector(
                      onTap: () {
                        String url = widget.iconList[0]
                            .toString()
                            .replaceFirst("/", "-");
                        print(url);
                        Global.router.navigateTo(context, "/PhotoView/${url}",
                            transition: TransitionType.fadeIn);
                      },
                      child: CachedNetworkImage(
                        imageUrl: Global.baseUrl + widget.iconList[0],
                        placeholder: Container(color: Colors.grey),
                        errorWidget: Image.asset(
                          "images/login_background.jpg",
                          fit: BoxFit.cover,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
            )
          : Swiper(
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    String url = widget.iconList[index]
                        .toString()
                        .replaceFirst("/", "-");
                    print(url);
                    Global.router.navigateTo(context, "/PhotoView/${url}",
                        transition: TransitionType.fadeIn);
                  },
                  child: FadeInImage.assetNetwork(
                      placeholder: 'images/login_background.jpg',
                      image: Global.baseUrl + widget.iconList[index],
                      fit: BoxFit.cover),
                );
              },
              itemCount:
                  widget.iconList.isNotEmpty ? widget.iconList.length : 1,
              pagination: new SwiperPagination(alignment: widget.alignment),
            ),
    );
  }
}

class Detail_List_Section extends StatefulWidget {
  final Map<String, dynamic> data;
  const Detail_List_Section({
    Key key,
    this.data,
  }) : super(key: key);

  @override
  Detail_List_SectionState createState() {
    return new Detail_List_SectionState();
  }
}

String convertWeekday(int weekday) {
  if (weekday == 1) {
    return "Monday";
  } else if (weekday == 2) {
    return "Tuesday";
  } else if (weekday == 3) {
    return "Wednesday";
  } else if (weekday == 4) {
    return "Thursday";
  } else if (weekday == 5) {
    return "Friday";
  } else if (weekday == 6) {
    return "Saturday";
  } else {
    return "Sunday";
  }
}

class Detail_List_SectionState extends State<Detail_List_Section> {
  DateTime start_date;
  DateTime end_date;
  String converted_start_date;
  String converted_end_date;
  // if (response.data["Data"]["Birth"]!=null){
  //     String date =
  //     DateTime.parse(response.data["Data"]["Birth"]).year.toString() +
  //     "-" +
  //     DateTime.parse(response.data["Data"]["Birth"]).month.toString() +
  //     "-" +
  //     DateTime.parse(response.data["Data"]["Birth"]).day.toString();
  //   form.DATA["Birth"] = date;
  // }
  List list_item(Map<String, dynamic> data) {
    List<Widget> list = new List();
    if (data["CategoryID"] == 3 && data["EventName"] != null) {
      list.add(new Tile_Section(
        data: data["EventName"],
        icon: GIcons.volunter,
      ));
    } else if (data["CategoryID"] == 2 && data["EventName"] != null) {
      list.add(new Tile_Section(
        data: data["EventName"],
        icon: GIcons.book,
      ));
    } else if (data["CategoryID"] == 1 && data["EventName"] != null) {
      list.add(new Tile_Section(
        data: data["EventName"],
        icon: GIcons.meet,
      ));
    }
    // if(data["EventName"] != null){
    //   list.add(new Tile_Section(data: data["EventName"], icon: GIcons.volunter,));
    // }
    if (data["Location"] != null) {
      list.add(new Tile_Section(
        data: "Meet at " + data["Location"],
        icon: GCIcon.location,
      ));
    }
    if (data["CategoryID"] == 2) {
      if (data["Hour"] != null) {
        list.add(new Tile_Section(
          data: data["Hour"],
          icon: MyFlutterApp.add____2,
        ));
      }
    } else {
      if (data["MeetDate"] != null) {
        start_date = DateTime.parse(data["MeetDate"]);
        converted_start_date = DateFormat.MMMMd().add_jm().format(start_date);
        list.add(new Tile_Section(
          data: "Starts at " + converted_start_date,
          icon: MyFlutterApp.add____2,
        ));
      }
      if (data["EndDate"] != null && !data["EndDate"].contains("null")) {
        end_date = DateTime.parse(data["EndDate"]);
        converted_end_date = DateFormat.MMMMd().add_jm().format(end_date);
        list.add(new Tile_Section(
            data: "Ends at " + converted_end_date,
            icon: Flutter_1101.add____5));
      }
    }
    if (data["Price"] != null) {
      list.add(new Tile_Section(
        data: data["Price"],
        icon: MyFlutterApp.add____1,
      ));
    }
    if (data["Contact_Person"] != null) {
      list.add(new Tile_Section(
        data: data["Contact_Person"],
        icon: GIcons.profile,
      ));
    }
    if (data["ContactInfo"] != null) {
      list.add(new Tile_Section(
        data: data["ContactInfo"],
        icon: GIcons.phone,
      ));
    }
    if (data["Description"] != null) {
      list.add(new Tile_Section(
        data: data["Description"],
        icon: Flutter_0824_icons.doc,
      ));
    }
    if (data["Seat"] != null) {
      list.add(new Tile_Section(
        data: data["Seat"],
        icon: Flutter_1101.add____7,
      ));
    }
    if (data["Size"] != null) {
      list.add(new Tile_Section(
        data: data["Size"],
        icon: Flutter_1101.add____6,
      ));
    }
    if (data["Capacity"] != null) {
      list.add(new Tile_Section(
        data: data["Capacity"],
        icon: Flutter_0824_icons.group,
      ));
    }
    // if (data["Equipment"] != null) {
    //   list.add(new Tile_Section(
    //     data: data["Equipment"],
    //     icon: Flutter_0824_icons.doc,
    //   ));
    // }
    return list;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    list_item(widget.data);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          // height: 220.0,
          child: Padding(
            padding: const EdgeInsets.only(right: 16.0, left: 16.0, top: 16.0),
            child: Column(
              children: <Widget>[
                Column(children: list_item(widget.data)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class MeetListView extends StatefulWidget {
  final bool isList;
  final bool showLike;
  final int index;
  final bool canEdit;
  final bool hasSearchBar;
  final bool canScroll;
  final int host_ID;
  bool isCurrent;
  bool isSaved;
  final String search_bar_text;
  MeetListView(
    this.index, {
    Key key,
    this.showLike: true,
    this.isList = true,
    this.canEdit = true,
    this.hasSearchBar = true,
    this.canScroll = true,
    this.host_ID = 0,
    this.isCurrent,
    this.search_bar_text,
    this.isSaved,
  }) : super(key: key);

  @override
  MeetListViewState createState() => MeetListViewState();
}

class MeetListViewState extends State<MeetListView> {
    dynamic data;
  Future<Null> get_meetup_list() async {
    if (widget.host_ID == 0 && widget.index != 6) {
      var response = await Request.getDio()
          .get("meet/get_list", data: {"index": widget.index});
      data = response.data["Data"];
    } else if (widget.index == 6) {
      var response = await Request.getDio().get("meet/get_list", data: {
        "index": widget.index,
        "Host_ID": widget.host_ID,
        "isSaved": widget.isSaved
      });
      data = response.data["Data"];
    } else {
      var response = await Request.getDio().get("meet/get_list", data: {
        "index": widget.index,
        "Host_ID": widget.host_ID,
        "isCurrent": widget.isCurrent
      });
      data = response.data["Data"];
    }
    // print("Meet list request ${response.data['Data']}");
    if (this.mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    Global.removeRenewListener("meetList", get_meetup_list);
    super.dispose();
  }
  @override
  void initState() {
    get_meetup_list();
    Global.addRenewListener("meetList", get_meetup_list);
    super.initState();
  }
  


  @override
  Widget build(BuildContext context) {
    // get_meetup_list();
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Theme(
        data: widget.canEdit == true
            ? Theme.of(context).copyWith(splashColor: Colors.black)
            : Theme.of(context).copyWith(splashColor: Colors.white),
        child: data == null
            ? Center(child: CircularProgressIndicator())
            : Container(
                child: Column(
                  children: <Widget>[
                    widget.hasSearchBar
                        ? Search_Bar("${widget.search_bar_text}")
                        : Container(),
                    widget.isList
                        ? Expanded(
                            child: Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                            child: ListView(
                              physics: widget.canScroll == true
                                  ? BouncingScrollPhysics()
                                  : NeverScrollableScrollPhysics(),
                              children: (data as List)
                                  .map((f) => MeetSlider(f))
                                  .toList(),
                            ),
                          ))
                        : Container(
                            child: Column(
                              children: (data as List)
                                  .map((f) => MeetSlider(f))
                                  .toList(),
                            ),
                          ),
                  ],
                ),
              ),
      ),
    );
  }
}

class MeetSlider extends StatefulWidget {
  final List data;
  const MeetSlider(this.data, {Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _MeetSlider();
}

class _MeetSlider extends State<MeetSlider> {
  String typeName = "";
  int create_ID;
  @override
  void dispose() {
    // TODO: implement dispose
    // listController.dispose();
    super.dispose();
  }

  void check_create_ID(typeName) {
    if (typeName == "meet") {
      create_ID = 1;
    } else if (typeName == "book") {
      create_ID = 2;
    } else if (typeName == "volunteer") {
      create_ID = 3;
    }
  }

  @override
  void initState() {
    typeName = widget.data[0]['Type_Name'];
    check_create_ID(typeName);
    super.initState();
  }

  List<Widget> getMeetList(bool display) {
    List<Widget> a = new List();

    a = widget.data
        .where((f) => f["ID"] != null)
        .map((f) => MeetCard(f))
        .toList();

    if (display == true) {
      a.insert(
          0,
          MeetCard(
            null,
            create_ID: create_ID,
          )); // TODO yum9
    }
    //print("a is $a");
    return a;
  }

  @override
  Widget build(BuildContext context) {
    bool display = Theme.of(context).splashColor == Colors.white;
    // if(display == true){
    //   List<String> default_type_name = new List();
    //   default_type_name.add("Meet");
    //   default_type_name.add("Book");
    //   default_type_name.add("Volunteer");
    // }
    return Container(
      margin: EdgeInsets.only(bottom: 28.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: Text(widget.data[0]['Type_Name'],
                style: Global.stlye_sliderTitle),
          ),
          Container(
            height: 127.0,
            child: new ListView(
              scrollDirection: Axis.horizontal,
              children: getMeetList(display),
            ),
          )
        ],
      ),
    );
  }
}

class MeetCard extends StatefulWidget {
  final Map<String, dynamic> data;
  final int create_ID;

  const MeetCard(this.data, {Key key, this.create_ID}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _MeetCard();
}

class _MeetCard extends State<MeetCard> {
  DateTime raw_date;
  DateTime end_time;
  String date;
  String time;
  bool isLiked;
  List<dynamic> icon_list = [];
  // List colors = [Color(0xffb89780).withOpacity(0.5), Color(0xff4F37BC).withOpacity(0.5), Color(0xffea6a3d).withOpacity(0.5), Color(0xff59a16a).withOpacity(0.5), Color(0xff11a9aa).withOpacity(0.5), Color(0xff336244).withOpacity(0.5), Color(0xffeb4b4b).withOpacity(0.5), Color(0xffd9c343).withOpacity(0.5), Color(0xff42147a).withOpacity(0.5), Color(0xffe0955d).withOpacity(0.5), Color(0xffbc63b4).withOpacity(0.5), Color(0xff7fbb6d).withOpacity(0.5), Color(0xff7074d0).withOpacity(0.5), Color(0xff4dbee8).withOpacity(0.5), Color(0xffc1db6d).withOpacity(0.5), Color(0xffec6e76).withOpacity(0.5), Color(0xff7b6352).withOpacity(0.5), Color(0xff001ea9).withOpacity(0.5), Color(0xff69a5e6).withOpacity(0.5), Color(0xff2a5e8f).withOpacity(0.5), Color(0xffba7549).withOpacity(0.5)];
  Random random = new Random();

  void _showToast(BuildContext context, String text) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(text),
        duration: new Duration(milliseconds: 500),
      ),
    );
  }

  Future<Null> joinMeetup() async {
    var response = await Request.getDio()
        .post("me/meetup/join", data: {"MeetupID": widget.data["ID"]});
    await getUser();
    if (response.data["Code"] == 200) {
      Global.router.navigateTo(context, "/Event/${widget.data["ID"]}",
          transition: TransitionType.native);
    }
    if (this.mounted) {
      setState(() {});
      if (checkJoinedList()) {
        _showToast(context, "You have joined that meetup");
      } else {
        _showToast(context, "You have left that meetup");
      }
    }
  }

  bool checkJoinedList() {
    if (Global.ac.joined_list.contains(widget.data["ID"]) == true) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    if (widget.data != null) {
      if (widget.data["CategoryID"] != 2) {
        raw_date = DateTime.parse(widget.data['MeetDate']);
        end_time = DateTime.parse(widget.data['EndDate']);
        date = DateFormat.MMMMd().format(raw_date);
        time = DateFormat.jm().format(raw_date) +
            "-" +
            DateFormat.jm().format(end_time);
        time = time
            .replaceAll("AM", "am")
            .replaceAll("PM", "pm")
            .replaceAll(" ", "");
      }
    }
    changeIndex();

    print(widget.data);

    super.initState();
  }

  int color_index = 0;
  void changeIndex() {
    if (this.mounted) {
      setState(() => color_index = random.nextInt(21));
    }
  }

  bool checkLiked(liked_array) {
    if (widget.data != null) {
      if (liked_array.contains(widget.data["ID"])) {
        isLiked = true;
      } else {
        isLiked = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    checkLiked(Global.ac.liked_list);
    bool display = Theme.of(context).splashColor == Colors.white;
    // change_color();
    return Padding(
        padding: const EdgeInsets.only(right: 9.0),
        child: PhysicalModel(
          color: Colors.grey,
          child: GestureDetector(
            onTap: () async {
              if (widget.data != null) {
                await Global.router.navigateTo(
                    context, "/Event/${widget.data["ID"]}",
                    transition: TransitionType.native);
                // await getUser();
                if (Global.kMeetListViewSearch_meet.currentState != null &&
                    Global.kMeetListViewSearch_meet.currentState.mounted) {
                  Global.kMeetListViewSearch_meet.currentState.setState(() {});
                }

                if (Global.kMeetListViewSearch_book.currentState != null &&
                    Global.kMeetListViewSearch_book.currentState.mounted) {
                  Global.kMeetListViewSearch_book.currentState.setState(() {});
                }

                if (Global.kMeetListViewSearch_volunteer.currentState != null &&
                    Global.kMeetListViewSearch_volunteer.currentState.mounted) {
                  Global.kMeetListViewSearch_volunteer.currentState
                      .setState(() {});
                }
              } else {
                await Global.router.navigateTo(
                    context, "/Create/${widget.create_ID}",
                    transition: TransitionType.native);     
                    Global.callRenewListener("meetList");
              }
            },
            child: FlatButton(
              padding: EdgeInsets.all(0.0),
              child: Container(
                width: 127.559,
                height: 127.559,
                child: Stack(
                  children: <Widget>[
                    widget.data != null
                        ? Container(
                            width: 127.559,
                            height: 127.559,
                            decoration: widget.data.containsKey("IconUrl")
                                ? BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AdvancedNetworkImage(
                                          Global.baseUrl +
                                              jsonDecode(
                                                  widget.data["IconUrl"])[0] +
                                              "?tn=200"),
                                    ),
                                  )
                                : null,
                          )
                        : Container(
                            height: 127.559,
                            width: 127.559,
                          ),
                    Container(
                      width: 127.559,
                      height: 127.559,
                      color: widget.data != null &&
                              widget.data["Color_Code"] != null
                          ? widget.data["Approval"] == "Approve"
                              ? widget.data["IconUrl"] == null
                                  ? Color(int.parse(
                                      "0xff" + widget.data["Color_Code"]))
                                  : Color(int.parse(
                                          "0xff" + widget.data["Color_Code"]))
                                      .withOpacity(0.5)
                              : Colors.grey[500]
                          : Global.colors[color_index],
                      child: widget.data != null && widget.data["ID"] != null
                          ? Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                        Expanded(
                                          child: Text(
                                            widget.data['EventName'],
                                            style: widget.data["Approval"] ==
                                                    "Approve"
                                                ? Global.stlye_title
                                                : Global
                                                    .stlye_title_not_approve,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Text(widget.data['Location'],
                                            maxLines: 5,
                                            style: widget.data["Approval"] ==
                                                    "Approve"
                                                ? Global.stlye_subTitle
                                                : Global
                                                    .stlye_subTitle_not_approve),
                                        widget.data["CategoryID"] != 2
                                            ? widget.data["Approval"] ==
                                                    "Approve"
                                                ? Text(date,
                                                    style:
                                                        Global.stlye_subTitle)
                                                : Text(date,
                                                    style: Global
                                                        .stlye_subTitle_not_approve)
                                            : Container(),
                                        widget.data["CategoryID"] != 2
                                            ? widget.data["Approval"] ==
                                                    "Approve"
                                                ? Text(time,
                                                    style: Global
                                                        .stlye_subTitle_time)
                                                : Text(time,
                                                    style: Global
                                                        .stlye_subTitle_time_not_approve)
                                            : Container(),
                                      ])),
                                  Container(
                                    width: 40.0,
                                    child: Offstage(
                                        offstage: display,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            GestureDetector(
                                              onTap: () async {
                                                await Request.getDio().patch(
                                                    "meetup/like",
                                                    data: {
                                                      "Meetup_ID":
                                                          widget.data["ID"]
                                                    });
                                                await getUser();
                                                if (this.mounted) {
                                                  setState(() {
                                                    checkLiked(
                                                        Global.ac.liked_list);
                                                  });
                                                  if (isLiked == true) {
                                                    _showToast(context,
                                                        "Add to favourites");
                                                  } else {
                                                    _showToast(context,
                                                        "Cancel from favourites");
                                                  }
                                                }
                                              },
                                              child: AbsorbPointer(
                                                child: Container(
                                                  height: 50.0,
                                                  width: 50.0,
                                                  padding: EdgeInsets.all(0.0),
                                                  alignment: Alignment.topRight,
                                                  child: new Icon(
                                                    isLiked == true
                                                        ? Icons.star
                                                        : Icons.star_border,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(),
                                            ),
                                            GestureDetector(
                                              onTap: () async {
                                                await joinMeetup();
                                                await getUser();
                                              },
                                              child: AbsorbPointer(
                                                child: Container(
                                                  height: 50.0,
                                                  alignment:
                                                      Alignment.bottomRight,
                                                  padding: EdgeInsets.all(0.0),
                                                  child: widget.data[
                                                              "CategoryID"] !=
                                                          2
                                                      ? checkJoinedList()
                                                          ? Icon(
                                                              Icons.add_circle,
                                                              color:
                                                                  Colors.white)
                                                          : Icon(
                                                              Icons
                                                                  .add_circle_outline,
                                                              color:
                                                                  Colors.white)
                                                      : Container(),
                                                ),
                                              ),
                                            )
                                          ],
                                        )),
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                    ),
                    Center(
                      child: widget.data == null
                          ? Icon(
                              Icons.add,
                              size: 96.0,
                              color: Colors.white,
                            )
                          : Container(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

class Icon_Section extends StatefulWidget {
  final Map user;
  Icon_Section({
    Key key,
    this.user,
  }) : super(key: key);

  @override
  Icon_SectionState createState() {
    return new Icon_SectionState();
  }
}

class Icon_SectionState extends State<Icon_Section> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: GestureDetector(
        onTap: () {
          if (widget.user["ID"] != Global.ac.id) {
            Global.router.navigateTo(
                context, "/ProfileView/${widget.user["ID"]}",
                transition: TransitionType.fadeIn);
          }
          ;
        },
        child: AbsorbPointer(
          child: Container(
            child: Column(
              children: <Widget>[
                widget.user["IconUrl"] != null
                    ? Container(
                        width: 50.6,
                        height: 48.4,
                        decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: CachedNetworkImageProvider(
                                    Global.baseUrl +
                                        widget.user["IconUrl"] +
                                        "?tn=102"))),
                      )
                    : Container(
                        width: 50.6,
                        height: 48.4,
                        decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage('images/placeholder.png')))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Icon_list extends StatefulWidget {
  final List<dynamic> users;

  Icon_list({Key key, this.users}) : super(key: key);
  @override
  _Icon_listState createState() => _Icon_listState();
}

class _Icon_listState extends State<Icon_list> {
  List<Widget> icons = <Widget>[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    icons = <Widget>[];
    if (widget.users.length >= 0) {
      for (int i = 0; i < widget.users.length; i++) {
        icons.add(new Icon_Section(
          user: widget.users[i],
        ));
      }
    }

    return Row(children: icons);
  }
}

class Host extends StatefulWidget {
  final int ID;
  const Host({
    Key key,
    this.ID,
  }) : super(key: key);

  @override
  HostState createState() {
    return new HostState();
  }
}

class HostState extends State<Host> {
  Map<String, dynamic> data = new Map<String, dynamic>();

  Future<Null> getData() async {
    var response =
        await Request.getDio().get("host/get", data: {"ID": widget.ID});
    if (response.data["Code"] == 200) {
      data = response.data["Data"];
      print(response.data["Data"]);
    }
    if (this.mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return data["Name"] == null
        ? Container()
        : Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: InkWell(
              onTap: () {
                Global.router.navigateTo(context, "/Host/${widget.ID}",
                    transition: TransitionType.native);
              },
              child: Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                          width: 46.5,
                          height: 46.5,
                          child: data["IconUrl"] != null
                              ? CachedNetworkImage(
                                  imageUrl: Global.baseUrl +
                                      jsonDecode(data["IconUrl"])[0],
                                  placeholder: Container(color: Colors.grey),
                                  errorWidget: Image.asset(
                                    "images/login_background.jpg",
                                    fit: BoxFit.cover,
                                  ),
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  "images/login_background.jpg",
                                  fit: BoxFit.cover,
                                )),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          // data==null?"HOST":data["Name"],
                          "Host",
                          style: TextStyle(
                              fontSize: 12.0,
                              fontFamily: "HelveticaNeue",
                              color: Color(0xFFA2A1A1)),
                        ),
                      )
                    ],
                  ),
                  Container(
                    width: 46.5,
                    height: 46.5,
                    alignment: Alignment.center,
                    child: Text(
                      data["Name"],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "HelveticaNeue",
                          fontSize: 8.0),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}

class BottomNavigationBarWidget extends StatefulWidget {
  GlobalKey globalKey;
  BottomNavigationBarWidget({Key key, @required this.globalKey})
      : super(key: key);

  @override
  BottomNavigationBarWidgetState createState() {
    return new BottomNavigationBarWidgetState();
  }
}

class BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  void tapedbar(int n) {
    if (this.mounted) {
      if (n >= 0 && n <= 4) {
        setState(() {
          Global.index = n;
          HomePage h = Global.kHomePage.currentWidget;
          h.setPage(n);
          while (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
          // Global.router.navigateTo(context, "/", transition: TransitionType.fadeIn, replace: true);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        canvasColor: Colors.white,
        //  accentColor: Color(0xFF999999),
        disabledColor: Color(0xFF999999),
        //   buttonColor: Color(0xFF999999), bottomAppBarColor: Color(0xFF999999),
        // toggleableActiveColor: Color(0xFF4F5A9C)
      ),
      child: IconTheme(
        data: IconThemeData(size: 30.0),
        child: BottomNavigationBar(
          key: widget.globalKey,
          type: BottomNavigationBarType.fixed,
          onTap: tapedbar,
          currentIndex:
              Global.index, // this will be set when a new tab is tapped
          fixedColor: Color(0xFF4F5A9C),
          items: [
            BottomNavigationBarItem(
              icon: Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(
                          width: 1.0,
                          color: Global.index == 0
                              ? Color(0xFF4F5A9C)
                              : Color(0xFF999999))),
                  child: Icon(
                    GCIcon.hub,
                    size: 35.0,
                  )),
              title: new Container(height: 0.0),
            ),
            BottomNavigationBarItem(
                activeIcon: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 2.0,
                    ),
                    new Icon(
                      GCIcon.volunter,
                      size: 30.0,
                    ),
                    Text(
                      'volunteer',
                      style: Global.style_bottomBarActive,
                    )
                  ],
                ),
                icon: Column(
                  children: <Widget>[
                    new Icon(
                      GCIcon.volunter,
                      size: 30.0,
                    ),
                    Text('volunteer', style: Global.style_bottomBar)
                  ],
                ),
                title: Container()),
            BottomNavigationBarItem(
              activeIcon: Column(
                children: <Widget>[
                  SizedBox(
                    height: 2.0,
                  ),
                  new Icon(
                    GCIcon.meet,
                    size: 30.0,
                  ),
                  Text(
                    'meet',
                    style: Global.style_bottomBarActive,
                  )
                ],
              ),
              icon: Column(
                children: <Widget>[
                  new Icon(
                    GCIcon.meet,
                    size: 30.0,
                  ),
                  Text('meet', style: Global.style_bottomBar)
                ],
              ),
              title: Container(),
            ),
            BottomNavigationBarItem(
              activeIcon: Column(
                children: <Widget>[
                  SizedBox(
                    height: 2.0,
                  ),
                  new Icon(
                    GCIcon.book,
                    size: 30.0,
                  ),
                  Text('book', style: Global.style_bottomBarActive)
                ],
              ),
              icon: Column(
                children: <Widget>[
                  new Icon(
                    GCIcon.book,
                    size: 30.0,
                  ),
                  Text('book', style: Global.style_bottomBar)
                ],
              ),
              title: Container(),
            ),
            BottomNavigationBarItem(
                icon: Container(
                    width: 40.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                            width: 1.0,
                            color: Global.index == 4
                                ? Color(0xFF4F5A9C)
                                : Color(0xFF999999))),
                    child: Icon(
                      GCIcon.profile,
                      size: 17.0,
                    )),
                title: new Container(height: 0.0))
          ],
        ),
      ),
    );
  }
}

class Create_Upload extends StatefulWidget {
  final String title;
  final IconData icon;
  final String tag;
  final CreateForm src;
  final int max_number;
  final bool isCompulsory;

  const Create_Upload({
    Key key,
    this.title,
    this.icon,
    this.src,
    this.tag,
    this.max_number = 4,
    this.isCompulsory,
  }) : super(key: key);

  @override
  Create_UploadState createState() {
    return new Create_UploadState();
  }
}

class Create_UploadState extends State<Create_Upload> {
  File _image;
  List<dynamic> image_list = [];
  List<Widget> widget_list = [];

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    _image = image;
    if (_image != null) {
      image_list.add(_image);
      widget_list = widget_list.where((i) => i is Image_Section).toList();
      widget_list.add(new Image_Section(
        image: _image,
        parent: this,
      ));
      if (widget_list.length < widget.max_number) {
        widget_list.add(new Default_Image_Section(
          onTap: getImage,
        ));
      }
      if (this.mounted) {
        setState(() {});
      }
    }
    print(widget.src.DATA);
    widget.src.DATA[widget.tag] = image_list;
    print(_image);

    // uploadPhoto();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Create_Title(
              title: widget.title,
              icon: widget.icon,
              isCompulsory: widget.isCompulsory,
            )),
        Padding(
          padding: const EdgeInsets.only(left: 32.0, bottom: 44.0),
          child: widget_list.isEmpty
              ? new Default_Image_Section(
                  onTap: getImage,
                )
              : Column(
                  children: widget_list,
                  // child: Container(height: 144.0, width: MediaQuery.of(context).size.width, child: Image.asset(_image.path, fit: BoxFit.cover,))
                ),
        )
      ],
    );
  }
}

class Default_Image_Section extends StatefulWidget {
  final VoidCallback onTap;
  const Default_Image_Section({
    Key key,
    this.onTap,
  }) : super(key: key);

  @override
  Default_Image_SectionState createState() {
    return new Default_Image_SectionState();
  }
}

class Default_Image_SectionState extends State<Default_Image_Section> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
          color: Color(0xffe5e5e5),
          height: 144.0,
          width: MediaQuery.of(context).size.width,
          child: Icon(Icons.add, size: 96.0, color: Colors.white)),
    );
  }
}

class Image_Section extends StatefulWidget {
  File image;
  Create_UploadState parent;
  Image_Section({
    Key key,
    @required File this.image,
    @required Create_UploadState this.parent,
  }) : super(key: key);

  @override
  Image_SectionState createState() {
    return new Image_SectionState();
  }
}

class Image_SectionState extends State<Image_Section> {
  int index_of_widget;
  int index_of_image;

  void delete_current_picture() {
    index_of_widget = widget.parent.widget_list.indexOf(widget);
    index_of_image = widget.parent.image_list.indexOf(widget.image);
    if (widget.parent.mounted) {
      widget.parent.setState(() {
        widget.parent.widget_list.removeAt(index_of_widget);
        widget.parent.image_list.removeAt(index_of_image);
        if (!(widget.parent.widget_list.last is Default_Image_Section)) {
          widget.parent.widget_list.add(new Default_Image_Section(
            onTap: widget.parent.getImage,
          ));
        }
      });
    }
  }

  Future<File> _cropImage(File imageFile) async {
    File croppedFile = await ImageCropper.cropImage(
      sourcePath: imageFile.path,
      ratioX: 1.0,
      ratioY: 1.0,
      toolbarTitle: 'Cropper',
      toolbarColor: Colors.blue,
    );
    if (croppedFile != null) {
      widget.parent.setState(() {
        imageFile = croppedFile;
      });
    }
    return imageFile;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              child: SimpleDialog(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () async {
                        index_of_image =
                            widget.parent.image_list.indexOf(widget.image);
                        index_of_widget =
                            widget.parent.widget_list.indexOf(widget);
                        File cropped_image = await _cropImage(
                            widget.parent.image_list[index_of_image]);
                        widget.parent.setState(() {
                          widget.parent.image_list[index_of_image] =
                              cropped_image;
                          setState(() {
                            widget.image = cropped_image;
                          });
                        });
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        height: 150.0,
                        width: 100.0,
                        child: Column(
                          children: <Widget>[
                            Icon(
                              Icons.image,
                              size: 100.0,
                            ),
                            Text("Crop Image")
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        delete_current_picture();
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        height: 150.0,
                        width: 100.0,
                        child: Column(
                          children: <Widget>[
                            Icon(
                              Icons.cancel,
                              size: 100.0,
                            ),
                            Text("Delete")
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ));
        },
        child: Container(
            height: 144.0,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              widget.image.path,
              fit: BoxFit.cover,
            )),
      ),
    );
  }
}

class Create_TimePicker extends StatefulWidget {
  final String title;
  final String hint_text;
  final IconData icon;
  final String tag;
  final CreateForm src;
  final String initialValue;
  final bool isCompulsory;
  String data;
  Create_TimePicker(
      {Key key,
      this.title,
      this.hint_text,
      this.icon,
      this.src,
      this.data,
      this.tag,
      this.isCompulsory,
      this.initialValue})
      : super(key: key);

  @override
  Create_TimePickerState createState() {
    return new Create_TimePickerState();
  }
}

class Create_TimePickerState extends State<Create_TimePicker> {
  TextEditingController _textEditingController = new TextEditingController();
  TimeOfDay _time;
  int hour;
  int minute;
  // String hourShowed;
  // String minuteShowed;
  String timeShowed;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    timeShowed = widget.initialValue;
    _textEditingController.text =
        widget.initialValue == null ? null : widget.initialValue;
  }

  void _showTimePicker() {
    DateTime now = new DateTime.now();
    datePicker.DatePicker.showTimePicker(context, showTitleActions: true,
        onConfirm: (date) {
      setValue(date.hour, date.minute);
    },
        currentTime: DateTime(
            now.year, now.month, now.day, now.hour, now.minute, now.second));
  }

  String plus_zero(int number) {
    String convertedData;
    if (number < 10) {
      convertedData = "0" + number.toString();
    } else {
      convertedData = number.toString();
    }
    return convertedData;
  }

  void setValue(int hour, int minute) {
    if (this.mounted) {
      setState(() {
        timeShowed = plus_zero(hour).toString() + ":" + plus_zero(minute);
        widget.src.DATA[widget.tag] = timeShowed;
        _textEditingController.text = timeShowed;
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 44.0),
      child: Column(
        children: <Widget>[
          new Create_Title(
            title: widget.title,
            icon: widget.icon,
            isCompulsory: widget.isCompulsory,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 32.0),
            child: GestureDetector(
              onTap: _showTimePicker,
              child: AbsorbPointer(
                child: TextFormField(
                  controller: _textEditingController,
                  // initialValue: widget.initialValue == null?null:widget.initialValue,
                  autocorrect: false,
                  decoration: InputDecoration(
                    hintText: widget.hint_text,
                    hintStyle: Global.create_hint,
                    // labelText: timeShowed == null ? null : timeShowed
                  ),
                  validator: (value) {
                    if (timeShowed == null) {
                      return " ";
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Create_DatePicker extends StatefulWidget {
  final String title;
  final String hint_text;
  final IconData icon;
  final String tag;
  final CreateForm src;
  final bool isCompulsory;
  final String initialValue;
  String data;
  Create_DatePicker({
    Key key,
    this.title,
    this.hint_text,
    this.icon,
    this.src,
    this.data,
    this.tag,
    this.isCompulsory,
    this.initialValue,
  }) : super(key: key);

  @override
  Create_DatePickerState createState() {
    return new Create_DatePickerState();
  }
}

class Create_DatePickerState extends State<Create_DatePicker> {
  TextEditingController _textEditingController = new TextEditingController();
  DateTime _dateTime = DateTime.now();
  String _dateShowed;
  int month;
  String monthCoverted;
  int year;
  int day;
  String monthData;
  String dayData;
  String data;
  void _showDatePicker() {
    // _selectDate(context);
    DateTime now = new DateTime.now();
    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      locale: 'en',
      minYear: 1970,
      maxYear: 2020,
      initialYear: now.year,
      initialMonth: now.month,
      initialDate: now.day,
      cancel: Text('Cancel'),
      confirm: Text('Confirm'),
      dateFormat: 'yyyy-mmmm-dd',
      onChanged: (year, month, date) {},
      onConfirm: (year, month, date) {
        setValue(year, month, date);
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textEditingController.text = widget.initialValue == null ? null : widget.initialValue;
    if( widget.initialValue != null) {
      DateTime date = DateTime.parse( _textEditingController.text);
      String year = date.year.toString();
      String month = plus_zero(date.month);
      String day = plus_zero(date.day);
      _dateShowed = year + "-" + month + "-" + day;
      print(_dateShowed);
    }
  }

  void setValue(year, month, date) {
    setState(() {
      date = plus_zero(date);
      month = plus_zero(month);
      _dateShowed =
          year.toString() + "-" + month.toString() + "-" + date.toString();
      widget.src.DATA[widget.tag] = _dateShowed;
      _textEditingController.text = _dateShowed;
    });
  }

  String plus_zero(int number) {
    String convertedData;
    if (number < 10) {
      convertedData = "0" + number.toString();
    } else {
      convertedData = number.toString();
    }
    return convertedData;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 44.0),
      child: Column(
        children: <Widget>[
          new Create_Title(
            title: widget.title,
            icon: widget.icon,
            isCompulsory: widget.isCompulsory,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 32.0),
            child: GestureDetector(
              onTap: _showDatePicker,
              child: AbsorbPointer(
                child: TextFormField(
                  autocorrect: false,
                  controller: _textEditingController,
                  decoration: InputDecoration(
                    hintText: widget.hint_text,
                    hintStyle: Global.create_hint,
                  ),
                  validator: (value) {
                    if (_dateShowed == null) {
                      return " ";
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Create_Google_Map_Picker extends StatefulWidget {
  final String title;
  final String hint_text;
  final IconData icon;
  final String tag;
  final CreateForm src;
  final bool isCompulsory;
  String data;

  Create_Google_Map_Picker(
      {Key key,
      @required this.title,
      this.hint_text,
      this.icon,
      this.tag,
      @required this.src,
      this.data,
      this.isCompulsory})
      : super(key: key);
  @override
  _Create_Google_Map_PickerState createState() =>
      _Create_Google_Map_PickerState();
}

class _Create_Google_Map_PickerState extends State<Create_Google_Map_Picker> {
  TextEditingController _textEditingController = new TextEditingController();
  TextEditingController _specificTextEditingController = new TextEditingController();
  
  showPlacePicker() async {
    try {
      var place = await PluginGooglePlacePicker.showPlacePicker();
      // print("place is $place");
      if (!mounted) return;
      if (place != null) {
        setState(() {
          setValue(place.address, place.longitude, place.latitude);
        });
      }
    } catch (e) {}
  }

  void setValue(String s, [double longitude, double latitude]) {
    if (this.mounted) {
      if (widget.tag != null) {
        _textEditingController.text = s;
        widget.src.DATA[widget.tag] = s;
      }
      if (longitude != null) widget.src.DATA["Longitude"] = longitude;
      if (latitude != null) widget.src.DATA["Latitude"] = latitude;
      setState(() {
        widget.data = s.toString();
      });
    }
  }

    void setValue_specific(String s, [double longitude, double latitude]) {
    if (this.mounted) {
      if (widget.tag != null) {
        _specificTextEditingController.text = s;
        widget.src.DATA[widget.tag] = _textEditingController.text + " " + _specificTextEditingController.text;
      }
      if (longitude != null) widget.src.DATA["Longitude"] = longitude;
      if (latitude != null) widget.src.DATA["Latitude"] = latitude;
      setState(() {
        widget.data = s.toString();
      });
    }
  }

  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      _textEditingController.text = widget.src.DATA[widget.tag] ;
    }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 44.0),
      child: Column(
        children: <Widget>[
          new Create_Title(
            title: widget.title,
            icon: widget.icon,
            isCompulsory: widget.isCompulsory,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 32.0),
            child: Column(
              children: <Widget>[
                FullWidthButton(
                  "Open Picker",
                  onPressed: showPlacePicker,
                ),
                TextFormField(
                  autocorrect: false,
                  onFieldSubmitted: (text) {
                    setValue(text);
                  },
                  controller: _textEditingController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    contentPadding: new EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                    hintText: widget.hint_text,
                    hintStyle: Global.create_hint,
                  ),
                  validator: (value) {
                    if (widget.isCompulsory == true && value.isEmpty) {
                      return ' ';
                    }
                    setValue(value);
                  },
                ),
                TextFormField(
                  autocorrect: false,
                  onFieldSubmitted: (text) {
                    setValue_specific(text);
                  },
                  controller: _specificTextEditingController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    contentPadding: new EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                    hintText: widget.hint_text,
                    hintStyle: Global.create_hint,
                  ),
                  validator: (value) {
                    // if (widget.isCompulsory == true && value.isEmpty) {
                    //   return ' ';
                    // }
                    setValue_specific(value);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Create_Input extends StatefulWidget {
  final String title;
  final String hint_text;
  final IconData icon;
  final String tag;
  final CreateForm src;
  final TextInputType textInputType;
  final bool isCompulsory;
  String data;
  Create_Input({
    Key key,
    this.title,
    this.hint_text,
    this.icon,
    this.src,
    this.data,
    this.tag,
    this.textInputType = TextInputType.text,
    this.isCompulsory,
  }) : super(key: key);

  @override
  Create_InputState createState() {
    return new Create_InputState();
  }
}

class Create_InputState extends State<Create_Input> {
  TextEditingController _textEditingController;
  void setValue(dynamic s) {
    if (this.mounted) {
      widget.src.DATA[widget.tag] = s.toString();
      setState(() {
        widget.data = s.toString();
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.src.DATA[widget.tag]);
    _textEditingController = new TextEditingController();
    if (widget.src.DATA.containsKey(widget.tag)) {
      _textEditingController.text = widget.src.DATA[widget.tag];
    }
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 44.0),
      child: Column(
        children: <Widget>[
          new Create_Title(
            title: widget.title,
            icon: widget.icon,
            isCompulsory: widget.isCompulsory,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 32.0),
            child: TextFormField(
              autocorrect: false,
              onEditingComplete: (){                
                  widget.src.DATA[widget.tag] = _textEditingController.text;
                  print(widget.src.DATA);
              },
              onSaved: (s){
                setValue(s);
              },
              onFieldSubmitted: (text) {
                
                setValue(text);
              },
              controller: _textEditingController,
              keyboardType: widget.textInputType,
              decoration: InputDecoration(
                
                hintText: widget.hint_text,
                hintStyle: Global.create_hint,
              ),
              validator: (value) {
                print("did it vala");
                if (widget.isCompulsory == true && value.isEmpty) {
                  return ' ';
                }
                setValue(value);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Create_Title extends StatefulWidget {
  final String title;
  final IconData icon;
  final bool isCompulsory;
  const Create_Title({
    Key key,
    @required this.title,
    @required this.icon,
    this.isCompulsory = false,
  }) : super(key: key);

  @override
  Create_TitleState createState() {
    return new Create_TitleState();
  }
}

class Create_TitleState extends State<Create_Title> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        widget.isCompulsory == true
            ? Text(
                "*",
                style: TextStyle(color: Colors.red),
              )
            : Text(" "),
        Icon(
          widget.icon,
          size: 24.0,
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              widget.title,
              softWrap: true,
            ),
          ),
        )
      ],
    );
  }
}

class Create_Picker extends StatefulWidget {
  final String picker_title;
  final String title;
  final String tag;
  final CreateForm src;
  final List<dynamic> typeName;
  final bool isCompulsory;

  const Create_Picker(
      {Key key,
      this.picker_title,
      this.tag,
      this.src,
      this.typeName,
      this.title,
      this.isCompulsory})
      : super(key: key);
  @override
  _Create_PickerState createState() => _Create_PickerState();
}

class _Create_PickerState extends State<Create_Picker> {
  String selectedType;

  void showChoice() {
    final FixedExtentScrollController scrollController =
        new FixedExtentScrollController(initialItem: 0);
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
            child: Container(
                height: 150.0,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: CupertinoPicker(
                  scrollController: scrollController,
                  itemExtent: 32.0,
                  children: new List<Widget>.generate(widget.typeName.length,
                      (int index) {
                    return new Center(
                      child: new Text(widget.typeName[index]),
                    );
                  }),
                  onSelectedItemChanged: (int index) {
                    if (this.mounted) {
                      setState(() {
                        selectedType = widget.typeName[index];
                        widget.src.DATA[widget.tag] = widget.typeName[index];
                      });
                    }
                  },
                )));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Create_Title(
          icon: Flutter_0824_icons.tags,
          title: widget.title,
          isCompulsory: widget.isCompulsory,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 44.0, left: 23.0, top: 20.9),
          child: Container(
              height: 34,
              decoration: new ShapeDecoration(
                  color: Colors.grey,
                  shape: new RoundedRectangleBorder(
                      borderRadius:
                          new BorderRadius.all(Radius.circular(14.0)))),
              width: MediaQuery.of(context).size.width,
              child: FlatButton(
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(14.0)),
                child: Text(
                  selectedType == null ? widget.picker_title : selectedType,
                  style: new TextStyle(
                      color: Colors.white,
                      fontFamily: "HelveticaNeue",
                      fontSize: 16.0,
                      height: 0.8),
                ),
                onPressed: showChoice,
              )),
        ),
      ],
    );
  }
}

class Create_TextArea extends StatefulWidget {
  final String title;
  final String hint_text;
  final IconData icon;
  final String tag;
  final CreateForm src;
  final bool isCompulsory;
  String data;
  Create_TextArea({
    Key key,
    this.title,
    this.hint_text,
    this.icon,
    this.tag,
    this.src,
    this.data,
    this.isCompulsory,
  }) : super(key: key);

  @override
  Create_TextAreaState createState() {
    return new Create_TextAreaState();
  }
}

class Create_TextAreaState extends State<Create_TextArea> {
  TextEditingController _textEditingController;
  void setValue(dynamic s) {
    if (this.mounted) {
      widget.src.DATA[widget.tag] = s.toString();
      setState(() {
        widget.data = s.toString();
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textEditingController = new TextEditingController();
    if (widget.src.DATA.containsKey(widget.tag)) {
      _textEditingController.text = widget.src.DATA[widget.tag];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 44.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Create_Title(
              title: widget.title,
              icon: widget.icon,
              isCompulsory: widget.isCompulsory,
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 23.0),
              child: Container(
                padding: EdgeInsets.only(left: 17.3, right: 17.3),
                height: 170.0,
                decoration: BoxDecoration(
                  border: new Border.all(color: Color(0xFF9B9B9B), width: 2.0),
                ),
                child: TextFormField(
                  autocorrect: false,
                  controller: _textEditingController,
                  onFieldSubmitted: (text) {
                    setValue(text);
                  },
                  decoration: InputDecoration(
                    hintText: widget.hint_text,
                    hintStyle: Global.create_hint,
                    border: InputBorder.none,
                  ),
                  maxLines: 8,
                  keyboardType: TextInputType.multiline,
                  // onChanged: (String value) {
                  //   widget.src.DATA[widget.tag] = value;
                  // },
                  validator: (value) {
                    if (widget.isCompulsory == true && value.isEmpty) {
                      return ' ';
                    }
                    setValue(value);
                  },
                ),
              )),
        ],
      ),
    );
  }
}

class CreateForm {
  Map<String, dynamic> DATA = new Map<String, dynamic>();
  File image;
  Create_Input create_input(
      {@required IconData icon,
      @required String tag,
      String hint_text,
      TextInputType textInputType,
      String title,
      bool isCompulsory = false}) {
    return Create_Input(
      icon: icon,
      tag: tag,
      data: DATA[tag],
      hint_text: hint_text,
      title: title,
      src: this,
      textInputType: textInputType,
      isCompulsory: isCompulsory,
    );
  }

  Create_TextArea create_textarea({
    @required IconData icon,
    @required String tag,
    String hint_text,
    String title,
    bool isCompulsory,
  }) {
    return Create_TextArea(
      icon: icon,
      tag: tag,
      data: DATA[tag],
      hint_text: hint_text,
      title: title,
      src: this,
      isCompulsory: isCompulsory,
    );
  }

  Create_DatePicker create_datePicker({
    @required IconData icon,
    @required String tag,
    String hint_text,
    String title,
    bool isCompulsory,
    String initialValue,
  }) {
    return Create_DatePicker(
      icon: icon,
      tag: tag,
      data: DATA[tag],
      hint_text: hint_text,
      title: title,
      initialValue: initialValue,
      src: this,
      isCompulsory: isCompulsory,
    );
  }

  Create_TimePicker create_timePicker(
      {@required IconData icon,
      @required String tag,
      String hint_text,
      bool isCompulsory,
      String initialValue,
      String title}) {


    return Create_TimePicker(
      icon: icon,
      tag: tag,
      data: DATA[tag],
      hint_text: hint_text,
      title: title,
      initialValue: initialValue,
      src: this,
      isCompulsory: isCompulsory,
    );
  }

  Create_Picker create_picker({
    @required String tag,
    String picker_title,
    String title,
    bool isCompulsory,
    List<dynamic> typeName,
  }) {
    print(isCompulsory);
    return Create_Picker(
      tag: tag,
      picker_title: picker_title,
      src: this,
      typeName: typeName,
      title: title,
      isCompulsory: isCompulsory,
    );
  }

  Create_Upload create_upload({
    @required String tag,
    @required IconData icon,
    String title,
    bool isCompulsory,
    int max_number,
  }) {
    if (max_number == null) {
      max_number = 4;
    }
    return Create_Upload(
      title: title,
      src: this,
      icon: icon,
      tag: tag,
      max_number: max_number,
      isCompulsory: isCompulsory,
    );
  }

  Create_Google_Map_Picker create_google_picker({
    @required String tag,
    @required IconData icon,
    String hint_text,
    String title,
    bool isCompulsory,
  }) {
    return Create_Google_Map_Picker(
      title: title,
      src: this,
      icon: icon,
      tag: tag,
      hint_text: hint_text,
      isCompulsory: isCompulsory,
    );
  }
}

class Choose_Country extends StatefulWidget {
  @override
  _Choose_CountryState createState() => _Choose_CountryState();
}

class _Choose_CountryState extends State<Choose_Country> {
  String filterWord = "";
  @override
  Widget build(BuildContext context) {
    List<Country> data = Country.ALL
        .where(
            (f) => (filterWord == "" || f.name.toString().contains(filterWord)))
        .toList();
    return Container(
      padding: EdgeInsets.all(15.0),
      width: 300.0,
      height: 400.0,
      child: Column(
        children: <Widget>[
          TextField(
            autocorrect: false,
            onChanged: (s) {
              filterWord = s;
              if (this.mounted) {
                setState(() {});
              }
            },
            decoration: InputDecoration(prefixIcon: Icon(Icons.search)),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                var w = data[index % data.length].name;
                return ListTile(
                  onTap: () {
                    w != null
                        ? Navigator.pop(context, w)
                        : Navigator.pop(context);
                  },
                  title: Text(w),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
