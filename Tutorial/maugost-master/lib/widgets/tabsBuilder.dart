import 'package:flutter/material.dart';
import 'package:maugost/main.dart';

enum IconType { image, icon }
enum TabType { normal, centre }

class TabItemBuilder extends StatelessWidget {
  final IconData tabIcon;
  final int position;
  final String tabImage;
  final int currentTab;
  final IconType iconType;
  final TabType tabType;
  final ValueNotifier<int> pageNotifier;

  final Function(int position) itemClicked;

  const TabItemBuilder(
      {this.position,
      this.currentTab,
      this.itemClicked,
      this.iconType = IconType.icon,
      this.tabImage,
      this.tabIcon,
      this.pageNotifier,
      this.tabType = TabType.normal});

  _tabItemBuilder(BuildContext context) {
    double iconSize;
    Color zoomColor;
    if (position == currentTab) {
      zoomColor = Colors.white;
      iconSize = 25;
    } else {
      zoomColor = Colors.white.withOpacity(0.5);
      iconSize = 20;
    }

    switch (iconType) {
      case IconType.icon:
        return new Flexible(
            child: new GestureDetector(
          onTap: () {
            itemClicked(position);
          },
          child: Container(
            width: MediaQuery.of(context).size.width / 4,
            height: 50,
            color: Colors.transparent,
            child: new Icon(
              tabIcon,
              size: iconSize,
              color: zoomColor,
            ),
          ),
        ));
        break;
      case IconType.image:
        return new Flexible(
            child: new GestureDetector(
          onTap: () {
            itemClicked(position);
          },
          child: Container(
            width: 70,
            height: 50,
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: new Image.asset(
                tabImage,
                height: iconSize,
                width: iconSize,
                color: zoomColor,
              ),
            ),
          ),
        ));
        break;
    }
  }

  _tabItemCentreBuilder(BuildContext context) {
    final double iconSize = 20;
    final Color zoomColor = Colors.white;

    switch (iconType) {
      case IconType.icon:
        return new Flexible(
            child: new GestureDetector(
          onTap: () {
            itemClicked(position);
          },
          child: Container(
            width: MediaQuery.of(context).size.width / 4,
            height: 50,
            color: Colors.transparent,
            child: Center(
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white.withOpacity(0.5))),
                child: new Icon(
                  tabIcon,
                  size: iconSize,
                  color: zoomColor,
                ),
              ),
            ),
          ),
        ));
        break;
      case IconType.image:
        return new Flexible(
            child: new GestureDetector(
          onTap: () {
            itemClicked(position);
          },
          child: Container(
            width: 70,
            height: 50,
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: new Image.asset(
                tabImage,
                height: iconSize,
                width: iconSize,
                color: zoomColor,
              ),
            ),
          ),
        ));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (tabType == TabType.normal) {
      return _tabItemBuilder(context);
    }
    return _tabItemCentreBuilder(context);
  }
}

//diff "${PODS_PODFILE_DIR_PATH}/Podfile.lock" "${PODS_ROOT}/Manifest.lock" > /dev/null
//if [ $? != 0 ] ; then
//# print error to STDERR
//echo "error: The sandbox is not in sync with the Podfile.lock. Run 'pod install' or update your CocoaPods installation." >&2
//exit 1
//fi
//# This output is used by Xcode 'outputs' to avoid re-running this script phase.
//echo "SUCCESS" > "${SCRIPT_OUTPUT_FILE_0}"
