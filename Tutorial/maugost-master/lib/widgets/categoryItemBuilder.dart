import 'package:flutter/material.dart';
import 'package:maugost/screens/homePage.dart';
import 'package:maugost/utils/colors.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class CategoryContainer extends StatelessWidget {
  final Widget widget;
  final String title;
  final Color textColor;
  final Function onClicked;

  const CategoryContainer(
      {Key key, this.widget, this.title, this.textColor, this.onClicked})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: onClicked,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.all(5),
          height: 70,
          width: 70,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              widget,
              new SizedBox(
                height: 2,
              ),
              new Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: textColor, fontSize: 12),
              )
            ],
          ),
        ),
      ),
    );
  }
}

List<CategoryContainer> categoryList = [
  new CategoryContainer(
    title: "Shopping",
    textColor: appBlack,
    widget: Icon(
      OMIcons.shoppingCart,
      color: appRed,
    ),
  ),
  new CategoryContainer(
    title: "Banking",
    textColor: appBlack,
    widget: Icon(
      OMIcons.accountBalance,
      color: appRed,
    ),
  ),
  new CategoryContainer(
    title: "Traveling",
    textColor: appBlack,
    widget: Icon(
      OMIcons.cardTravel,
      color: appRed,
    ),
  ),
  new CategoryContainer(
    title: "Navigation",
    textColor: appBlack,
    widget: Icon(
      OMIcons.navigation,
      color: appRed,
    ),
  ),
  new CategoryContainer(
    title: "Booking",
    textColor: appBlack,
    widget: Icon(
      Icons.event,
      color: appRed,
    ),
  ),
];
