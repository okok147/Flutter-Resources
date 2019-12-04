import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lets_meet_flutter/main.dart';
import 'package:lets_meet_flutter/widget.dart';

class HostQuestionnairePage extends StatefulWidget {
  final int host_id;

  const HostQuestionnairePage({Key key, this.host_id}) : super(key: key);
  @override
  _HostQuestionnairePageState createState() => _HostQuestionnairePageState();
}

class _HostQuestionnairePageState extends State < HostQuestionnairePage > {
  final GlobalKey < FormState > _keyHostQuestionnaire = new GlobalKey();
  final CreateForm _createForm = new CreateForm();
  Map<String, dynamic> host_data;

  Future get_host()async {
    var response = await Request.getDio().get("host/get", data: {"ID": widget.host_id});
    if(response.data["Code"] == 200){
      host_data = response.data["Data"];
    }
  }

  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      get_host();
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Questionnaire", style: TextStyle(fontFamily: "HelveticaNeue", color: Colors.black, fontSize: 17.0, ), overflow: TextOverflow.clip, ),
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
      body: SingleChildScrollView(
        child: Form(
          key: _keyHostQuestionnaire,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: < Widget > [
                _createForm.create_input(icon: Icons.question_answer, tag: "reason", hint_text: "For Fun", title: "Why would you like to be a host?"),
                _createForm.create_input(icon: Icons.question_answer, tag: "skill", hint_text: "Programming skill", title: "Do you have any professional skill?"),
                _createForm.create_input(icon: Icons.question_answer, tag: "purpose", hint_text: "Charity", title: "What is the purpose of that host?"),
                _createForm.create_input(icon: Icons.question_answer, tag: "share", hint_text: "Yes, I would", title: "Would you like to share 'meet us' with your friends?"),
                Padding(
                      padding: const EdgeInsets.only(bottom: 48.9),
                      child: Center(
                        child: RaisedButton(
                          onPressed: ()async {
                            var response = await Request.getDio().patch("host/finished/questionnaire", data: {"ID": widget.host_id});
                            if(response.data["Code"] == 200){
                              await getUser();
                              Navigator.pop(context);
                            }else{
                              showDialog(
                                context:context,
                                child: AlertDialog(
                                  content: Text("There are some problem of Submit questionnaire!")
                                ) 
                              );
                            }
                          } ,
                          child: Container(
                              height: 40.0,
                              width: 160.0,
                              child: Center(child: Text("Apply", style: TextStyle(color: Colors.white, fontSize: 14.0),))
                            ),
                          color: Color(0xff525fcb),
                        ),
                      ),
                    )
              ],
            ),
          ),
        ),
      ),
    );
  }
}