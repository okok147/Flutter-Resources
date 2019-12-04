import 'dart:async';
import 'dart:convert';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
//import 'package:flutter_places_dialog/flutter_places_dialog.dart';
import 'package:intl/intl.dart';
import 'package:lets_meet_flutter/main.dart';
import 'package:lets_meet_flutter/util/Global.dart';
import 'package:lets_meet_flutter/util/country.dart';
// import 'package:flutter_chameleon/flutter_chameleon.dart';
import 'package:lets_meet_flutter/util/countryPicker.dart';
import 'package:lets_meet_flutter/widget.dart';
import 'package:place_picker/place_picker.dart';

class ProfileForms {
  static
  const Text = 0;
  static
  const Date = 1;
  static
  const Location = 2;
  static
  const Country = 3;
  static
  const Choice = 4;
  static
  const TwoChoice = 5;
  static
  const Number = 6;
  static
  const Email = 7;

}

class ProfileForm {
  Map < String, dynamic > DATA = new Map < String, dynamic > ();


  String toJSON() {
    return json.encode(DATA);
  }

  ProfileField textField({
    @required IconData icon,
    @required String tag,
    String hint,
    String title
  }) {
    return ProfileField(icon: icon, tag: tag, src: this, value: DATA[tag], TYPE: ProfileForms.Text, hint: hint, title: title, );
  }

  ProfileField dateField({
    @required IconData icon,
    @required String tag,
    String hint,
    String title
  }) {
    return ProfileField(icon: icon, tag: tag, src: this, value: DATA[tag], TYPE: ProfileForms.Date, hint: hint, title: title, );
  }

  ProfileField locationField({
    @required IconData icon,
    @required String tag,
    String hint,
    String title
  }) {
    return ProfileField(icon: icon, tag: tag, src: this, value: DATA[tag], TYPE: ProfileForms.Location, hint: hint, title: title, );
  }


  ProfileField countryFiled({
    @required IconData icon,
    @required String tag,
    String hint,
    String title
  }) {
    return ProfileField(icon: icon, tag: tag, src: this, value: DATA[tag], TYPE: ProfileForms.Country, hint: hint, title: title, );
  }

  ProfileField choiceField({
    @required IconData icon,
    @required String tag,
    @required List < String > choices,
    String hint,
    String title
  }) {
    return ProfileField(icon: icon, tag: tag, src: this, value: DATA[tag], TYPE: ProfileForms.Choice, hint: hint, title: title, choice: choices, );
  }

  ProfileField numberField({
    @required IconData icon,
    @required String tag,
    String hint,
    String title
  }) {
    return ProfileField(icon: icon, tag: tag, src: this, value: DATA[tag], TYPE: ProfileForms.Number, hint: hint, title: title, );
  }

  ProfileField emailField({
    @required IconData icon,
    @required String tag,
    String hint,
    String title
  }) {
    return ProfileField(icon: icon, tag: tag, src: this, value: DATA[tag], TYPE: ProfileForms.Email, hint: hint, title: title, );
  }



}




class ProfileField extends StatefulWidget {
  final IconData icon;
  final String tag;
  final ProfileForm src;
  final int TYPE;
  final String hint;
  final String title;
  final List < String > choice;

  String value;


  ProfileField({
    Key key,
    this.icon,
    this.tag,
    this.value,
    this.src,
    this.TYPE,
    this.hint: "",
    this.title: "",
    this.choice
  }): super(key: key);

  @override
  _ProfileFormState createState() => _ProfileFormState();
}







class _ProfileFormState extends State < ProfileField > {
  void setValue(dynamic s) {
    if (this.mounted) {
      widget.src.DATA[widget.tag] = s;
      if(this.mounted){
        setState(() {
        widget.value = s.toString();
      });
      }
    }
  }




  void showChoice() {
    _rt = widget.value;
    showModalBottomSheet < void > (
      context: context,
      builder: (BuildContext context) {
        return _buildBottomPicker(_buildColorPicker());
      },
    );

  }

  showPlacePicker() async {
    try{
      //var place = await PluginGooglePlacePicker.showAutocomplete();
      var place = await showRealPlacePicker(context);
      // print("place is $place");
      if (!mounted)
        return;
      if(place != null){
        if(widget.tag == "WorkLocation"){
          await Request.getDio().patch("/me/update", data: {
            "user": {
              widget.tag: place.formattedAddress == null ? _rt : place.formattedAddress,
            }
          }); 
        }else if(widget.tag == "LiveLocation"){
          await Request.getDio().patch("/me/update", data: {
            "user": {
              widget.tag: place.formattedAddress == null ? _rt : place.formattedAddress,
              "Longitude": place.latLng.longitude,
              "Latitude": place.latLng.latitude,
            }
          }); 
        }
        setValue(place.formattedAddress);
      }
    }catch(e){}
  }


  Future getCountry() async {
    // CountryPicker cp = new CountryPicker(onChanged: (Country value) {
    //   print(value);
    // },);
    // Country country =  await cp.showCountryPicker( context: context, defaultCountry: Country.HK);
    // var response = await Request.getDio().patch("/me/update",data: {"user":{widget.tag: country.name}});
    // setValue(country.name);
    String ans = await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Choose_Country(),
        );
      }
    );
    if(ans != null){
      var response = await Request.getDio().patch("/me/update", data: {
        "user": {
          widget.tag: ans == null ? _rt : ans
        }
      });
      
      setValue(ans);
    }
  }

  

  Widget _buildBottomPicker(Widget picker) {
    return
    new Container(
      height: 200.0,
      color: CupertinoColors.white,
      child: Scaffold(
        appBar: AppBar(leading: FlatButton(child: Text(""), onPressed: () {},

          ),
          actions: < Widget > [FlatButton(child: Text("OK"), onPressed: () async {
            int value;
            if (widget.tag == "Gender") {
              if (_rt == "Male") {
                value = 1;
              } else if (_rt == "Female") {
                value = 2;
              }
            } else if (widget.tag == "Marital") {
              if (_rt == "single") {
                value = 1;
              } else if (_rt == "married") {
                value = 2;
              }
            }
            await Request.getDio().patch("/me/update", data: {
              "user": {
                widget.tag: value == null ? _rt : value
              }
            });
            _rt != null ? setValue(_rt) : setValue("-");
            Navigator.pop(context);
          }, ), ],
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),

        body: new DefaultTextStyle(
          style: const TextStyle(
              color: CupertinoColors.black,
              fontSize: 22.0,
            ),
            child: new GestureDetector(
              // Blocks taps from propagating to the modal sheet and popping.
              onTap: () {},
              child: new SafeArea(
                child: picker,
              ),
            ),
        ),
      ),
    );

  }
  String _rt;
  Widget _buildColorPicker() {
    final FixedExtentScrollController scrollController =
      new FixedExtentScrollController(initialItem: widget.value == null ? 0 : widget.choice.indexOf(widget.value));

    // _rt = widget.value;
    return new CupertinoPicker(
      scrollController: scrollController,
      itemExtent: 42.0,
      backgroundColor: CupertinoColors.white,
      onSelectedItemChanged: (int index) {
        if (this.mounted) {
          setState(() {
            _rt = widget.choice[index];
            // _selectedColorIndex = index;
          });
        }
      },
      children: new List < Widget > .generate(widget.choice.length, (int index) {
        return new Center(child:
          new Text(widget.choice[index]),
        );
      }),
    );
  }



  Future < Null > _selectDate(BuildContext context) async {
    // final DateTime picked = await showDatePicker(
    //   context: context,
    //   initialDate: new DateTime(1991, 3),
    //   firstDate: new DateTime(1900, 8),
    //   lastDate: new DateTime.now(),
    // );
    // if(picked != null){
      //     await Request.getDio().patch("/me/update", data: {
      // "user": {
      //   widget.tag: picked.toString()
      // }
    // });
    // setValue(new DateFormat('yyyy-MM-dd').format(picked));
    // }
    DateTime now = new DateTime.now();
    // DatePicker.showDatePicker(
    //   context,
    //   showTitleActions: true,
    //   locale: 'en',
    //   minYear: 1970,
    //   maxYear: 2020,
    //   initialYear: now.year,
    //   initialMonth: now.month,
    //   initialDate: now.day,
    //   cancel: Text('Cancel'),
    //   confirm: Text('Confirm'),
    //   dateFormat: 'mmmm-dd',
    //   onConfirm: (year, month, date) async {
    //     String value = month_to_word(month) + ' ' + date.toString();
    //     setValue(value);
    //        await Request.getDio().patch("/me/update", data: {
    //   "user": {
    //     widget.tag: value
    //   }
    // });
    //   },
    // );
  }

  String month_to_word(int month){
    switch (month){
      case 1: return "January" ;
      case 2: return "February" ;
      case 3: return "March" ;
      case 4: return "April" ;
      case 5: return "May>" ;
      case 6: return "June" ;
      case 7: return "July" ;
      case 8: return "August" ;
      case 9: return "September" ;
      case 10: return "October" ;
      case 11: return "November" ;
      case 12: return "December" ;

    }
    
  }


  void _showChoice() {}
  _showPhoneDialog() async {
    var _rs = "";
    var _countryCode;
    await showDialog < String > (
      context: context,
      child: new AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        title: CountryCodePicker(
          initialSelection: 'HK',
          onChanged: (countryCode){
            _countryCode = countryCode.dialCode.toString() + ' ';
          },
        ),
          content: new Row(
            children: < Widget > [
              Expanded(
                child: TextField(
                  autocorrect: false,
                  keyboardType: TextInputType.number,
                  onChanged: (String s) {
                    _rs = s;
                  },
                  decoration: new InputDecoration(
                    labelText: widget.title, hintText: widget.hint),
                ),
              )
            ],
          ),
          actions: < Widget > [
            new FlatButton(
              child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.pop(context);
                }),
            new FlatButton(
              child: const Text('OK'),
                onPressed: () async {
                  Navigator.pop(context);
                  if (_rs != null && _rs != "") {
                    _rs = _countryCode + _rs;
                    var response = await Request.getDio().patch("/me/update", data: {
                      "user": {
                        widget.tag: _rs 
                      }
                    }
                    );
                    setValue(_rs);
                  }
                })
          ],
      ),
    );
  }

  _showDialog(TextInputType type) async {
    var _rs = "";
    await showDialog < String > (
      context: context,
      child: new AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
          content: new Row(
            children: < Widget > [
              new Expanded(
                child: new TextField(
                  autocorrect: false,
                  keyboardType: type,
                  autofocus: true,
                  onChanged: (String s) {
                    _rs = s;
                  },
                  decoration: new InputDecoration(
                    labelText: widget.title, hintText: widget.hint),
                ),
              )
            ],
          ),
          actions: < Widget > [
            new FlatButton(
              child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.pop(context);
                }),
            new FlatButton(
              child: const Text('OK'),
                onPressed: () async {
                  Navigator.pop(context);
                  if (_rs != null && _rs != "") {
                    var response = await Request.getDio().patch("/me/update", data: {
                      "user": {
                        widget.tag: _rs
                      }
                    });
                    setValue(_rs);
                  }
                })
          ],
      ),
    );
  }


  void bText() {
    _showDialog(TextInputType.text);
  }

  void bNumber() {
    // _showDialog(TextInputType.phone);
    _showPhoneDialog();
  }

  void bEmail() {
    _showDialog(TextInputType.emailAddress);
  }
  void bDate() {
    _showDialog(TextInputType.datetime);
  }





  void editFunction() {
    if (widget.TYPE == ProfileForms.Text) {
      bText();
    }
    if (widget.TYPE == ProfileForms.Date) {
      _selectDate(context);
    }
    if (widget.TYPE == ProfileForms.Location) {
      showPlacePicker();
    }
    if (widget.TYPE == ProfileForms.Country) {
      getCountry();

    }
    if (widget.TYPE == ProfileForms.Choice) {
      showChoice();

    }
    if (widget.TYPE == ProfileForms.Number) {
      bNumber();
    }
    if (widget.TYPE == ProfileForms.Email) {
      bEmail();
    }

    return null;


  }



  @override
  Widget build(BuildContext context) {
    bool canEdit = Theme.of(context).splashColor == Colors.white;
    if (widget.value == null && !canEdit) return Container();
    if (widget.value == null) {
      return Container(
        child: FlatButton(
          padding: EdgeInsets.all(0.0),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 14.6),
              child: Row(
                children: < Widget > [
                  Padding(
                    padding: const EdgeInsets.only(left: 22.2),
                      child: Icon(widget.icon, color: Color(0xff999999),size: 24.0,),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.1),
                      child: Text("-", style: Global.style_profile, softWrap: true,),
                  )
                ],
              ),
          ), onPressed: () {
            editFunction();
          },
        ),
      );
    }
    return Container(
      child: FlatButton(
        padding: EdgeInsets.only(right: 10.5),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 0.0),
            child: Row(
              children: < Widget > [
                Padding(
                  padding: const EdgeInsets.only(left: 22.2),
                    child: Icon(widget.icon,color: Color(0xff999999), 
                    size: 24.0,
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25.1),
                      child: Text(widget.value,  style: Global.style_profile, softWrap: true, ),
                  ),
                )
              ],
            ),
        ), onPressed: () {
          editFunction();
        },
      ),
      // child: ListTile(leading: Icon(widget.icon), title: Text(widget.value, style: Global.style_profile, ), onTap: () {
      //   editFunction();
      // }, ),
    );
  }
}