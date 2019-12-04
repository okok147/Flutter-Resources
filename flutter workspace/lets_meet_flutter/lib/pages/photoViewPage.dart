import 'package:flutter/material.dart';
import 'package:lets_meet_flutter/util/Global.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewPage extends StatefulWidget {
  String photo_url;

  PhotoViewPage({Key key, @required this.photo_url}) : super(key: key);
  @override
  _PhotoViewPageState createState() => _PhotoViewPageState();
}

class _PhotoViewPageState extends State<PhotoViewPage> {

  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      widget.photo_url = widget.photo_url.replaceFirst("-", "/");
      print(Global.baseUrl + widget.photo_url);
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: (){
          Navigator.of(context).pop();
        },
          child: Container(
          child: PhotoView(
          imageProvider: NetworkImage(Global.baseUrl + widget.photo_url),
        ),
        ),
      ),
    );
  }
}