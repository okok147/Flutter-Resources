import 'dart:async';
import 'dart:math';

import 'package:badges/badges.dart';
import 'package:dio/dio.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lets_meet_flutter/main.dart';
import 'package:lets_meet_flutter/util/GIcons.dart';
import 'package:lets_meet_flutter/util/Global.dart';
import 'package:lets_meet_flutter/util/bzEngine.dart';
import 'package:lets_meet_flutter/util/countryPicker.dart';
import 'package:lets_meet_flutter/util/g_c_icon_icons.dart';
import 'package:country_code_picker/country_code_picker.dart';
// import 'package:google_places_picker/google_places_picker.dart';
// import 'package:flutter_places_dialog/flutter_places_dialog.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:lets_meet_flutter/widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessagePage extends StatefulWidget {
  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  List<dynamic> message_data;
  List<Widget> chat_tiles = [];
  Future getMessage() async {
    Response response = await Request.getDio().get("conversation/me/get");
    if (response.data["Code"] == 200) {
      if (this.mounted) {
        setState(() {
          message_data = response.data["Data"];
          for (int i = 0; i < message_data.length; i++) {
            chat_tiles.add(ChatTile(
              data: message_data[i],
            ));
          }
        });
      }
    }
  }

  Future updateMessage() async {
    Response response = await Request.getDio().get("conversation/me/get");
    if (response.data["Code"] == 200) {
      if (this.mounted) {
        setState(() {
          message_data = response.data["Data"];
          chat_tiles = [];
          for (int i = 0; i < message_data.length; i++) {
            chat_tiles.add(ChatTile(
              data: message_data[i],
            ));
          }
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getMessage();
    Global.update_message_tile = updateMessage;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    Global.update_message_tile = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          color: Color.fromRGBO(122, 122, 122, 1.0),
          icon: Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "MESSAGES",
          style: TextStyle(color: Color.fromRGBO(122, 122, 122, 1.0)),
        ),
        centerTitle: true,
      ),
      body: message_data != null
          ? message_data.length != 0
              ? SingleChildScrollView(
                  child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(children: chat_tiles),
                ))
              : Center(
                  child: Container(
                  child: Text(
                    "You haven't start the conversation yet!",
                    style: TextStyle(color: Colors.grey),
                  ),
                ))
          : Center(child: CircularProgressIndicator()),
    );
  }
}

class ChatTile extends StatefulWidget {
  final Map<String, dynamic> data;
  const ChatTile({
    Key key,
    this.data,
  }) : super(key: key);

  @override
  ChatTileState createState() {
    return new ChatTileState();
  }
}

class ChatTileState extends State<ChatTile> {
  int user_ID;

  int getOtherUserID() {
    List<String> id_array = widget.data["Send_And_Receive"].split(":");
    id_array.removeWhere((id) => id == Global.ac.id.toString());
    int id = int.parse(id_array[0]);
    return id;
  }

  @override
  void initState() {
    // TODO: implement initState
    user_ID = getOtherUserID();
    print(widget.data);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: GestureDetector(
        onTap: () {
          Global.router.navigateTo(context, "/ChatRoom/${user_ID}",
              transition: TransitionType.fadeIn, replace: true);
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.transparent,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Message_Icon_Section(
                  user_ID: getOtherUserID(),
                  unread_number: widget.data["Unread_Number"],
                  last_user_id: widget.data["User_ID"],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    // height: 65.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          widget.data["User_Name"],
                          softWrap: true,
                          maxLines: 1,
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                        Text(
                          widget.data["Last_Conversation"],
                          softWrap: true,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text(
                            widget.data["Send_Time"],
                            textAlign: TextAlign.end,
                            style:
                                TextStyle(color: Colors.grey, fontSize: 10.0),
                          ),
                        ),
                        Divider()
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Message_Icon_Section extends StatefulWidget {
  final user_ID;
  final int unread_number;
  final int last_user_id;
  const Message_Icon_Section({
    Key key,
    this.user_ID,
    this.unread_number,
    this.last_user_id,
  }) : super(key: key);

  @override
  Message_Icon_SectionState createState() {
    return new Message_Icon_SectionState();
  }
}

class Message_Icon_SectionState extends State<Message_Icon_Section> {
  Map<String, dynamic> data;
  Future getuser() async {
    Response response = await Request.getDio()
        .get("user/get", data: {'UserID': widget.user_ID});
    if (response.data["Code"] == 200) {
      if (this.mounted) {
        setState(() {
          data = response.data["Data"];
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getuser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(right: 8.0, left: 8.0),
        child: data != null
            ? widget.unread_number != null &&
                    widget.unread_number != 0 &&
                    widget.last_user_id != Global.ac.id
                ? Stack(
                  overflow: Overflow.visible,
                    children: <Widget>[
                      Message_Icon(data: data),
                      Positioned(
                        top: -8.0,
                        right: -3.0,
                        child: Material(
                            type: MaterialType.circle,
                            elevation: 2.0,
                            color: Colors.red,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                widget.unread_number.toString(),
                                style: TextStyle(
                                  fontSize: 13.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )),
                      ),
                    ],
                  )
                : new  Message_Icon(data: data)
            : CircularProgressIndicator());
  }
}

class Message_Icon extends StatelessWidget {
  const Message_Icon({
    Key key,
    @required this.data,
  }) : super(key: key);

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45.0,
      height: 45.0,
      decoration: new BoxDecoration(
          shape: BoxShape.circle,
          image: new DecorationImage(
              fit: BoxFit.cover,
              image: data["IconUrl"] != null
                  ? NetworkImage(
                      Global.baseUrl + data["IconUrl"] + "?tn=90",
                    )
                  : AssetImage('images/placeholder.png')),
          color: Colors.grey),
    );
  }
}
