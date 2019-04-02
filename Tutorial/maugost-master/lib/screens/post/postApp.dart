import 'dart:io';

import 'package:flutter/material.dart';
import 'package:maugost/main.dart';
import 'package:maugost/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

import 'package:flutter/services.dart';

class PostApp extends StatefulWidget {
  @override
  _PostAppState createState() => _PostAppState();
}

class _PostAppState extends State<PostApp> {
  var postController = new TextEditingController();
  bool isComposing = false;
  var focusNode = new FocusNode();
  List<File> files = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    postController.addListener(listener);
  }

  listener() {
    if (postController.text.trim().isNotEmpty) {
      setState(() {
        isComposing = true;
      });
    } else {
      setState(() {
        isComposing = false;
      });
    }
  }

  Future<bool> onWillPop() async {
    closePostView();
    return false;
  }

  Widget showIOSDialog() {
    var text = const Text(
      'Are sure you?',
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );

    return new CupertinoAlertDialog(
      title: text,
      content: new Text(
        "You will lose all of your changes",
        style: TextStyle(fontSize: 14),
      ),
      actions: <Widget>[
        new CupertinoDialogAction(
          child: const Text(
            'Yes',
            style: TextStyle(fontSize: 14),
          ),
          isDestructiveAction: true,
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
        ),
        new CupertinoDialogAction(
          child: const Text(
            'Cancel',
            style: TextStyle(fontSize: 14),
          ),
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context,
                false); // Pops the confirmation dialog but not the page.
          },
        ),
      ],
    );
  }

  Future closePostView() async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return Platform.isIOS ? showIOSDialog() : showIOSDialog();
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: new Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppBar(),
        body: buildScaffoldBody(),
      ),
    );
  }

  buildAppBar() {
    return new AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: new IconButton(
          icon: Icon(
            Icons.clear,
            color: Colors.grey,
            size: 30,
          ),
          onPressed: () {
            closePostView();
          }),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: new RaisedButton(
            color: appColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            onPressed: isComposing == false ? null : () {},
            child: new Text(
              "Publish",
              style: TextStyle(color: Colors.white),
            ),
          ),
        )
      ],
    );
  }

  buildScaffoldBody() {
    return new GestureDetector(
      onTap: () {
        focusNode.unfocus();
      },
      child: Container(
        child: new Column(
          children: <Widget>[buildInputField(), buildPostLayout()],
        ),
      ),
    );
  }

  buildInputField() {
    return new Expanded(
      child: Container(
        padding: const EdgeInsets.all(12.0),
        alignment: Alignment.topCenter,
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new CircleAvatar(
              maxRadius: 15,
              backgroundImage: AssetImage(myPics),
            ),
            new SizedBox(
              width: 10,
            ),
            new Flexible(
                child: new TextField(
              focusNode: focusNode,
              controller: postController,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              style: TextStyle(fontSize: 14),
              decoration: InputDecoration(
                  hintText: "What have you been working on to share?",
                  hintStyle: TextStyle(color: Colors.grey.withOpacity(0.7)),
                  border: InputBorder.none),
            ))
          ],
        ),
      ),
    );
  }

  buildPostLayout() {
    return new Container(
      height: 50,
      padding: EdgeInsets.only(left: 15, right: 15),
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          border: Border(
              top:
                  BorderSide(color: Colors.grey.withOpacity(0.4), width: 0.7))),
      child: new Row(
        children: <Widget>[
          new IconButton(
              icon: Icon(
                OMIcons.image,
              ),
              onPressed: () {
                focusNode.unfocus();
                buildImageVideoSelector();
              }),
          new IconButton(
              icon: Icon(OMIcons.locationOn),
              onPressed: () {
                focusNode.unfocus();
              }),
          new IconButton(
              icon: Icon(OMIcons.loyalty),
              onPressed: () {
                focusNode.unfocus();
              }),
          new IconButton(
              icon: Icon(OMIcons.equalizer),
              onPressed: () {
                focusNode.unfocus();
              }),
        ],
      ),
    );
  }

  buildImageVideoSelector() {
    return showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return new CupertinoActionSheet(
          actions: <Widget>[
            new CupertinoActionSheetAction(
                onPressed: () {}, child: new Text("Take Photo")),
            new CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: new Text("Choose Photo")),
            new CupertinoActionSheetAction(
                onPressed: () {}, child: new Text("Choose Video")),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: new Text("Cancel"),
            isDefaultAction: true,
          ),
        );
      },
    );
  }
}
