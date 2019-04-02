import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:maugost/main.dart';
import 'package:maugost/utils/colors.dart';
import 'package:maugost/utils/images.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:smart_text_view/smart_text_view.dart';

class ProfileTab extends StatefulWidget {
  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab>
    with AutomaticKeepAliveClientMixin {
  bool notification = false;
  bool deals = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        buildProfileCard(),
        buildMyActivity(),
        buildAboutMe(),
        settingsItems()
      ],
    );
  }

  buildProfileCard() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        new Container(
          height: 150.0,
          child: new BackdropFilter(
            filter: new ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
            child: new Container(
              decoration:
                  new BoxDecoration(color: Colors.black.withOpacity(0.1)),
            ),
          ),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(myPics), fit: BoxFit.cover)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Row(
                children: <Widget>[
                  new Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                        border: Border.all(color: appBG, width: 3),
                        image: DecorationImage(
                            image: AssetImage(myPics), fit: BoxFit.cover),
                        shape: BoxShape.circle),
                  ),
                  new SizedBox(
                    width: 12.0,
                  ),
                  new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(
                        "Maugost Okore",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              new Shadow(
                                  color: Colors.black.withOpacity(0.5),
                                  blurRadius: 8)
                            ]),
                      ),
                      new Row(
                        children: <Widget>[
                          new Icon(
                            OMIcons.email,
                            size: 20,
                          ),
                          new SizedBox(
                            width: 5,
                          ),
                          new SmartText(
                            text: "ammaugost@gmail.com",
                            linkStyle: TextStyle(color: Colors.blue, shadows: [
                              new Shadow(
                                  color: Colors.black.withOpacity(0.5),
                                  blurRadius: 8)
                            ]),
                          )
                        ],
                      ),
                      new Row(
                        children: <Widget>[
                          new Icon(
                            Icons.link,
                          ),
                          new SizedBox(
                            width: 5,
                          ),
                          new SmartText(
                            text: "github.com/mtellect",
                            linkStyle: TextStyle(color: Colors.blue, shadows: [
                              new Shadow(
                                  color: Colors.black.withOpacity(0.5),
                                  blurRadius: 8)
                            ]),
                          )
                        ],
                      ),
                      new Row(
                        children: <Widget>[
                          new Icon(
                            OMIcons.locationCity,
                          ),
                          new SizedBox(
                            width: 5,
                          ),
                          new SmartText(
                            text: "Umuahia Nigeria",
                            style: TextStyle(color: Colors.white, shadows: [
                              new Shadow(
                                  color: Colors.black.withOpacity(0.5),
                                  blurRadius: 8)
                            ]),
                            linkStyle: TextStyle(color: Colors.blue, shadows: [
                              new Shadow(
                                  color: Colors.black.withOpacity(0.5),
                                  blurRadius: 8)
                            ]),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  buildMyActivity() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Text(
                "10",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              new SizedBox(
                height: 4,
              ),
              new Text(
                "Applications",
                style: TextStyle(fontSize: 13),
              ),
            ],
          ),
          new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Text(
                "15K",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              new SizedBox(
                height: 4,
              ),
              new Text(
                "Likes",
                style: TextStyle(fontSize: 13),
              ),
            ],
          ),
          new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Text(
                "15K",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              new SizedBox(
                height: 4,
              ),
              new Text(
                "Following",
                style: TextStyle(fontSize: 13),
              ),
            ],
          ),
        ],
      ),
    );
  }

  buildAboutMe() {
    return new Container(
      margin: EdgeInsets.only(left: 25, right: 25),
      padding: EdgeInsets.all(12),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text(
            "About me",
            style: TextStyle(
                fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          new SizedBox(
            height: 5,
          ),
          new Text(
            "I am a fullstack flutter developer based in umuahia,"
                "and have been toying with flutter for a while now."
                "feel free to contact me for any project or gig you have"
                " relating to flutter.",
            style: TextStyle(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ],
      ),
      decoration:
          BoxDecoration(color: appRed, borderRadius: BorderRadius.circular(15)),
    );
  }

  Widget settingsItems() {
    return new ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(bottom: 60.0),
      children: [
        supportPortal(isSupport: false),
        new ListTile(
          onTap: () {},
          trailing: new Icon(Icons.navigate_next),
          title: new Text(
            "Edit Profile",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
          ),
          subtitle: Text(
            "Edit account details",
            style: TextStyle(fontSize: 12.0),
          ),
        ),
        new Divider(
          height: 0.0,
        ),
        new Padding(
          padding: const EdgeInsets.all(15.0),
          child: new Text(
            "About",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 14.0, color: appColor),
          ),
        ),
        new ListTile(
          onTap: () {
//            return Navigator.push(context,
//              new MaterialPageRoute(builder: (context) => new AboutUs()));
          },
          trailing: new Icon(Icons.navigate_next),
          title: new Text(
            "About App",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
          ),
          subtitle: Text(
            "Read all about Qwickelp",
            style: TextStyle(fontSize: 12.0),
          ),
        ),
        new Divider(
          height: 0.0,
        ),
        new ListTile(
          onTap: () {},
          trailing: new Icon(Icons.navigate_next),
          title: new Text(
            "Share App",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
          ),
          subtitle: Text(
            "Share app with friends",
            style: TextStyle(fontSize: 12.0),
          ),
        ),
        new Divider(
          height: 0.0,
        ),
        new ListTile(
          onTap: () {},
          trailing: new Icon(Icons.navigate_next),
          title: new Text(
            "Rate App",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
          ),
          subtitle: Text(
            "Rate the App on Play Store",
            style: TextStyle(fontSize: 12.0),
          ),
        ),
        new Divider(
          height: 0.0,
        ),
        new ListTile(
          onTap: () {},
          trailing: new Icon(Icons.navigate_next),
          title: new Text(
            "App Update",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
          ),
          subtitle: Text(
            "Check for update",
            style: TextStyle(fontSize: 12.0),
          ),
        ),
        new Divider(
          height: 0.0,
        ),
        new Padding(
          padding: const EdgeInsets.all(15.0),
          child: new Text(
            "Other",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 14.0, color: appColor),
          ),
        ),
        new ListTile(
          onTap: () {},
          trailing: new Icon(Icons.navigate_next),
          title: new Text(
            "Privacy policy",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
          ),
          subtitle: Text(
            "Read our privacy policy",
            style: TextStyle(fontSize: 12.0),
          ),
        ),
        new Divider(
          height: 0.0,
        ),
        new ListTile(
          onTap: () {},
          trailing: new Icon(Icons.navigate_next),
          title: new Text(
            "Terms and Conditions",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
          ),
          subtitle: Text(
            "Read our terms and conditions",
            style: TextStyle(fontSize: 12.0),
          ),
        ),
        new Divider(
          height: 0.0,
        ),
        new ListTile(
          onTap: () {},
          trailing: new Icon(Icons.navigate_next),
          title: new Text(
            "Feedback",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
          ),
          subtitle: Text(
            "Provide us with feedback to help us improve the app",
            style: TextStyle(fontSize: 12.0),
          ),
        ),
        new Divider(
          height: 0.0,
        ),
        new ListTile(
          onTap: () {},
          trailing: new Icon(Icons.navigate_next),
          title: new Text(
            "Help and support",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
          ),
          subtitle: Text(
            "Ask us anytime for help and support",
            style: TextStyle(fontSize: 12.0),
          ),
        ),
        new Divider(
          height: 0.0,
        ),
        new ListTile(
          onTap: () {},
          trailing: new Icon(Icons.navigate_next),
          title: new Text(
            "Log Out",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 18.0, color: Colors.red),
          ),
          subtitle: new Text(""),
        ),
      ],
    );
  }

  Widget supportPortal({@required bool isSupport}) {
    if (isSupport == true) {
      return new Container(
        color: Colors.red,
        child: Column(
          children: <Widget>[
            new ListTile(
              onTap: () {
//                Navigator.push(
//                    context,
//                    new MaterialPageRoute(
//                        builder: (context) => new BaseController()));
              },
              title: new Text(
                "Click to enter support portal",
                style: new TextStyle(
                    fontWeight: FontWeight.w700, color: Colors.white),
              ),
              subtitle: new Text(
                "Every support features and more...",
                style: new TextStyle(color: Colors.white70, fontSize: 12.0),
              ),
              trailing: new Icon(Icons.navigate_next),
            ),
          ],
        ),
      );
    }
    return Container();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
