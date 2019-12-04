import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lets_meet_flutter/main.dart';
import 'package:lets_meet_flutter/util/Global.dart';

class ChatRoomPage extends StatefulWidget {
  final int user_id;
  const ChatRoomPage({Key key, this.user_id}) : super(key: key);
  @override
  _ChatRoomPageState createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  final TextEditingController _textController = new TextEditingController();
  final ScrollController _scrollController = new ScrollController();
  List<dynamic> message_data_list;
  Map<String, dynamic> user_data;
  FocusNode focusNode;
  double height_of_chatbox = 80.0;
  Future getMessage() async {
    String send_and_receive;
    if (Global.ac.id > widget.user_id) {
      send_and_receive =
          widget.user_id.toString() + ':' + Global.ac.id.toString();
    } else {
      send_and_receive =
          Global.ac.id.toString() + ":" + widget.user_id.toString();
    }
    Response response = await Request.getDio().get("chatRoom/me/get/offset",
        data: {'Send_And_Receive': send_and_receive});
    if (response.data["Code"] == 200) {
      if (this.mounted) {
        setState(() {
          message_data_list = response.data["Data"];
          Timer(Duration(milliseconds: 100), () {
            _scrollController.animateTo(
                _scrollController.position.maxScrollExtent,
                duration: Duration(milliseconds: 250),
                curve: Curves.easeOut);
          });
        });
      }
    }
  }

  Future refreshMessage() async {
    String send_and_receive;
    if (Global.ac.id > widget.user_id) {
      send_and_receive =
          widget.user_id.toString() + ':' + Global.ac.id.toString();
    } else {
      send_and_receive =
          Global.ac.id.toString() + ":" + widget.user_id.toString();
    }
    Response response = await Request.getDio().get("chatRoom/me/get/offset",
        data: {
          'Send_And_Receive': send_and_receive,
          'Last_ID': message_data_list[0]["ID"]
        });
    if (response.data["Code"] == 200) {
      if (this.mounted) {
        setState(() {
          message_data_list.insertAll(0, response.data["Data"]);
        });
      }
    }
  }

  Future getuser() async {
    Response response = await Request.getDio()
        .get("user/get", data: {'UserID': widget.user_id});
    if (response.data["Code"] == 200) {
      if (this.mounted) {
        setState(() {
          user_data = response.data["Data"];
        });
      }
    }
  }

  Future sendMessage(String text) async {
    String send_and_receive;
    Map<String, dynamic> message_data;
    if (Global.ac.id > widget.user_id) {
      send_and_receive =
          widget.user_id.toString() + ':' + Global.ac.id.toString();
    } else {
      send_and_receive =
          Global.ac.id.toString() + ":" + widget.user_id.toString();
    }
    Response response =
        await Request.getDio().post("conversation/me/send", data: {
      'Send_And_Receive': send_and_receive,
      'Conversation': text,
    });
    if (response.data["Code"] == 200) {
      message_data = response.data["Data"];
      print(message_data);
      if (this.mounted) {
        setState(() {
          message_data_list.add(response.data["Data"]);
        });
      }

      Timer(Duration(milliseconds: 100), () {
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 250), curve: Curves.easeIn);
      });
    }
  }

  Future update_message() async {
    String send_and_receive;
    if (Global.ac.id > widget.user_id) {
      send_and_receive =
          widget.user_id.toString() + ':' + Global.ac.id.toString();
    } else {
      send_and_receive =
          Global.ac.id.toString() + ":" + widget.user_id.toString();
    }
    Response response = await Request.getDio().get("chatRoom/me/get/remain",
        data: {
          'Send_And_Receive': send_and_receive,
          'Last_ID': message_data_list.last["ID"]
        });
    if (response.data["Code"] == 200) {
      if (this.mounted) {
        setState(() {
          print(response.data["Data"]);
          message_data_list.addAll(response.data["Data"]);
          Timer(Duration(milliseconds: 100), () {
            _scrollController.animateTo(
                _scrollController.position.maxScrollExtent,
                duration: Duration(milliseconds: 250),
                curve: Curves.easeIn);
          });
        });
      }
    }
  }

  void _handleSubmitted(String text) {
    _textController.clear(); //清空输入框
    if (text != null && text != "") {
      sendMessage(text);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getMessage();
    getuser();
    Global.update_message = update_message;
    focusNode = new FocusNode();
    focusNode.addListener(() {
      print(focusNode.hasFocus);
      if (focusNode.hasFocus == true) {
        print("object");
        setState(() {
          height_of_chatbox = 58.0;
        });
      } else {
        setState(() {
          height_of_chatbox = 80.0;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    Global.update_message = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          color: Color.fromRGBO(122, 122, 122, 1.0),
          icon: Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: user_data != null
            ? Text(
                user_data["Name"],
                style: TextStyle(color: Colors.black),
              )
            : Text(
                "Loading.....",
                style: TextStyle(color: Colors.grey),
              ),
      ),
      body: message_data_list != null
          ? RefreshIndicator(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: ListView.builder(
                        controller: _scrollController,
                        itemBuilder: (_, i) {
                          var data = message_data_list[i];
                          return ChatMessage(
                            message_data: data,
                          );
                        },
                        itemCount: message_data_list.length,
                      ),
                    ),
                  ),
                  Container(
                    height: height_of_chatbox,
                    color: Colors.grey,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 8.0),
                          child: Container(
                            alignment: Alignment.center,
                            height: 42.0,
                            decoration: BoxDecoration(
                                borderRadius: new BorderRadius.all(
                                    new Radius.circular(15.0)),
                                color: Colors.white),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 35.0, left: 10.0),
                                      child: TextField(
                                        autocorrect: false,
                                        controller: _textController,
                                        onSubmitted: _handleSubmitted,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Send a message",
                                            hintStyle: TextStyle(
                                            color: Color(0xffC0BFBF),
                                            fontFamily: "HelveticaNeue", fontSize: 16.0)),
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Color(0xffC0BFBF),
                                            fontFamily: "HelveticaNeue",
                                            fontSize: 16.0),
                                        onChanged: (value) {
                                          // if(focusNode == true){
                                          //   height_of_chatbox = 40.0;
                                          // }else{}
                                        },
                                        focusNode: focusNode,
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  child: IconButton(
                                    color: Color(0xffC0BFBF),
                                    icon: Icon(Icons.send),
                                    onPressed: () =>
                                        _handleSubmitted(_textController.text),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              onRefresh: refreshMessage,
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

class ChatMessage extends StatefulWidget {
  final Map<String, dynamic> message_data;
  const ChatMessage({Key key, this.message_data}) : super(key: key);
  @override
  _ChatMessageState createState() => _ChatMessageState();
}

class _ChatMessageState extends State<ChatMessage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: widget.message_data["User_ID"] == Global.ac.id
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: widget.message_data["User_ID"] == Global.ac.id ?CrossAxisAlignment.end: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: widget.message_data["User_ID"] == Global.ac.id
                        ? Colors.grey
                        : Colors.blue,
                    borderRadius: widget.message_data["User_ID"] == Global.ac.id
                        ? new BorderRadius.only(
                            topLeft: const Radius.circular(20.0),
                            topRight: const Radius.circular(20.0),
                            bottomLeft: const Radius.circular(20.0))
                        : new BorderRadius.only(
                            topLeft: const Radius.circular(20.0),
                            topRight: const Radius.circular(20.0),
                            bottomRight: const Radius.circular(20.0))),
                constraints: BoxConstraints(maxWidth: 200.0, minHeight: 20.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Text(
                      widget.message_data["Conversation"],
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Text(
                widget.message_data["Send_Time"],
                style: TextStyle(color: Colors.grey),
              )
            ],
          ),
        ],
      ),
    );
  }
}
