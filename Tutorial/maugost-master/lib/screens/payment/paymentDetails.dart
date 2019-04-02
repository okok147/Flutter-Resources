import 'dart:io';

import 'package:flutter/material.dart';
import 'package:maugost/constants/cardImages.dart';
import 'package:maugost/main.dart';
import 'package:maugost/rave/card.dart';
import 'package:maugost/rave/raveResponse.dart';
import 'package:maugost/rave/widget/pinWidget.dart';
import 'package:maugost/utils/colors.dart';
import 'package:maugost/utils/images.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:ravepay/ravepay.dart' as RavePay;
import 'package:ravepay/src/models/banks.dart' as RavePayBanks;
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class PaymentDetails extends StatefulWidget {
  @override
  _PaymentDetailsState createState() => _PaymentDetailsState();
}

class _PaymentDetailsState extends State<PaymentDetails> {
  int selectedPaymentType = 0;
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _autoValidate = false;
  var _formKey = GlobalKey<FormState>();
  bool _saveCardPayment = false;
  bool _saveBankPayment = false;
  String availableBanks;
  int selectedBank;
  List<RavePayBanks.Bank> banksList;

  var cardName = TextEditingController();
  var bankNum = MaskedTextController(mask: "0000000000");
  var cardNum = MaskedTextController(mask: "0000 0000 0000 0000 0000");
  var cardExp = MaskedTextController(mask: "00/00");
  var cardCVV = MaskedTextController(mask: "***");

  String cardType = CardType.unknown;

  PaymentCard paymentCard = new PaymentCard.empty();

  @override
  void initState() {
    super.initState();
    print(RavePay.Rave().baseUrl);
    fetchRavePayBanks();

    cardNum.addListener(getCardType);
  }

  getCardType() {
    int cardExpDate = cardExp.text.isEmpty
        ? 0
        : num.parse(cardExp.text.split("/")[0]).toInt();
    int cardExpYr = cardExp.text.isEmpty
        ? 0
        : num.parse(cardExp.text.split("/")[1]).toInt();
    paymentCard = PaymentCard(
        name: cardName.text,
        number: cardNum.text,
        cvc: cardCVV.text,
        expiryMonth: cardExpDate,
        expiryYear: cardExpYr);
    cardType = paymentCard.getTypeForIIN(cardNum.text);

    if (mounted) setState(() {});
  }

  buildCardImageType() {
    if (cardType == CardType.verve) {
      return Image.asset(
        CardImages.VERVE,
        height: 20,
        width: 20,
      );
    }

    if (cardType == CardType.visa) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          CardImages.VISA,
          height: 10,
          width: 10,
        ),
      );
    }

    if (cardType == CardType.masterCard) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          CardImages.MASTERCARD,
          height: 10,
          width: 10,
        ),
      );
    }

    if (cardType == CardType.americanExpress) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          CardImages.AMERICAN_EXPRESS,
          height: 10,
          width: 10,
        ),
      );
    }

    if (cardType == CardType.dinersClub) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          CardImages.DINNERS_CLUB,
          height: 10,
          width: 10,
        ),
      );
    }

    if (cardType == CardType.discover) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          CardImages.DISCOVER,
          height: 10,
          width: 10,
        ),
      );
    }

    return const Icon(
      Icons.credit_card,
      color: Colors.grey,
    );
  }

  fetchRavePayBanks() async {
    final banks = await RavePay.Banks().fetch();
    banksList = banks.data;
    if (mounted) setState(() {});
  }

  buildPaymentSummary() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
      child: new SafeArea(
        right: false,
        left: false,
        bottom: false,
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new BackButton(),
                new Text(
                  "Payment Details",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                new CircleAvatar(
                  backgroundImage: AssetImage(myPics),
                )
              ],
            ),
            new SizedBox(
              height: 10,
            ),
            new Text(
              "Summary",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            new SizedBox(
              height: 10,
            ),
            new Padding(
              padding: const EdgeInsets.only(
                left: 10,
              ),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Text(
                    "General inspection",
                    style:
                        TextStyle(fontSize: 16, color: appRed.withOpacity(0.7)),
                  ),
                  new Text(
                    "\$180.0",
                    style:
                        TextStyle(fontSize: 16, color: appRed.withOpacity(0.7)),
                  ),
                ],
              ),
            ),
            new SizedBox(
              height: 10,
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text(
                  "Total:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                new Text(
                  "\$180.0",
                  style: TextStyle(
                      fontSize: 22,
                      color: appColor,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  buildPaymentMethod() {
    return new Flexible(
        child: Container(
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
              color: appColor.withOpacity(0.1),
            ))),
            child: new ListView(
              padding:
                  EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 20),
              children: <Widget>[buildPaymentType()],
            )));
  }

  buildPaymentType() {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Text(
          "Payment Method",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        new SizedBox(
          height: 10,
        ),
        new Row(
          children: <Widget>[
            paymentTypeBuilder(
                position: 0,
                title: "Credit Card",
                onTypeSelected: onTypeSelected),
            paymentTypeBuilder(
                position: 1,
                title: "Bank Payment",
                onTypeSelected: onTypeSelected),
          ],
        ),
        new SizedBox(
          height: 10,
        ),
        _buildCardByType(),
        new SizedBox(
          height: 20,
        ),
        new RaisedButton(
          padding: EdgeInsets.all(18),
          onPressed:
              selectedPaymentType == 0 ? makeCardPayment : makeBankPayment,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: appColor,
          child: Center(
            child: new RichText(
              text: TextSpan(children: [
                new TextSpan(text: "Pay  "),
                new TextSpan(
                    text: "\$${180.0}",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ]),
            ),
          ),
        ),
        new SizedBox(
          height: 15,
        )
      ],
    );
  }

  _buildCardByType() {
    if (selectedPaymentType == 0) {
      return _buildCardBox();
    }
    return _buildBankBox();
  }

  onTypeSelected(int type) {
    setState(() {
      selectedPaymentType = type;
    });
  }

  paymentTypeBuilder(
      {int position, String title, Function(int type) onTypeSelected}) {
    return new Flexible(
        child: new GestureDetector(
      onTap: () {
        onTypeSelected(position);
      },
      child: new Container(
        margin: EdgeInsets.all(6),
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: position == selectedPaymentType ? appColor : Colors.white,
            border: Border.all(
                color: position == selectedPaymentType
                    ? appColor
                    : appColor.withOpacity(0.3))),
        child: Center(
            child: Text(
          title,
          style: TextStyle(
              color: position == selectedPaymentType
                  ? Colors.white
                  : Colors.black),
        )),
      ),
    ));
  }

  _buildCardBox() {
    return new Card(
      elevation: 5,
      child: Container(
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.all(5),
          child: Form(
            key: _formKey,
            autovalidate: _autoValidate,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _buildCardFields(),
            ),
          ),
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.87),
              borderRadius: BorderRadius.all(Radius.circular(16.0)))),
    );
  }

  _buildCardFields() {
    return <Widget>[
      TextFormField(
        controller: cardName,
        //validator: Validator.validateName,
        decoration: new InputDecoration(
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    width: 0.5, color: Colors.grey.withOpacity(0.5))),
            border: UnderlineInputBorder(
                borderSide: BorderSide(
                    width: 0.5, color: Colors.grey.withOpacity(0.1))),
            disabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    width: 0.5, color: Colors.grey.withOpacity(0.1))),
            labelText: 'Cardholder name',
            prefixIcon: const Icon(
              Icons.person_outline,
              color: Colors.grey,
            ),
            labelStyle: const TextStyle(color: Colors.black54, fontSize: 19)),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
      ),
      TextFormField(
        controller: cardNum,
        keyboardType: TextInputType.numberWithOptions(),

        //validator: Validator.validateEmail,
        decoration: new InputDecoration(
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    width: 0.5, color: Colors.grey.withOpacity(0.5))),
            border: UnderlineInputBorder(
                borderSide: BorderSide(
                    width: 0.5, color: Colors.grey.withOpacity(0.1))),
            disabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    width: 0.5, color: Colors.grey.withOpacity(0.1))),
            labelText: 'Card number',
            prefixIcon: buildCardImageType(),
            labelStyle: const TextStyle(color: Colors.black54, fontSize: 19)),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
      ),
      Row(
        children: <Widget>[
          new Flexible(
            child: new TextFormField(
              controller: cardExp,
              keyboardType: TextInputType.numberWithOptions(),
              //validator: Validator.validatePass,
              decoration: new InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          width: 0.5, color: Colors.grey.withOpacity(0.5))),
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(
                          width: 0.5, color: Colors.grey.withOpacity(0.1))),
                  disabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          width: 0.5, color: Colors.grey.withOpacity(0.1))),
                  labelText: 'Exp. date',
                  prefixIcon: const Icon(
                    Icons.timer,
                    color: Colors.grey,
                  ),
                  labelStyle:
                      const TextStyle(color: Colors.black54, fontSize: 19)),
            ),
          ),
          new SizedBox(
            width: 20,
          ),
          new Flexible(
            child: new TextFormField(
              controller: cardCVV,
              keyboardType: TextInputType.numberWithOptions(),

              //validator: Validator.validatePass,
              decoration: new InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          width: 0.5, color: Colors.grey.withOpacity(0.5))),
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(
                          width: 0.5, color: Colors.grey.withOpacity(0.1))),
                  disabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          width: 0.5, color: Colors.grey.withOpacity(0.1))),
                  labelText: 'CVC/CVV',
                  prefixIcon: const Icon(
                    Icons.help_outline,
                    color: Colors.grey,
                  ),
                  labelStyle:
                      const TextStyle(color: Colors.black54, fontSize: 19)),
            ),
          ),
        ],
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
      ),
      Padding(
        padding: const EdgeInsets.all(15),
        child: new GestureDetector(
          onTap: () {
            setState(() {
              _saveCardPayment = !_saveCardPayment;
            });
          },
          child: new Row(
            children: <Widget>[
              new Container(
                height: 20,
                width: 20,
                child: _saveCardPayment == true
                    ? new Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 15,
                      )
                    : null,
                decoration: BoxDecoration(
                    color: _saveCardPayment == true ? appColor : Colors.white,
                    border: Border.all(
                        color: Colors.grey.withOpacity(0.5), width: 2)),
              ),
              new SizedBox(
                width: 10,
              ),
              new Text(
                "Save this card for future payments",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              )
            ],
          ),
        ),
      )
    ];
  }

  _buildBankBox() {
    return new Card(
      elevation: 5,
      child: Container(
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.all(5),
          child: Form(
            key: _formKey,
            autovalidate: _autoValidate,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _buildBankFields(),
            ),
          ),
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.87),
              borderRadius: BorderRadius.all(Radius.circular(16.0)))),
    );
  }

  _buildBankFields() {
    return <Widget>[
      InkWell(
        onTap: () {
          if (banksList != null) {
            showBanksDialog();
          }
        },
        child: new Container(
          height: 50,
          margin: EdgeInsets.only(left: 15, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Flexible(
                child: new Text(
                  availableBanks ?? "Select your bank",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color:
                          availableBanks == null ? Colors.grey : Colors.black,
                      fontSize: 16),
                ),
              ),
              new Icon(
                Icons.keyboard_arrow_down,
                color: Colors.grey,
              )
            ],
          ),
        ),
      ),
      Divider(height: 3, color: Colors.grey.withOpacity(0.5)),
      TextFormField(
        controller: bankNum,
        //validator: Validator.validateName,
        keyboardType: TextInputType.numberWithOptions(),
        decoration: new InputDecoration(
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    width: 0.5, color: Colors.grey.withOpacity(0.5))),
            border: UnderlineInputBorder(
                borderSide: BorderSide(
                    width: 0.5, color: Colors.grey.withOpacity(0.1))),
            disabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    width: 0.5, color: Colors.grey.withOpacity(0.1))),
            labelText: 'Account number',
            prefixIcon: const Icon(
              Icons.account_balance,
              color: Colors.grey,
            ),
            labelStyle: const TextStyle(color: Colors.black54, fontSize: 19)),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
      ),
      Padding(
        padding: const EdgeInsets.all(15),
        child: new GestureDetector(
          onTap: () {
            setState(() {
              _saveBankPayment = !_saveBankPayment;
            });
          },
          child: new Row(
            children: <Widget>[
              new Container(
                height: 20,
                width: 20,
                child: _saveBankPayment == true
                    ? new Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 15,
                      )
                    : null,
                decoration: BoxDecoration(
                    color: _saveBankPayment == true ? appColor : Colors.white,
                    border: Border.all(
                        color: Colors.grey.withOpacity(0.5), width: 2)),
              ),
              new SizedBox(
                width: 10,
              ),
              new Text(
                "Save this account for future payments",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              )
            ],
          ),
        ),
      )
    ];
  }

  showBanksDialog() {
    showDialog(
        context: context,
        builder: (context) {
          if (Platform.isAndroid) {
            return SimpleDialog(
              children: buildBanksList(),
            );
          }
          return PlatformAlertDialog(
            actions: buildBanksList(),
          );
        });
  }

  buildBanksList() {
    return new List.generate(banksList.length, (index) {
      return new Material(
        child: new ListTile(
          onTap: () {
            setState(() {
              availableBanks = banksList[index].bankname;
              selectedBank = index;
            });
            Navigator.pop(context);
          },
          title: new Text(
            banksList[index].bankname.toUpperCase(),
            style: TextStyle(fontSize: 15),
          ),
        ),
      );
    });
  }

  void makeCardPayment() async {
//    final charge = RavePay.Charge.card(
//      amount: '2000',
//      cardno: paymentCard.number,
//      cvv: '470',
//      email: 'ammaugost@gmail.com',
//      expirymonth: paymentCard.expiryMonth.toString(),
//      expiryyear: paymentCard.expiryYear.toString(),
//      firstname: paymentCard.name.split(" ")[0],
//      lastname: paymentCard.name.split(" ")[1],
//      meta: [RavePay.Meta("hello", "world")],
//      redirectUrl: "https://rave-web.herokuapp.com/receivepayment",
//    );

    final charge = RavePay.Charge.card(
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

    final chargeResp = await charge.charge();
    print("ResponseMessage  ${chargeResp.data.chargeResponseMessage}");
    print("Response  ${chargeResp.data.chargeResponseCode}");
    print("txRef  ${chargeResp.data.txRef}");
    print("Success  ${chargeResp.isSuccess}");

    String chargeRespMSG = chargeResp.data.chargeResponseMessage;
    String chargeRespCode = chargeResp.data.chargeResponseCode;
    String chargeAuth = chargeResp.data.authModelUsed;

    print(chargeAuth);

    if (chargeRespCode == ResponseCode.VALIDATION) {
//      String codeResponse = await showCodeScreen(
//          responseMessage: chargeResp.data.chargeResponseMessage);
//      if (codeResponse != null) {
//        final validate = await RavePay.Validate()
//            .card(txRef: chargeResp.data.txRef, otp: codeResponse);
//        print(validate.statusCode);
//      }
    }
  }

  void makeBankPayment() async {
    print(RavePay.Rave().baseUrl);
    final charge = RavePay.Charge.account(
      amount: '2000',
      email: 'ammaugost@gmail.com',
      firstname: "Maugost",
      lastname: "Okore",
      accountbank: banksList[selectedBank].bankcode,
      accountnumber: "0690000031",
      redirectUrl: "https://rave-web.herokuapp.com/receivepayment",
    );

    final chargeResp = await charge.charge();

    print("Response  ${chargeResp.data.chargeResponseMessage}");
    print("txRef  ${chargeResp.data.txRef}");

    String chargeRespMSG = chargeResp.data.chargeResponseMessage;
    String chargeRespCode = chargeResp.data.chargeResponseCode;
    String chargeAuth = chargeResp.data.authModelUsed;

    if (chargeRespCode == ResponseCode.VALIDATION) {
      final validate = await RavePay.Validate()
          .account(txRef: chargeResp.data.txRef, otp: "12345");
      print(
          "Validation MSG ${validate.body}  Validation Error ${validate.statusCode}");
    }
  }

  showCodeScreen({String responseMessage, bool OTP}) async {
    return await Navigator.push(context, new PageRouteBuilder(pageBuilder:
        (BuildContext context, Animation animation,
            Animation secondaryAnimation) {
      return new Material(
          color: Colors.transparent,
          child: PinScreen(
            title: responseMessage,
            subTitle: "",
            isOTP: OTP,
          ));
    }));
  }

  showAlertDialog() {
    Alert(
            context: context,
            title: "Successful",
            desc: "Thank You Your Payment Successful.")
        .show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Column(
        children: <Widget>[buildPaymentSummary(), buildPaymentMethod()],
      ),
    );
  }
}
