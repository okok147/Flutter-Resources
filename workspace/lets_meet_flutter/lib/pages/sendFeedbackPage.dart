import 'package:flutter/material.dart';
import 'package:lets_meet_flutter/pages/loginPage_new.dart';

class SendFeedbackPage extends StatefulWidget {
  @override
  _SendFeedbackPageState createState() => _SendFeedbackPageState();
}

class _SendFeedbackPageState extends State<SendFeedbackPage> {
  final TextEditingController _textController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FeedBack", style: TextStyle(fontFamily: "HelveticaNeue", color: Colors.black, fontSize: 17.0, ), overflow: TextOverflow.clip, ),
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
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: ListView(
           children: <Widget>[
             
             Container(
                padding: EdgeInsets.only(left: 17.3, right: 17.3, bottom: 20.0),
                height: 280.0,
                decoration: BoxDecoration(
                  border: new Border.all(color: Color(0xFF9B9B9B), width: 2.0),
                ),
                child: TextFormField(
                  autocorrect: false,
                  controller: _textController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  // onChanged: (String value) {
                  //   widget.src.DATA[widget.tag] = value;
                  // },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                  },
                ),
              ),
              FullWidthButton("SEND",onPressed: () {
                _textController.clear();
              }, color: Colors.grey,),
           ],
        ),
      ),
    );
  }
}