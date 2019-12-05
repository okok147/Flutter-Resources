import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lets_meet_flutter/pages/aboutMeetUsPage.dart';
import 'package:lets_meet_flutter/pages/chatRoomPage.dart';
// import 'package:flutter_country_picker/flutter_country_picker.dart';
import 'package:lets_meet_flutter/pages/createPage.dart';
import 'package:lets_meet_flutter/pages/eventPage.dart';
import 'package:lets_meet_flutter/pages/helpPage.dart';
import 'package:lets_meet_flutter/pages/homePage.dart';
import 'package:lets_meet_flutter/pages/hostCreate.dart';
import 'package:lets_meet_flutter/pages/hostPage.dart';
import 'package:lets_meet_flutter/pages/hostQuestionnairePage.dart';
import 'package:lets_meet_flutter/pages/hubCreatePage.dart';
import 'package:lets_meet_flutter/pages/hubPage.dart';
// import 'package:lets_meet_flutter/pages/loginPage.dart';
import 'package:fluro/fluro.dart';
import 'package:lets_meet_flutter/pages/loginPage_new.dart';
import 'package:lets_meet_flutter/pages/messagePage.dart';
import 'package:lets_meet_flutter/pages/photoViewPage.dart';
import 'package:lets_meet_flutter/pages/privacyPolicePage.dart';
import 'package:lets_meet_flutter/pages/profileViewPage.dart';
import 'package:lets_meet_flutter/pages/registerPage.dart';
import 'package:lets_meet_flutter/pages/resetPasswordPage.dart';
import 'package:lets_meet_flutter/pages/sendFeedbackPage.dart';
import 'package:lets_meet_flutter/pages/termOfServicePage.dart';
import 'package:lets_meet_flutter/util/GIcons.dart';
import 'package:lets_meet_flutter/util/Global.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:lets_meet_flutter/util/country.dart';
import 'package:lets_meet_flutter/util/flutter_0917_icons.dart';
import 'package:lets_meet_flutter/util/g_c_icon_icons.dart';
import 'package:cirrus_map_view/map_view.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:badges/badges.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:lets_meet_flutter/pages/trueMapView.dart';

//testing branch
GlobalKey<MainPageState> keyMainPage = new GlobalKey<MainPageState>();
String Token;
// final GlobalKey kHomePage = new GlobalKey();
Future<String> getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Global.Token = prefs.getString('Token').toString();
  print(prefs.getString('Token').toString());
  return (prefs.getString('Token').toString());
}

Future<bool> getUser() async {
  var response = await Request.getDio().get("me/get");
  print(response.data["Data"]);
  if (response.data["Code"] == 200) {
    Global.ac.fromJSON(response.data["Data"]);
    return true;
  } else {
    return false;
  }
}

Future<void> get_constants() async {
  var response = await Request.getDio().get("get_constant");
  if (response.data["Code"] == 200) {
    Global.typeList = response.data["Data"]["meetup_type"];
  }
}

class Request {
  static Dio getDio() {
    Dio dio = new Dio();
    dio.options.baseUrl = Global.baseUrl;
    // dio.options.baseUrl = "http://god.ibasezero.com:45419/";
    dio.options.connectTimeout = 5000; //5s
    dio.options.receiveTimeout = 5000;
    dio.options.headers = {
      'Content-Type': "application/json",
      'api_key':
          "quHMRDXrb5M1qIPJC2SVSmX8X9HdwcLaXlQaHZEe5FjSrapNgCvNKbTjyXEmNsWaAmMla14t84NSCI3a4UTtbHfAFPnEw75iNgY8KHp4Q8kIkeiak4u1WtirWpvY5UrZ",
      'token': Global.Token
    };

    return dio;
  }

  static Dio uploadFile() {
    Dio dio = new Dio();
    dio.options.baseUrl = Global.baseUrl;
    // dio.options.baseUrl = "http://god.ibasezero.com:45419/";
    dio.options.connectTimeout = 5000; //5s
    dio.options.receiveTimeout = 5000;
    dio.options.headers = {
      'api_key':
          "quHMRDXrb5M1qIPJC2SVSmX8X9HdwcLaXlQaHZEe5FjSrapNgCvNKbTjyXEmNsWaAmMla14t84NSCI3a4UTtbHfAFPnEw75iNgY8KHp4Q8kIkeiak4u1WtirWpvY5UrZ",
      'token': Global.Token
    };
    return dio;
  }
}

main() async {
  
  
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  MapView.setApiKey("AIzaSyCA3T4BDdR7Lhiqw1sZT3HBa3AvZJqtnP8");
  defineRoutes(Global.router);
  runApp(new RoutePage());
  //     .then((_) {
  //   //  runApp(new MyApp());
    
  
  // });

  //return runApp(new RoutePage());
}

void defineRoutes(Router router) {
  router.define("/Login", handler: new Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new LoginPage();
  }));

  // router.define("/MapView", handler: new Handler(
  //     handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  //   return new TrueMapView();
  // }));

  router.define("/", handler: new Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new Splash();
  }));

  router.define("/Home", handler: new Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new MainPage(
      key: keyMainPage,
    );
  }));
  router.define("/Event/:id", handler: new Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new EventPage(
      meetID: params["id"][0],
      key: Global.keyContentSection,
    );
  }));
  router.define("/EditEvent/:meetID/:categoryID", handler: new Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new CreatePage(
        categoryID: int.parse(params["categoryID"][0]),
        edit_id: int.parse(
          params["meetID"][0],
        ));
  }));

  router.define("/Hub/:id", handler: new Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new HubPage(hub_id: int.parse(params["id"][0]));
  }));
  router.define("/Message", handler: new Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new MessagePage();
  }));
  router.define("/Create/:id", handler: new Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new CreatePage(categoryID: int.parse(params["id"][0]));
  }));
  router.define("/CreateHost", handler: new Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new CreateHost();
  }));
  router.define("/EditHost/:id", handler: new Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new CreateHost(
        edit_id: int.parse(
      params["id"][0],
    ));
  }));
  router.define("/CreateHub/:id", handler: new Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new HubCreatePage(
      host_id: int.parse(params["id"][0]),
    );
  }));
  router.define("/Host/:id", handler: new Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new HostPage(
        hostID: int.parse(
      params["id"][0],
    ));
  }));
  router.define("/Register", handler: new Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new RegisterPage();
  }));
  router.define("/ChatRoom/:id", handler: new Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new ChatRoomPage(
      user_id: int.parse(params["id"][0]),
    );
  }));
  router.define("/Questionnaire/:id", handler: new Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new HostQuestionnairePage(
      host_id: int.parse(params["id"][0]),
    );
  }));
  router.define("/About_Meet_Us", handler: new Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new AboutMeetUsPage();
  }));
  router.define("/Help", handler: new Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new HelpPage();
  }));
  router.define("/TermOfService", handler: new Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new TermOfServicePage();
  }));
  router.define("/PrivacyPolice", handler: new Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new PrivacyPolicePage();
  }));
  router.define("/SendFeedback", handler: new Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new SendFeedbackPage();
  }));
  router.define("/ProfileView/:id", handler: new Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new ProfileViewPage(
      user_id: int.parse(params["id"][0]),
    );
  }));
  router.define("/PhotoView/:url", handler: new Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new PhotoViewPage(
      photo_url: params["url"][0],
    );
  }));
  router.define("/ResetPasswordPage/:activationKey", handler: new Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new ResetPasswordPage(
      activationKey: params["activationKey"][0],
    );
  }));
}

class Splash extends StatefulWidget {
  @override
  SplashState createState() {
    return new SplashState();
  }
}

class SplashState extends State<Splash> with WidgetsBindingObserver {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    startTime();
  }

  Future navigationPage() async {
    if (mounted) {
      getToken().then((onValue) {
        getUser().then((ok) async {
          await get_constants();
          if (ok) {
            Global.router.navigateTo(context, "/Home",
                transition: TransitionType.fadeIn, replace: true);
          } else {
            Global.router.navigateTo(context, "/Login",
                transition: TransitionType.fadeIn, replace: true);
          }
        });
      });
    }
  }

  void startTime() async {
    Timer(Duration(seconds: 3), navigationPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Image.asset(
            "images/backgroundNew.png",
            fit: BoxFit.cover,
          ),
        ),
        Center(
          child: Image.asset('images/logo.png'),
        ),
      ],
    ));
  }
}

class RoutePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RoutePage();
}

class _RoutePage extends State<RoutePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: Global.router.generator,
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
          primaryColor: Color(0xFF4F5A9C),
          primarySwatch: Colors.green,
          canvasColor: Colors.white,
          fontFamily: "HelveticaNeue"),
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({
    Key key,
  }) : super(key: key);
  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> with WidgetsBindingObserver {
  int unread_number = 0;
  // GlobalKey < ScaffoldState > _sc = new GlobalKey();
  // final GlobalKey kBotBar = new GlobalKey();
  void tapedbar(int n) {
    if (this.mounted) {
      if (n >= 0 && n <= 4) {
        //  ap.onTap(1);
        setState(() {
          // _index = n;
          Global.index = n;
          HomePage h = Global.kHomePage.currentWidget;
          h.setPage(n);
          Global.kHomePage.currentState.search_result_data = null;
        });
      }
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      new Timer(const Duration(milliseconds: 850), () {
        _retrieveDynamicLink();
      });
    }
  }

  _direct_to_reset_password_page(String activationKey) {
    if (activationKey != null) {
      showBottomSheet(
          context: Global.context,
          builder: (_) {
            return ResetPasswordPage(
              activationKey: activationKey,
            );
          });
    }
  }

  _direct_to_meet_page(String meetID) {
    if (meetID != null) {
      Global.router.navigateTo(Global.context, "/Event/${meetID}",
          transition: TransitionType.fadeIn);
    }
  }

  _direct_to_host_page(String hostID) {
    if (hostID != null) {
      Global.router.navigateTo(Global.context, "/Host/${hostID}",
          transition: TransitionType.fadeIn);
    }
  }

  _direct_to_hub_page(String hubID) {
    if (hubID != null) {
      Global.router.navigateTo(Global.context, "/Hub/${hubID}",
          transition: TransitionType.fadeIn);
    }
  }

  Future<void> _retrieveDynamicLink() async {
    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri deepLink = data?.link;
    if (deepLink != null) {
      print("!!!!!!!!!!!!!!!!!!!!");
      print(data);
      if (deepLink.pathSegments.contains("forget_password")) {
        _direct_to_reset_password_page(
            deepLink.queryParameters["activationKey"]);
      } else if (deepLink.pathSegments.contains("meet")) {
        print(deepLink.queryParameters["id"]);
        _direct_to_meet_page(deepLink.queryParameters["id"]);
      } else if (deepLink.pathSegments.contains("host")) {
        print(deepLink.queryParameters["id"]);
        _direct_to_host_page(deepLink.queryParameters["id"]);
      } else if (deepLink.pathSegments.contains("hub")) {
        print(deepLink.queryParameters["id"]);
        _direct_to_hub_page(deepLink.queryParameters["id"]);
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    get_unread_number();
    Global.get_unread_number = get_unread_number;
    super.initState();
    Global.context = context;
    WidgetsBinding.instance.addObserver(this);
    _retrieveDynamicLink();
  }

  // int _index = Global.index;
  @override
  void dispose() {
    // TODO: implement dispose

    Global.get_unread_number = null;
    super.dispose();
  }

  Future<Null> handleRefresh() async {
    if (this.mounted) {
      await getUser();
      setState(() {});
    }
    return null;
  }

  Future get_unread_number() async {
    //TODO
    var response = await Request.getDio().get("conversation/get/unread_number");
    if (this.mounted) {
      setState(() {
        unread_number = response.data["Data"];
        print("unread number is ${unread_number}");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Global.sc,
      backgroundColor: Colors.white,
      appBar: Global.index == 0
          ? null
          : AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              title: Global.index != 4
                  ? Transform.translate(
                      offset: Offset(0.0, 8.0),
                      child: Image.asset(
                        'images/meet_us.png',
                        height: 140.0,
                        width: 140.0,
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                      ))
                  : Container(),
              centerTitle: true,
              leading: Global.index == 4
                  ? InkWell(
                      onTap: () async {
                        await Global.router.navigateTo(context, "/Message",
                            transition: TransitionType.native);
                        get_unread_number();
                      },
                      child: Badge(
                        badgeContent:
                            Text(unread_number.toString()), // required
                        child: Icon(
                          GIcons.mail,
                          color: Colors.grey,
                          size: 32.0,
                        ), // required
                        badgeColor: Colors.red, // default: Colors.red
                        // badgeTextColor: Colors.white, // default: Colors.white
                        // hideZeroCount: true, // default: true
                      ),
                    )
                  : null,
              actions: Global.index == 4
                  ? <Widget>[
                      IconButton(
                        icon: Icon(Icons.menu),
                        color: Color(0xFF999999),
                        onPressed: () {
                          Global.sc.currentState.openEndDrawer();
                        },
                      ),
                    ]
                  : null),
      endDrawer: Global.index == 4 ? new MyDrawer() : null,
      body: HomePage(
          listController: new PageController(initialPage: 2),
          key: Global.kHomePage),
      bottomNavigationBar: Theme(
        data: ThemeData(
          canvasColor: Colors.white,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          disabledColor: Color(0xFF999999),
        ),
        child: IconTheme(
          data: IconThemeData(size: 30.0),
          child: ButtonTheme(
            child: BottomNavigationBar(
              key: Global.kBotBar,
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
                        GestureDetector(
                          onTap: () {},
                          child: Container(),
                        ),
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
                        child: Global.ac.isHost == true
                            ? Icon(
                                Flutter_0917_icons.add___,
                                // GIcons.profile,
                                size: 23.0,
                              )
                            : Icon(
                                GIcons.profile,
                                size: 17.0,
                              )),
                    title: new Container(height: 0.0))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyDrawer extends StatefulWidget {
  MyDrawer({
    Key key,
  }) : super(key: key);

  @override
  MyDrawerState createState() {
    return new MyDrawerState();
  }
}

class MyDrawerState extends State<MyDrawer> {
  List<Widget> widget_list = new List<Widget>();

  @override
  Widget build(BuildContext context) {
    widget_list.clear();
    print(Global.ac.host_list);
    for (int i = 0; i < Global.ac.host_list.length; i++) {
      widget_list.add(new ListTile(
        // child: Text(Global.ac.host_list[i]["Name"]),
        title: Text(Global.ac.host_list[i]["Name"]),
        leading: Global.ac.host_list[i]["Approval"] == "Approved"
            ? Icon(Icons.check)
            : Icon(Icons.clear),
        onTap: () {
          if (Global.ac.host_ID.isNotEmpty &&
              Global.ac.host_list[i]["Approval"] == "Approved") {
            Global.ac.isHost = !Global.ac.isHost;
            Global.selected_host_id =
                int.parse(Global.ac.host_list[i]["ID"].toString());
            keyMainPage.currentState.setState(() {});
            Navigator.pop(context);
            Navigator.pop(context);
          } else if (Global.ac.host_list[i]["Approval"] == "Pending") {
            showDialog(
                context: context,
                child: AlertDialog(
                  content: Text(
                      "The host isn't approved, Please wait for the appeoving"),
                ));
          }
        },
      ));
    }
    return Drawer(
      child: Container(
        width: 150.0,
        color: Colors.white,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.book),
                title: Text('about meet us'),
                onTap: () {
                  Global.router.navigateTo(context, "/About_Meet_Us",
                      transition: TransitionType.fadeIn);
                },
              ),
              ListTile(
                leading: Icon(Icons.help),
                title: Text('help'),
                onTap: () {
                  Global.router.navigateTo(context, "/Help",
                      transition: TransitionType.fadeIn);
                },
              ),
              ListTile(
                leading: Icon(Icons.assignment),
                title: Text('terms of service'),
                onTap: () {
                  Global.router.navigateTo(context, "/TermOfService",
                      transition: TransitionType.fadeIn);
                },
              ),
              ListTile(
                leading: Icon(Icons.security),
                title: Text('privacy policy'),
                onTap: () {
                  Global.router.navigateTo(context, "/PrivacyPolice",
                      transition: TransitionType.fadeIn);
                },
              ),
              ListTile(
                leading: Icon(Icons.sentiment_satisfied),
                title: Text('send feedback '),
                onTap: () {
                  Global.router.navigateTo(context, "/SendFeedback",
                      transition: TransitionType.fadeIn);
                },
              ),
              (Global.ac.isHost)
                  ? ListTile(
                      leading: Icon(Icons.refresh),
                      title: Text("switch to user"),
                      onTap: () async {
                        if (Global.ac.host_ID.isEmpty) {
                          Global.router.navigateTo(context, "/CreateHost",
                              transition: TransitionType.fadeIn);
                        } else if (Global.ac.isHost == false) {
                          await getUser();
                          setState() {}
                          ;
                          showDialog(
                              context: context,
                              child: SimpleDialog(
                                children: widget_list,
                              ));
                        } else {
                          Global.ac.isHost = !Global.ac.isHost;
                          keyMainPage.currentState.setState(() {});
                          print(Global.ac.isHost);
                          Navigator.pop(context);
                        }
                      },
                    )
                  : ListTile(
                      leading: Icon(Icons.refresh),
                      title: Text(Global.ac.host_ID.isEmpty
                          ? "apply to be a host"
                          : 'switch to host '),
                      onTap: () async {
                        if (Global.ac.host_ID.isEmpty) {
                          Global.router.navigateTo(context, "/CreateHost",
                              transition: TransitionType.fadeIn);
                        } else if (Global.ac.isHost == false) {
                          await getUser();
                          if (this.mounted) {
                            setState() {}
                            ;
                          }

                          showDialog(
                              context: context,
                              child: SimpleDialog(
                                children: widget_list,
                              ));
                        } else {
                          Global.ac.isHost = !Global.ac.isHost;
                          keyMainPage.currentState.setState(() {});
                          print(Global.ac.isHost);
                          Navigator.pop(context);
                        }
                      },
                    ),
              // ListTile(
              //   leading: Icon(Icons.group_add),
              //   title: Text('Invite host'),
              //   onTap: () {},
              // ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('logout '),
                onTap: () async {
                  showDialog(
                    context: context,
                    child: AlertDialog(
                      contentPadding: const EdgeInsets.all(16.0),
                      content: new Row(
                        children: <Widget>[Text("Do you want to logout?")],
                      ),
                      actions: <Widget>[
                        new FlatButton(
                            child: const Text('CANCEL'),
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                        new FlatButton(
                            child: const Text('OK'),
                            onPressed: () async {
                              await Request.getDio().post("me/logout");
                              while (Navigator.canPop(context)) {
                                Navigator.pop(context);
                              }
                              Global.router.navigateTo(context, "/Login",
                                  transition: TransitionType.native,
                                  replace: true);
                            })
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AniNum {
  // final double time;
  final State state;
  Map<String, AnimationController> map;
  Map<String, double> obj;
  TickerProvider tc;

  void add(String tag, {int time}) {
    if (time == null) time = 500;
    AnimationController ac = new AnimationController(
        vsync: tc, duration: Duration(milliseconds: time));
    ac.addListener(() {
      if (state.mounted) {
        state.setState(() {
          obj[tag] = ac.value;
        });
      }
    });
    //ac.forward();
    map[tag] = ac;
  }

  AnimationController get(String tag) {
    return map[tag];
  }

  AniNum(this.state) {
    map = new Map<String, AnimationController>();
    obj = new Map<String, double>();
    tc = this.state as TickerProvider;
  }
}
