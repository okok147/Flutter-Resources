import 'dart:async';
import 'dart:convert';

import 'package:background_fetch/background_fetch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qrcode_reader/qrcode_reader.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:jojobusdriver/util/Global.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';

import 'Color.dart';

// void main(){

// runApp(MyApp2());}

class MyApp2 extends StatefulWidget {
  @override
  _MyApp2State createState() => _MyApp2State();

  void addAction(Action action) {
    print(action.result);
  }
}

class Action {
  String command;
  dynamic result;
  Action({this.command, this.result});
}

MyApp2 app;

Future<String> testHandler(String command) async {
  Action action = new Action(command: command);

  print("FlutterDriverExtension Rx: $command");

  // Setup
  // bg.BackgroundGeolocation.removeListeners();
  // await bg.BackgroundGeolocation.removeGeofences();
  // await bg.BackgroundGeolocation.stop();
  // await bg.BackgroundGeolocation.reset(bg.Config(
  //     debug: true,
  //     logLevel: bg.Config.LOG_LEVEL_VERBOSE
  // ));

  switch (command) {
    case 'getState':
      bg.State state = await bg.BackgroundGeolocation.state;
      action.result = state;
      app.addAction(action);
      return state.toString();
      break;
    case 'getCurrentPosition':
      bg.Location location =
          await bg.BackgroundGeolocation.getCurrentPosition(samples: 1);
      action.result = location;
      app.addAction(action);
      return location.toString();
      break;
    case 'getGeofences':
      bg.Geofence geofence = bg.Geofence(
          identifier: 'test',
          radius: 1.0,
          latitude: 1.0,
          longitude: 1.0,
          notifyOnEntry: true,
          extras: {"foo": "bar"});
      await bg.BackgroundGeolocation.addGeofence(geofence);
      List<bg.Geofence> geofences = await bg.BackgroundGeolocation.geofences;
      List<Map> rs = [];
      geofences.forEach((bg.Geofence geofence) {
        rs.add(geofence.toMap());
      });
      action.result = rs;
      app.addAction(action);
      return jsonEncode(rs);
      break;
    case 'start':
      bg.State state = await bg.BackgroundGeolocation.start();
      action.result = state;
      app.addAction(action);
      return state.toString();
      break;
    case 'onLocation':
      Completer completer = new Completer<String>();
      bg.BackgroundGeolocation.onLocation((bg.Location location) {
        action.result = location;
        app.addAction(action);
        completer.complete(location.toString());
      });
      bg.BackgroundGeolocation.start();
      return completer.future;
      break;
    case 'onMotionChange':
      Completer completer = new Completer<String>();
      bg.BackgroundGeolocation.onMotionChange((bg.Location location) {
        action.result = location;
        app.addAction(action);
        completer.complete(location.toString());
      });
      bg.BackgroundGeolocation.start();
      return completer.future;
      break;
    case 'onGeofence':
      Completer completer = new Completer<String>();
      bg.BackgroundGeolocation.onGeofence((bg.GeofenceEvent event) {
        action.result = event;
        app.addAction(action);
        completer.complete(event.toString());
      });

      bg.Location location =
          await bg.BackgroundGeolocation.getCurrentPosition(samples: 1);
      bg.Geofence geofence = bg.Geofence(
          identifier: 'test',
          radius: 200.0,
          latitude: location.coords.latitude,
          longitude: location.coords.longitude,
          notifyOnEntry: true);
      bg.BackgroundGeolocation.addGeofence(geofence);
      bg.BackgroundGeolocation.start();
      return await completer.future;
      break;
    case 'onEnabledChange:true':
      Completer completer = new Completer<String>();
      bg.BackgroundGeolocation.onEnabledChange((bool enabled) {
        action.result = enabled;
        app.addAction(action);
        completer.complete(enabled.toString());
      });
      await bg.BackgroundGeolocation.start();
      return completer.future;
      break;
    case 'onEnabledChange:false':
      Completer completer = new Completer<String>();
      bg.BackgroundGeolocation.onEnabledChange((bool enabled) {
        if (enabled == false) {
          action.result = enabled;
          app.addAction(action);
          completer.complete(enabled.toString());
        }
      });
      await bg.BackgroundGeolocation.start();
      await bg.BackgroundGeolocation.stop();
      return completer.future;
      break;
    case 'onHttp':
      Completer completer = new Completer<String>();

      Map<String, dynamic> deviceParams = await bg.Config.deviceParams;
      // Configure #url & #params
      await bg.BackgroundGeolocation.setConfig(bg.Config(
          autoSync: true,
          extras: {"foo": "bar"},
          url:
              "http://tracker.transistorsoft.com/locations/transistor-flutter-test",
          params: deviceParams));
      // Clear database.
      await bg.BackgroundGeolocation.destroyLocations();

      bg.BackgroundGeolocation.onHttp((bg.HttpEvent event) {
        action.result = event;
        app.addAction(action);
        completer.complete(event.toString());
      });
      bg.BackgroundGeolocation.start();
      return completer.future;
      break;
    case 'onHttp:404':
      Completer completer = new Completer<String>();

      Map<String, dynamic> deviceParams = await bg.Config.deviceParams;
      // Configure bogus 404 #url & #params
      await bg.BackgroundGeolocation.setConfig(bg.Config(
          autoSync: true,
          extras: {"foo": "bar"},
          url: "https://www.transistorsoft.com/test/error",
          params: deviceParams));
      // Clear database.
      await bg.BackgroundGeolocation.destroyLocations();

      bg.BackgroundGeolocation.onHttp((bg.HttpEvent event) {
        action.result = event;
        app.addAction(action);
        completer.complete(event.toString());
      });
      bg.BackgroundGeolocation.start();
      return completer.future;
      break;
    case 'getCount':
      await bg.BackgroundGeolocation.destroyLocations();
      await bg.BackgroundGeolocation.getCurrentPosition(
          samples: 1, persist: true);
      int count = await bg.BackgroundGeolocation.count;
      action.result = count;
      app.addAction(action);
      return count.toString();
      break;
    case 'destroyLocations':
      await bg.BackgroundGeolocation.getCurrentPosition(
          samples: 1, persist: true);
      bool result = await bg.BackgroundGeolocation.destroyLocations();
      print("destroyLocations: " + result.toString());
      int count = await bg.BackgroundGeolocation.count;
      action.result = count;
      app.addAction(action);
      return count.toString();
      break;
    default:
      return "404";
  }
}

class _MyApp2State extends State<MyApp2> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

void backgroundFetchHeadlessTask() async {
  // Get current-position from BackgroundGeolocation in headless mode.
  //bg.Location location = await bg.BackgroundGeolocation.getCurrentPosition(samples: 1);
  print('[BackgroundFetch] HeadlessTask');

  int count = 0;
  // if (prefs.get("fetch-count") != null) {
  //   count = prefs.getInt("fetch-count");
  // }
  // prefs.setInt("fetch-count", ++count);
  print('[BackgroundFetch] count: $count');

  BackgroundFetch.finish();
}

void backgroundGeolocationHeadlessTask(bg.HeadlessEvent headlessEvent) async {
  print('📬 --> $headlessEvent');

  switch (headlessEvent.name) {
    case bg.Event.TERMINATE:
      try {
        //bg.Location location = await bg.BackgroundGeolocation.getCurrentPosition(samples: 1);
        print('[getCurrentPosition] Headless: $headlessEvent');
      } catch (error) {
        print('[getCurrentPosition] Headless ERROR: $error');
      }
      break;
    case bg.Event.HEARTBEAT:
      /* DISABLED getCurrentPosition on heartbeat
      try {
        bg.Location location = await bg.BackgroundGeolocation.getCurrentPosition(samples: 1);
        print('[getCurrentPosition] Headless: $location');
      } catch (error) {
        print('[getCurrentPosition] Headless ERROR: $error');
      }
      */
      break;
    case bg.Event.LOCATION:
      bg.Location location = headlessEvent.event;
      break;
    case bg.Event.MOTIONCHANGE:
      bg.Location location = headlessEvent.event;
      break;
    case bg.Event.GEOFENCE:
      bg.GeofenceEvent geofenceEvent = headlessEvent.event;
      break;
    case bg.Event.GEOFENCESCHANGE:
      bg.GeofencesChangeEvent event = headlessEvent.event;
      break;
    case bg.Event.SCHEDULE:
      bg.State state = headlessEvent.event;
      break;
    case bg.Event.ACTIVITYCHANGE:
      bg.ActivityChangeEvent event = headlessEvent.event;
      break;
    case bg.Event.HTTP:
      bg.HttpEvent response = headlessEvent.event;
      break;
    case bg.Event.POWERSAVECHANGE:
      bool enabled = headlessEvent.event;
      break;
    case bg.Event.CONNECTIVITYCHANGE:
      bg.ConnectivityChangeEvent event = headlessEvent.event;
      break;
    case bg.Event.ENABLEDCHANGE:
      bool enabled = headlessEvent.event;
      break;
  }
}

class _MainPageState extends State<MainPage> {
  init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var Token = prefs.getString('TOKEN').toString();

    Map deviceParams = await bg.Config.deviceParams;

    deviceParams["device"] = deviceParams["device"] ?? {};

    deviceParams["user_id"] = "test123";
    deviceParams["company_token"] = "JOJOBUS";
// deviceParams["device"]["model"] = "龍哥3";
// deviceParams["device"]["uuid"] = 9;

    deviceParams["device"]["driver_token"] = Token;

    await bg.BackgroundGeolocation.requestPermission();

    bg.BackgroundGeolocation.onLocation((f) => print(f));

    var r = await bg.BackgroundGeolocation.ready(bg.Config(

//    url: 'http://192.168.1.10:49752/locations',
        url: 'http://gps.jojobus.com.hk/locations',
        params: deviceParams,
        reset: true,
        debug: true,
        logLevel: bg.Config.LOG_LEVEL_VERBOSE,
        desiredAccuracy: bg.Config.DESIRED_ACCURACY_MEDIUM,
        distanceFilter: 10.0,
        stopOnTerminate: false,
        startOnBoot: true,
        enableHeadless: true,
        autoSync: true,
        heartbeatInterval: 60000,
        foregroundService: true));
    bg.BackgroundGeolocation();
    bg.BackgroundGeolocation.start();
    print("ok");
    print(r);

    /// Register BackgroundGeolocation headless-task.
    bg.BackgroundGeolocation.registerHeadlessTask(
        backgroundGeolocationHeadlessTask);

    /// Register BackgroundFetch headless-task.
    BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
    // enableFlutterDriverExtension(handler: testHandler);
  }

  @override
  void initState() {
    // TODO: implement initState
    print("why");
    init();
    super.initState();
  }

  getData() async {}
  bool starting = false;
  String dropdownValue = 'AB2000';
  @override
  Widget build(BuildContext context) {
    getData();
    // 5 Dec 2019
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(FontAwesomeIcons.qrcode),
          onPressed: () async {
            String r = await new QRCodeReader()
                .setAutoFocusIntervalInMs(200) // default 5000
                .setForceAutoFocus(true) // default false
                .setTorchEnabled(true) // default false
                .setHandlePermissions(true) // default true
                .setExecuteAfterPermissionGranted(true) // default true
                .scan();
          },
        ),
        centerTitle: false,
        backgroundColor: Cor.mainColor,
        title: Text("車牌: " + Global.me.lisence),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: Column(
            children: <Widget>[
              Container(
                height: 40,
                width: double.infinity,
                color: starting ? Cor.statusBarColor2 : Cor.statusBarColor1,
                child: starting
                    ? Center(
                        child: Text(
                        'Winner Winner-Chicken Dinner!',
                        style: TextStyle(color: Cor.statusBarMessage),
                      ))
                    : Center(
                        child: Text(
                        '幸福存在於一個人真正的工作中。',
                        style: TextStyle(
                          color: Cor.statusBarMessage,
                        ),
                      )),
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                    child: Text(
                      '車牌號碼 ： ',
                      style: TextStyle(
                          fontSize: 32.0, fontFamily: 'Noto Serif TC'),
                    ),
                  ),
                  DropdownButton<String>(
                      isExpanded: false,
                      iconSize: 32.0,
                      iconEnabledColor: Cor.dropDownMenuIcon,
                      style: TextStyle(
                          color: Cor.carNumberColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 32.0),
                      value: dropdownValue,
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownValue = newValue;
                        });
                      },
                      items: <String>['AB2000', 'VO2020', 'QO2852']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style:
                                  TextStyle(color: Cor.dropDownMenuItemColor),
                            ));
                      }).toList()),
                ],
              ),
              Spacer(),
              Container(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32.0),
                    child: FlatButton(
                      color: Cor.workButtonColor,
                      child: Text(
                        starting ? "收工" : "開工",
                        style: starting
                            ? TextStyle(
                                color: Cor.openWork,
                                fontSize: 80.0,
                                fontFamily: 'Noto Serif TC')
                            : TextStyle(
                                color: Cor.closeWork,
                                fontSize: 80.0,
                                fontFamily: 'Noto Serif TC'),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(32.0),
                          side: BorderSide(color: Cor.workButtonBorder)),
                      onPressed: () async {
                        // bg.BackgroundGeolocation.start();
                        // bg.BackgroundGeolocation.

                        var aa = await bg.BackgroundGeolocation.state;
                        print("...");
                        print(aa.enabled);
                        print("...");
                        if (aa.enabled == true) {
                          starting = false;
                          await bg.BackgroundGeolocation.stop();
                          //  await bg.BackgroundGeolocation.stopBackgroundTask();
                        } else {
                          starting = true;
                          bg.BackgroundGeolocation.start();
                          var a = await bg.BackgroundGeolocation
                              .getCurrentPosition();
                          var p = await bg.BackgroundGeolocation.state;
                          print(a);
                          print("??");
                          bg.BackgroundGeolocation.changePace(true);
                        }
                        setState(() {});
                        //enableFlutterDriverExtension(handler: testHandler);
                        // print(a);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
