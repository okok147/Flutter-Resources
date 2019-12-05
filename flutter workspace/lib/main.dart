import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jojobusdriver/util/Global.dart';
import 'package:jojobusdriver/util/MainPage.dart';

import 'ErrorPage.dart';
import 'SplashScreen.dart';
import 'main2.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  defineRoutes(Global.router);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
    .then((_) {
      //  runApp(new MyApp());
      runApp(new MyApp());
    });
  //return runApp(new RoutePage())email;
}

void defineRoutes(Router router) {
  router.define("/", handler: new Handler(handlerFunc: (BuildContext context, Map < String, dynamic > params) {    
    return new SplashScreen();
  }));

  router.define("/ErrorPage", handler: new Handler(handlerFunc: (BuildContext context, Map < String, dynamic > params) {    
    return new ErrorPage();
  }));

  router.define("/MainPage", handler: new Handler(handlerFunc: (BuildContext context, Map < String, dynamic > params) {    
    return new MyApp2();
  }));

  
 
}

class ResultPage {
}


