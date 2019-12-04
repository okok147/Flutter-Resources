import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:lets_meet_flutter/main.dart';

class AboutMeetUsPage extends StatefulWidget {
  @override
  _AboutMeetUsPageState createState() => _AboutMeetUsPageState();
}

class _AboutMeetUsPageState extends State<AboutMeetUsPage> {
  String html = '';
  Future get_about_meet_us() async {
    var response = await Request.getDio().get("others/get", data: {
      "ID": 1
    });
    if(response.data["Code"] == 200){
      if (this.mounted) {
        setState(() {
          print(response.data["Data"]);
          html = response.data["Data"];
        });
      }
    }    
  }

  @override
    void initState() {
      // TODO: implement initState
      get_about_meet_us();
      super.initState();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Meet Us", style: TextStyle(fontFamily: "HelveticaNeue", color: Colors.black, fontSize: 17.0, ), overflow: TextOverflow.clip, ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: Padding(
          padding: const EdgeInsets.only(right: 18.0),
            child: IconButton(icon: Icon(Icons.keyboard_arrow_left, color: Colors.black, size: 40.0, ), onPressed: () {
              Navigator.pop(context);
            }, )
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric( horizontal: 8.0),
        child: ListView(
           children: <Widget>[
             Html(
               data: html,
             ),
           ],
        ),
      ),
    );
  }
}