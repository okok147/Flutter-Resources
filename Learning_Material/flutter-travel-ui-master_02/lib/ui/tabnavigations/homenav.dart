import 'package:flutter/material.dart';
import 'package:travelui/ui/dashboard/flight_results_page.dart';
import 'package:travelui/ui/dashboard/home_page.dart';
import 'package:travelui/ui/dashboard/planeticket_page.dart';

class HomeTabNavigatorRoutes {
  static const String root = '/';
  static const String planeticket = '/planeticket';
  static const String flightresult = '/flightresult';
}

class HomeTabNavigator extends StatelessWidget {
  HomeTabNavigator({this.navigatorKey});
  final GlobalKey<NavigatorState> navigatorKey;

  void _push(BuildContext context, String page) {

    var routeBuilders = _routeBuilders(context);

    switch(page){

      case "/planeticket":
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    routeBuilders[HomeTabNavigatorRoutes.planeticket](context)));
        break;
      case "/flightsearch":

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    routeBuilders[HomeTabNavigatorRoutes.flightresult](context)));




    }


  }

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context,
      {int materialIndex: 500}) {
    return {
      HomeTabNavigatorRoutes.root: (context) => HomePage(
        onPush: (materialIndex) =>
            _push(context, "/planeticket"),
      ),
      HomeTabNavigatorRoutes.planeticket: (context) => PlaneTicketPage(

        onPush: (materialIndex) =>
            _push(context, "/flightsearch"),
      ),
      HomeTabNavigatorRoutes.flightresult: (context) => FlightResultsPage()
    };
  }

  @override
  Widget build(BuildContext context) {
    var routeBuilders = _routeBuilders(context);

    return Navigator(
        key: navigatorKey,
        initialRoute: HomeTabNavigatorRoutes.root,
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
              builder: (context) => routeBuilders[routeSettings.name](context));
        });
  }
}