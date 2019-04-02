import 'package:flutter/material.dart';
import 'package:maugost/main.dart';
import 'package:maugost/utils/colors.dart';
import 'package:maugost/utils/images.dart';
import 'package:maugost/widgets/tabsBuilder.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class BottomTabs extends StatefulWidget {
  final PageController pageController;
  final ValueNotifier<bool> bubbleNotifier;

  const BottomTabs(
      {Key key, @required this.pageController, this.bubbleNotifier})
      : super(key: key);
  @override
  _BottomTabsState createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {
  int _currentPage = 0;
  bool showBubble = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.pageController.addListener(listener);
    widget.bubbleNotifier.addListener(bubbleListener);
  }

  bubbleListener() {
    setState(() {
      showBubble = widget.bubbleNotifier.value;
    });
  }

  listener() {
    setState(() {
      _currentPage = widget.pageController.page.round();
    });
  }

  @override
  Widget build(BuildContext context) {
    return bottomNavigationBar();
  }

  bottomNavigationBar() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
          color: appColor,
          border: Border.all(color: Colors.black.withOpacity(0.1)),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          )),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          new TabItemBuilder(
            position: 0,
            tabIcon: Icons.star,
            currentTab: _currentPage,
            //pageNotifier: _pageNotifier,
            itemClicked: onTapClicked,
          ),
          new TabItemBuilder(
            position: 1,
            tabImage: flutter_icon,
            tabIcon: OMIcons.rssFeed,
            //iconType: IconType.image,
            currentTab: _currentPage,
            //pageNotifier: _pageNotifier,

            itemClicked: onTapClicked,
          ),
          new TabItemBuilder(
            tabImage: flutter_icon,
            tabIcon: OMIcons.add,
            //iconType: IconType.image,
            currentTab: _currentPage,
            tabType: TabType.centre,
            //pageNotifier: _pageNotifier,
            itemClicked: (position) {
              widget.bubbleNotifier.value = !showBubble;
            },
          ),
          new TabItemBuilder(
            position: 2,
            tabIcon: OMIcons.shoppingCart,
            currentTab: _currentPage,
            //pageNotifier: _pageNotifier,
            itemClicked: onTapClicked,
          ),
          new TabItemBuilder(
            position: 3,
            tabIcon: Icons.person_outline,
            currentTab: _currentPage,
            //pageNotifier: _pageNotifier,
            itemClicked: onTapClicked,
          ),
        ],
      ),
    );
  }

  //Used when the tab is clicked
  onTapClicked(int val) {
    widget.bubbleNotifier.value = false;
    widget.pageController.jumpToPage(val);
  }
}
