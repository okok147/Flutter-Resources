import 'package:flutter/material.dart';
import 'package:maugost/screens/app/appSearch.dart';
import 'package:maugost/utils/colors.dart';
import 'package:maugost/utils/images.dart';
import 'package:maugost/widgets/tabsBuilder.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  final PageController pageController;
  final ValueNotifier<int> pageNotifier;

  const MyAppBar({Key key, @required this.pageController, this.pageNotifier})
      : super(key: key);
  @override
  _MyAppBarState createState() => _MyAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => new Size.fromHeight(50);
}

class _MyAppBarState extends State<MyAppBar> {
  int _currentPage = 0;

  List<String> appBarTitle = [
    "Featured Apps",
    "Market Feed",
    "My Cart",
    "My Profile",
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.pageController.addListener(listener);
  }

  listener() {
    setState(() {
      _currentPage = widget.pageController.page.round();
    });
  }

  @override
  Widget build(BuildContext context) {
    return appBar();
  }

  appBar() {
    return AppBar(
      //backgroundColor: Colors.white,
      centerTitle: true,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white, size: 30),
      title: new Text(
        appBarTitle[_currentPage],
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      actions: <Widget>[
        IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white.withOpacity(0.8),
            ),
            onPressed: () {
              showSearch(
                context: context,
                delegate: AppSearchDelegate(),
              );
            })
      ],
      leading: messageButton(),
    );
  }

  messageButton() {
    return Builder(builder: (context) {
      return Stack(
        alignment: Alignment.topRight,
        children: <Widget>[
          new IconButton(
              icon: new Icon(
                OMIcons.email
                    //Icons.email,
                    ,
                color: Colors.white.withOpacity(0.8),
              ),
              onPressed: () {}),
          IgnorePointer(
            ignoring: true,
            child: new Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Container(
                height: 15,
                width: 15,
                decoration:
                    BoxDecoration(color: appRed, shape: BoxShape.circle),
                child: Center(
                  child: new Text(
                    "7",
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
              ),
            ),
          )
        ],
      );
    });
  }
}
