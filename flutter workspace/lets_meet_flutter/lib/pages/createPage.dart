import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lets_meet_flutter/main.dart';
import 'package:lets_meet_flutter/pages/loginPage_new.dart';
import 'package:lets_meet_flutter/util/Flutter_1101.dart';
import 'package:lets_meet_flutter/util/GIcons.dart';
import 'package:lets_meet_flutter/util/Global.dart';
import 'package:lets_meet_flutter/util/flutter_0824_icons.dart';
import 'package:lets_meet_flutter/util/flutter_0917_icons.dart';
import 'package:lets_meet_flutter/util/my_flutter_app_icons.dart';
import 'package:lets_meet_flutter/widget.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';

class CreatePage extends StatefulWidget {
  final int categoryID;
  final int edit_id;

  const CreatePage({Key key, this.categoryID, this.edit_id}) : super(key: key);
  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final _meetupformKey = GlobalKey<FormState>();
  CreateForm createForm;
  DateTime _dateTime;
  List<dynamic> typeName;
  String selectedType;
  String categoryName;
  Widget showedForm;
  bool isLoading = false;
  String html = "Loading...";
  Map<String, dynamic> meet = new Map<String, dynamic>();

  Future getTypeList() async {
    var response = await Request.getDio()
        .get("typeList/get", data: {"category_ID": widget.categoryID});
    typeName = response.data["Data"];
    if (widget.categoryID == 1) {
      showedForm = Meet_Form(
        isEdit: widget.edit_id == null ? false : true,
        meetupformKey: _meetupformKey,
        createForm: createForm,
        typeName: typeName,
        onPressed: onPressed,
      );
    } else if (widget.categoryID == 2) {
      showedForm = Book_Form(
          isEdit: widget.edit_id == null ? false : true,
          meetupformKey: _meetupformKey,
          createForm: createForm,
          typeName: typeName,
          onPressed: onPressed);
    } else if (widget.categoryID == 3) {
      showedForm = Volunteer_Form(
        isEdit: widget.edit_id == null ? false : true,
        meetupformKey: _meetupformKey,
        createForm: createForm,
        typeName: typeName,
        onPressed: onPressed,
      );
    }
    if (this.mounted) {
      setState(() {});
    }
  }

  Future uploadPhoto(int id, List<dynamic> image_list) async {
    FormData formdata = new FormData.from({"ID": id});
    for (int i = 0; i < image_list.length; i++) {
      formdata.add("icon_$i", new UploadFileInfo(image_list[i], "icon_$i.jpg"));
    }
    formdata.add("length", image_list.length);
    var response =
        await Request.uploadFile().post("event/upload/image", data: formdata);
    if (response.data["Code"] == 200) {
      if (this.mounted) {
        setState(() {});
      }
    } else {
      showDialog(
          context: context,
          child: AlertDialog(
            content: Text("Failed to upload Photo"),
          ));
    }
  }

  Future getMeet() async {
    Response response =
        await Request.getDio().get("meet/get", data: {"ID": widget.edit_id});
    if (this.mounted) {
      setState(() {
        meet = response.data["Data"];
        meet.forEach((key, value) => createForm.DATA[key] = value);
      });
    }
  }

  Future init_createForm() async {
    // print("testing2");
    if (widget.edit_id != null) {
      await getMeet();
      print("testing");
      // print(createForm.DATA["EndDate"]);
      // print(createForm.DATA["EndDate"].split(" ")[0]);
      createForm.DATA["FinishDate"] = createForm.DATA["EndDate"].split(" ")[0];
    }
    getTypeList();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createForm = new CreateForm();
    categoryName = getTitleName(widget.categoryID);
    init_createForm();
  }

  String getTitleName(categoryID) {
    if (categoryID == 1) {
      return widget.edit_id == null ? "Create Meet Group" : "Edit Meet";
    } else if (categoryID == 2) {
      return widget.edit_id == null ? "Create Venue to Book" : "Edit Venue";
    } else if (categoryID == 3) {
      return widget.edit_id == null
          ? "Create Volunteer Group"
          : "Edit Voltuneer";
    }
  }

  void showChoice() {
    final FixedExtentScrollController scrollController =
        new FixedExtentScrollController(initialItem: 0);
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
            child: Container(
                height: 150.0,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: CupertinoPicker(
                  scrollController: scrollController,
                  itemExtent: 32.0,
                  children:
                      new List<Widget>.generate(typeName.length, (int index) {
                    return new Center(
                      child: new Text(typeName[index]),
                    );
                  }),
                  onSelectedItemChanged: (int index) {
                    if (this.mounted) {
                      setState(() {
                        selectedType = typeName[index];
                      });
                    }
                  },
                )));
      },
    );
  }

  Future onPressed() async {
    if (widget.edit_id == null) {
      if (_meetupformKey.currentState.validate()) {
        if (createForm.DATA["Type"] == null) {
          showDialog(
              context: context,
              child: AlertDialog(
                content: Text("You need to fill up the Type Button"),
              ));
        } else if (createForm.DATA["Longitude"] == null ||
            createForm.DATA["Latitude"] == null) {
          showDialog(
              context: context,
              child: AlertDialog(
                content: Text("Please use the picker to choose location"),
              ));
        } else {
          setState(() {
            isLoading = true;
          });
          if (createForm.DATA["Hour_Start"] != null &&
              createForm.DATA["Hour_End"] != null) {
            createForm.DATA["Hour"] = createForm.DATA["Hour_Start"] +
                "-" +
                createForm.DATA["Hour_End"];
          }
          var response = await Request.getDio().post("meetup/create", data: {
            "meet_post": {
              "EventName": createForm.DATA["EventName"],
              "Price": createForm.DATA["Price"],
              "Location": createForm.DATA["Location"],
              "ContactInfo": createForm.DATA["ContactInfo"],
              "Contact_Person": createForm.DATA["Contact_Person"],
              "Description": createForm.DATA["Description"],
              "Time": createForm.DATA["Time"],
              "EndTime": createForm.DATA["EndTime"],
              // "Date": createForm.DATA["Date"],
              "StartDate": createForm.DATA["StartDate"],
              "FinishDate": createForm.DATA["FinishDate"],
              "Type": createForm.DATA["Type"],
              "Size": createForm.DATA["Size"],
              "Capacity": createForm.DATA["Capacity"],
              "Seat": createForm.DATA["Seat"],
              "Hour": createForm.DATA["Hour"],
              "Equipment": createForm.DATA["Equipment"],
              "CategoryID": widget.categoryID,
              "Host_ID": Global.selected_host_id,
              "Longitude": createForm.DATA["Longitude"],
              "Latitude": createForm.DATA["Latitude"],
            }
          });
          if (createForm.DATA.containsKey("Photo")) {
            await uploadPhoto(
                response.data["Data"]["ID"], createForm.DATA["Photo"]);
          }
          setState(() {
            isLoading = false;
          });
          Navigator.pop(context);
        }
      }
    } else {
      if (_meetupformKey.currentState.validate()) {
        setState(() {
          isLoading = true;
        });
        if (createForm.DATA.containsKey("Photo")) {
          var tmp = createForm.DATA["Photo"];
          createForm.DATA.remove("Photo");
          print(createForm.DATA);
          await Request.getDio().post("meetup/edit", data: createForm.DATA);
          createForm.DATA["Photo"] = tmp;
          await uploadPhoto(createForm.DATA["ID"], createForm.DATA["Photo"]);
          createForm.DATA.remove("Photo");
        } else {
          await Request.getDio().post("meetup/edit", data: createForm.DATA);
        }

        setState(() {
          isLoading = false;
        });

        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.light(),
      child: isLoading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Scaffold(
              appBar: AppBar(
                title: Text(
                  "$categoryName",
                  style: TextStyle(
                    fontFamily: "HelveticaNeue",
                    color: Colors.black,
                    fontSize: 17.0,
                  ),
                  overflow: TextOverflow.clip,
                ),
                centerTitle: true,
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                leading: Padding(
                    padding: const EdgeInsets.only(right: 18.0),
                    child: IconButton(
                      icon: Icon(
                        Icons.keyboard_arrow_left,
                        color: Colors.black,
                        size: 40.0,
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          child: AlertDialog(
                            contentPadding: const EdgeInsets.all(16.0),
                            content: new Row(
                              children: <Widget>[
                                Text("Do you want to discard?")
                              ],
                            ),
                            actions: <Widget>[
                              new FlatButton(
                                  child: const Text('CANCEL'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  }),
                              new FlatButton(
                                  child: const Text('OK'),
                                  onPressed: () async {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  })
                            ],
                          ),
                        );
                      },
                    )),
              ),
              body: isLoading == true ||
                      (createForm.DATA.isEmpty == true &&
                          widget.edit_id != null)
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : showedForm,
            ),
    );
  }
}

class Volunteer_Form extends StatelessWidget {
  const Volunteer_Form({
    Key key,
    @required GlobalKey<FormState> meetupformKey,
    @required this.createForm,
    @required this.typeName,
    @required this.onPressed,
    this.isEdit,
  })  : _meetupformKey = meetupformKey,
        super(key: key);

  final GlobalKey<FormState> _meetupformKey;
  final CreateForm createForm;
  final List typeName;
  final VoidCallback onPressed;
  final bool isEdit;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _meetupformKey,
      child: Padding(
        padding: const EdgeInsets.only(left: 24.0, right: 24.0),
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                createForm.create_picker(
                  picker_title: isEdit
                      ? Global.get_type_name_by_id(
                          int.parse(createForm.DATA["TypeID"].toString()))
                      : "Category",
                  typeName: typeName,
                  tag: "Type",
                  title: "Category",
                  isCompulsory: true,
                ),
                createForm.create_input(
                  title: "Volunteer Group Name",
                  hint_text: "Volunteer Group Name",
                  icon: GIcons.volunter,
                  tag: "EventName",
                  isCompulsory: true,
                ),
                createForm.create_google_picker(
                    icon: GIcons.location,
                    hint_text: "Location",
                    tag: "Location",
                    title: "Choose the location",
                    isCompulsory: true),
                // createForm.create_input(
                //   title: "Enter the specific address",
                //   hint_text: "Address",
                //   icon: GIcons.kgocation,
                //   tag: "Location",
                //   isCompulsory: true,
                // ),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: createForm.create_datePicker(
                          title: "Starting Date",
                          hint_text: "Date",
                          icon: MyFlutterApp.add____2,
                          tag: "StartDate",
                          isCompulsory: true,
                          initialValue: isEdit
                              ? createForm.DATA["MeetDate"].split(" ")[0]
                              : null),
                    ),
                    Expanded(
                      flex: 1,
                      child: createForm.create_timePicker(
                          title: "From",
                          hint_text: "From",
                          tag: "Time",
                          icon: MyFlutterApp.add____2,
                          isCompulsory: true,
                          initialValue: isEdit
                              ? createForm.DATA["MeetDate"]
                                  .split(" ")[1]
                                  .substring(0, 5)
                              : null),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: createForm.create_datePicker(
                          title: "Ending Date",
                          hint_text: "Date",
                          icon: MyFlutterApp.add____2,
                          tag: "FinishDate",
                          isCompulsory: true,
                          initialValue: isEdit
                              ? createForm.DATA["EndDate"].split(" ")[0]
                              : null),
                    ),
                    Expanded(
                        flex: 1,
                        child: createForm.create_timePicker(
                            title: "To",
                            hint_text: "To",
                            tag: "EndTime",
                            icon: Flutter_1101.add____5,
                            isCompulsory: true,
                            initialValue: isEdit
                                ? createForm.DATA["EndDate"]
                                    .split(" ")[1]
                                    .substring(0, 5)
                                : null)),
                  ],
                ),
                createForm.create_input(
                  title: "Cost",
                  hint_text: "Any charges to Volunteer",
                  icon: MyFlutterApp.add____1,
                  tag: "Price",
                ),
                createForm.create_input(
                  title: "Contact Number",
                  hint_text: "Phone Number",
                  icon: GIcons.phone,
                  tag: "ContactInfo",
                ),
                createForm.create_input(
                  title: "Contact Person",
                  hint_text: "Name of Contact Person",
                  icon: GIcons.profile,
                  tag: "Contact_Person",
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 44.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      createForm.create_textarea(
                        title: "Description",
                        icon: GIcons.description,
                        hint_text:
                            "Description of Activity or Any Special Requirements to Volunteer",
                        tag: "Description",
                      ),
                    ],
                  ),
                ),
                createForm.create_upload(
                  title: "Upload Photos (max.4)",
                  icon: GIcons.add,
                  tag: "Photo",
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 48.9),
                  child: Center(
                    child: FullWidthButton(
                      isEdit == false ? "Apply" : "Edit",
                      onPressed: onPressed,
                      color: Colors.grey,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Meet_Form extends StatelessWidget {
  const Meet_Form({
    Key key,
    @required GlobalKey<FormState> meetupformKey,
    @required this.createForm,
    @required this.typeName,
    @required this.onPressed,
    this.isEdit,
  })  : _meetupformKey = meetupformKey,
        super(key: key);

  final GlobalKey<FormState> _meetupformKey;
  final CreateForm createForm;
  final List typeName;
  final VoidCallback onPressed;
  final bool isEdit;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _meetupformKey,
      child: Padding(
        padding: const EdgeInsets.only(left: 24.0, right: 24.0),
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                createForm.create_picker(
                    picker_title: isEdit
                        ? Global.get_type_name_by_id(
                            int.parse(createForm.DATA["TypeID"].toString()))
                        : "Category",
                    typeName: typeName,
                    tag: "Type",
                    title: "Category",
                    isCompulsory: true),
                createForm.create_input(
                    title: "Meet Group Name",
                    hint_text: "meet Group Name",
                    icon: GIcons.meet,
                    tag: "EventName",
                    isCompulsory: true),
                createForm.create_google_picker(
                    icon: GIcons.location,
                    hint_text: "Location",
                    tag: "Location",
                    title: "Choose the location",
                    isCompulsory: true),
                // createForm.create_input(
                //   title: "Enter the specific address",
                //   hint_text: "Address",
                //   icon: GIcons.location,
                //   tag: "Location",
                //   isCompulsory: true,
                // ),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: createForm.create_datePicker(
                          title: "Starting Date",
                          hint_text: "Date",
                          icon: MyFlutterApp.add____2,
                          tag: "StartDate",
                          isCompulsory: true,
                          initialValue: isEdit
                              ? createForm.DATA["MeetDate"].split(" ")[0]
                              : null),
                    ),
                    Expanded(
                      flex: 1,
                      child: createForm.create_timePicker(
                          title: "From",
                          hint_text: "From",
                          tag: "Time",
                          icon: MyFlutterApp.add____2,
                          isCompulsory: true,
                          initialValue: isEdit
                              ? createForm.DATA["MeetDate"]
                                  .split(" ")[1]
                                  .substring(0, 5)
                              : null),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: createForm.create_datePicker(
                          title: "Ending Date",
                          hint_text: "Date",
                          icon: MyFlutterApp.add____2,
                          tag: "FinishDate",
                          isCompulsory: true,
                          initialValue: isEdit
                              ? createForm.DATA["EndDate"].split(" ")[0]
                              : null),
                    ),
                    Expanded(
                        flex: 1,
                        child: createForm.create_timePicker(
                            title: "To",
                            hint_text: "To",
                            tag: "EndTime",
                            icon: Flutter_1101.add____5,
                            isCompulsory: true,
                            initialValue: isEdit
                                ? createForm.DATA["EndDate"]
                                    .split(" ")[1]
                                    .substring(0, 5)
                                : null)),
                  ],
                ),
                createForm.create_input(
                  title: "Cost",
                  hint_text: "Any charges to join",
                  icon: MyFlutterApp.add____1,
                  tag: "Price",
                ),
                createForm.create_input(
                  title: "Contact Number",
                  hint_text: "Phone Number",
                  icon: GIcons.phone,
                  tag: "ContactInfo",
                ),
                createForm.create_input(
                  title: "Contact Person",
                  hint_text: "Name of Contact Person",
                  icon: GIcons.profile,
                  tag: "Contact_Person",
                ),
                // createForm.create_input(title: "Location", hint_text: "Location", icon: GIcons.location, tag: "Location", ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 44.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      createForm.create_textarea(
                        title: "Description of Activity",
                        icon: GIcons.description,
                        hint_text:
                            "Description of Activity or Any Special Requirements to join",
                        tag: "Description",
                      ),
                    ],
                  ),
                ),
                createForm.create_upload(
                  title: "Upload Photos (max.4)",
                  icon: GIcons.add,
                  tag: "Photo",
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 48.9),
                  child: Center(
                    child: FullWidthButton(
                      isEdit == false ? "Apply" : "Edit",
                      onPressed: onPressed,
                      color: Colors.grey,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Book_Form extends StatelessWidget {
  const Book_Form({
    Key key,
    @required GlobalKey<FormState> meetupformKey,
    @required this.createForm,
    @required this.typeName,
    @required this.onPressed,
    this.isEdit,
  })  : _meetupformKey = meetupformKey,
        super(key: key);

  final GlobalKey<FormState> _meetupformKey;
  final CreateForm createForm;
  final List typeName;
  final VoidCallback onPressed;
  final bool isEdit;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _meetupformKey,
      child: Padding(
        padding: const EdgeInsets.only(left: 24.0, right: 24.0),
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                createForm.create_picker(
                    picker_title: isEdit
                        ? Global.get_type_name_by_id(
                            int.parse(createForm.DATA["TypeID"].toString()))
                        : "Category",
                    typeName: typeName,
                    tag: "Type",
                    title: "Category",
                    isCompulsory: true),
                createForm.create_input(
                    title: "Venue Name",
                    hint_text: "Venue Name",
                    icon: GIcons.meet,
                    tag: "EventName",
                    isCompulsory: true),
                createForm.create_google_picker(
                    icon: GIcons.location,
                    hint_text: "Location",
                    tag: "Location",
                    title: "Choose the location",
                    isCompulsory: true),
                // createForm.create_input(
                //   title: "Enter the specific address",
                //   hint_text: "Address",
                //   icon: GIcons.location,
                //   tag: "Location",
                //   isCompulsory: true,
                // ),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: createForm.create_timePicker(
                          title: "Available Hours",
                          hint_text: "Start Time",
                          tag: "Hour_Start",
                          initialValue: isEdit
                              ? createForm.DATA["Hour"]
                                  .split("-")[0]
                                  .substring(0, 5)
                              : null,
                          icon: MyFlutterApp.add____2,
                          isCompulsory: true),
                    ),
                    Expanded(
                        flex: 1,
                        child: createForm.create_timePicker(
                            title: "End Time",
                            hint_text: "End Time",
                            tag: "Hour_End",
                            icon: MyFlutterApp.add____2,
                            isCompulsory: true,
                            initialValue: isEdit
                                ? createForm.DATA["Hour"]
                                    .split("-")[1]
                                    .substring(0, 5)
                                : null)),
                  ],
                ),
                createForm.create_input(
                  title: "Cost",
                  hint_text: "\$hour, minimum No.of Hours of Booking",
                  icon: MyFlutterApp.add____1,
                  tag: "Price",
                ),
                createForm.create_input(
                  title: "Contact Number",
                  hint_text: "Phone Number",
                  icon: GIcons.phone,
                  tag: "ContactInfo",
                ),
                createForm.create_input(
                  title: "Name of Contact Person",
                  hint_text: "",
                  icon: GIcons.profile,
                  tag: "Contact_Person",
                ),
                createForm.create_input(
                  title: "Description/Equipment Provided",
                  hint_text: "Description/Equipment Provided",
                  icon: Flutter_0824_icons.doc,
                  tag: "Description",
                ),
                createForm.create_input(
                  title: "Room Size",
                  hint_text: "Number of Square Metres",
                  icon: Flutter_1101.add____6,
                  tag: "Size",
                ),
                createForm.create_input(
                  title: "No. of Seats",
                  hint_text: "Examples",
                  icon: Flutter_1101.add____7,
                  tag: "Seat",
                ),
                createForm.create_upload(
                  title: "Upload Photos (max.4)",
                  icon: GIcons.add,
                  tag: "Photo",
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 48.9),
                  child: Center(
                    child: FullWidthButton(
                      isEdit == false ? "Apply" : "Edit",
                      onPressed: onPressed,
                      color: Colors.grey,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
