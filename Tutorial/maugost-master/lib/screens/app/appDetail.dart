import 'package:flutter/material.dart';
import 'package:maugost/main.dart';
import 'package:maugost/screens/app/appReviews.dart';
import 'package:maugost/screens/payment/paymentDetails.dart';
import 'package:maugost/utils/colors.dart';
import 'package:maugost/widgets/appsItemBuilder.dart';
import 'package:maugost/widgets/reviewBuilder.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:ravepay/ravepay.dart';

class AppDetail extends StatefulWidget {
  final String heroTag;
  final AppsItemBuilder data;
  const AppDetail({Key key, this.heroTag, this.data}) : super(key: key);
  @override
  _AppDetailState createState() => _AppDetailState();
}

class _AppDetailState extends State<AppDetail> {
  String dummyDescription =
      "Lorem Ipsum is simply dummy text of the printing and typesetting"
      " industry. Lorem Ipsum has"
      "been the industry's standard dummy text ever since the 1500s, when an unknown printer took a"
      "galley of type and scrambled it to make a type specimen book. It has survived not only five"
      "centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was"
      "popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages,"
      "and more recently with desktop publishing software like Aldus PageMaker including versions of"
      "Lorem Ipsum";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: new Text("App Detail"),
        actions: <Widget>[cartButton()],
      ),
      body: scaffoldBody(),
    );
  }

  cartButton() {
    return Builder(builder: (context) {
      return Stack(
        alignment: Alignment.topRight,
        children: <Widget>[
          new IconButton(
              icon: new Icon(OMIcons.shoppingCart
                  //Icons.email,
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
                    BoxDecoration(color: Colors.red, shape: BoxShape.circle),
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

  scaffoldBody() {
    return Column(
      children: <Widget>[buildList(), buildActions()],
    );
  }

  buildList() {
    return new Flexible(
        child: new ListView(
      physics: ClampingScrollPhysics(),
      children: <Widget>[
        buildVideoPreview(),
        buildAppInfo(),
        buildAppDescription(),
        buildAppReviews(),
      ],
    ));
  }

  buildVideoPreview() {
    return new Container(
      height: 300,
      child: Center(
        child: new Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5), shape: BoxShape.circle),
            child: Center(
                child: new Icon(
              Icons.play_arrow,
              color: Colors.white,
              size: 50,
            ))),
      ),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(widget.data.image), fit: BoxFit.cover)),
    );
  }

  buildAppInfo() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.withOpacity(0.1))),
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(15),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text(
            "Ecommerce App",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          new SizedBox(
            height: 10,
          ),
          new Text(
            "\$${widget.data.price}",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w900, color: appRed),
          ),
          new Divider(),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(25)),
                child: new Row(
                  children: <Widget>[
                    new SizedBox(
                      width: 5,
                    ),
                    new Text(
                      "${widget.data.rating}",
                      style: TextStyle(color: Colors.white),
                    ),
                    new SizedBox(
                      width: 15,
                    ),
                    new Icon(
                      Icons.star,
                      color: Colors.white,
                      size: 20,
                    ),
                    new SizedBox(
                      width: 5,
                    ),
                  ],
                ),
              ),
              new Text("1442 Downloads")
            ],
          )
        ],
      ),
    );
  }

  buildAppDescription() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.withOpacity(0.1))),
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(15),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text(
            "Description",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          new SizedBox(
            height: 10,
          ),
          new Text(
            dummyDescription,
            maxLines: 8,
            overflow: TextOverflow.ellipsis,
            style:
                TextStyle(fontSize: 15, color: Colors.black.withOpacity(0.7)),
          ),
          new SizedBox(
            height: 10,
          ),
          Center(
            child: new Text(
              "View More",
              style: TextStyle(
                  fontSize: 15, color: appRed, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }

  buildAppReviews() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.withOpacity(0.1))),
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.only(left: 15, top: 15, bottom: 15),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Text(
                "Reviews",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              new GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => AppReviews()));
                },
                child: Row(
                  children: <Widget>[
                    new Text(
                      "See all",
                      style: TextStyle(color: appRed, fontSize: 16),
                    ),
                    new Icon(
                      Icons.navigate_next,
                      color: appRed,
                    )
                  ],
                ),
              ),
            ],
          ),
          new SizedBox(
            height: 10,
          ),
          new Row(
            children: <Widget>[
              new SmoothStarRating(
                allowHalfRating: true,
                onRatingChanged: (v) {},
                starCount: 5,
                rating: widget.data.rating,
                size: 20.0,
                color: Colors.green,
                borderColor: Colors.green,
              ),
              new SizedBox(
                width: 10,
              ),
              new Text("8 Reviews")
            ],
          ),
          new SizedBox(
            height: 10,
          ),
          new Divider(),
          new ListView.separated(
            itemCount: 4,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(
              left: 10,
            ),
            itemBuilder: (context, index) {
              return ReviewBuilder();
            },
            separatorBuilder: (BuildContext context, int index) {
              return new Divider();
            },
          )
        ],
      ),
    );
  }

  buildActions() {
    return new Container(
      height: 60,
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 5),
      color: Colors.white,
      child: new Row(
        children: <Widget>[
          new Container(
            padding: EdgeInsets.all(12),
            margin: EdgeInsets.all(5),
            child: Center(
                child: new Icon(
              OMIcons.addShoppingCart,
              size: 20,
            )),
            decoration:
                BoxDecoration(border: Border.all(color: appBG, width: 1)),
          ),
          new Container(
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(12),
            child: Center(
                child: new Icon(
              OMIcons.chat,
              size: 20,
            )),
            decoration:
                BoxDecoration(border: Border.all(color: appBG, width: 1)),
          ),
          new Flexible(
              child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 2),
            child: new RaisedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => PaymentDetails()));
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              color: appColor,
              child: Center(
                child: new RichText(
                  text: TextSpan(children: [
                    new TextSpan(text: "Pay  "),
                    new TextSpan(
                        text: "\$${widget.data.price}",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ]),
                ),
              ),
            ),
          ))
        ],
      ),
    );
  }

  // TODO
  void card() async {
    final charge = Charge.card(
      amount: '2000',
      cardno: '5399838383838381',
      cvv: '470',
      email: 'ammaugost@gmail.com',
      expirymonth: '10',
      expiryyear: '22',
      pin: "3310",
      firstname: "Jeremiah",
      lastname: "Ogbomo",
      meta: [Meta("hello", "world")],
      redirectUrl: "https://rave-web.herokuapp.com/receivepayment",
    );

    final chargeResp = await charge.charge();
    print("Response  ${chargeResp.data.chargeResponseMessage}");
    print("Response  ${chargeResp.data.chargeResponseCode}");
    print("txRef  ${chargeResp.data.txRef}");
    print("Success  ${chargeResp.isSuccess}");

    if (chargeResp.isSuccess == true) {
      final validate =
          await Validate().card(txRef: chargeResp.data.txRef, otp: "12345");
      print(validate.statusCode);
    }
  }

//  var validate =
//      await Validate().card(txRef: chargeResp.data.txRef, otp: "12345");
//  print(validate.statusCode);
// TODO
  void pin() async {
    final charge = Charge.pin(
      cardno: '5438898014560229',
      cvv: '789',
      expirymonth: '12',
      expiryyear: '21',
      amount: '2000',
      email: 'jeremiahogbomo@gmail.com',
      firstname: "Jeremiah",
      lastname: "Ogbomo",
      pin: "3310",
      redirectUrl: "https://rave-web.herokuapp.com/receivepayment",
    );

    await charge.charge();
  }

  void account() async {
    final _banks = await Banks().fetch();
    final banks = _banks.data;

    final accessBankCode = banks.first.bankcode;

    final charge = Charge.account(
      amount: '2000',
      email: 'ammaugost@gmail.com',
      firstname: "Maugost",
      lastname: "Okore",
      accountbank: accessBankCode,
      accountnumber: '0690000031',
      redirectUrl: "https://rave-web.herokuapp.com/receivepayment",
    );

    final chargeResp = await charge.charge();

    print("Response  ${chargeResp.data.chargeResponseMessage}");
    print("txRef  ${chargeResp.data.txRef}");

    final validate =
        await Validate().card(txRef: chargeResp.data.txRef, otp: "12345");
    print(validate.statusCode);
  }

  void ussd() async {
    final _banks = await Banks().fetch();
    final banks = _banks.data;

    final accessBankCode = banks.first.bankcode;

    final charge = Charge.ussd(
      amount: '2000',
      email: 'jeremiahogbomo@gmail.com',
      firstname: "Jeremiah",
      lastname: "Ogbomo",
      accountbank: accessBankCode,
      accountnumber: '0690000031',
      phonenumber: '081245554343',
      redirectUrl: "https://rave-web.herokuapp.com/receivepayment",
    );

    await charge.charge();
  }
}
