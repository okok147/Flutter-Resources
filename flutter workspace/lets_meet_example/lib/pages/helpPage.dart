import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_html_view/flutter_html_view.dart';
import 'package:lets_meet_flutter/main.dart';

class HelpPage extends StatefulWidget {
  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {

  String html = '';
  Future get_help() async {
    
    var response = await Request.getDio().get("others/get", data: {
      "ID": 2
    });
    if(response.data["Code"] == 200){
      if (this.mounted) {
        setState(() {
          html = response.data["Data"];
        });
      }
    }    
  }

  @override
    void initState() {
      // TODO: implement initState
      get_help();
      super.initState();
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Help", style: TextStyle(fontFamily: "HelveticaNeue", color: Colors.black, fontSize: 17.0, ), overflow: TextOverflow.clip, ),
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
             HtmlView(
               data: html,
             ),
           ],
        ),
      ),
    );
  }
}