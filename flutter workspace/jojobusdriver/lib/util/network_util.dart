import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:async/async.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
// import 'package:oneclassflutter/util/Food.dart';
// import 'package:oneclassflutter/util/Shop.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Config.dart' as Config;
import 'Global.dart';

class NetworkUtil {
  // next three lines makes this class a Singleton
  static NetworkUtil _instance = new NetworkUtil.internal();
  NetworkUtil.internal();
  factory NetworkUtil() => _instance;

  final JsonDecoder _decoder = new JsonDecoder();

  
  // Future<dynamic> get(String url) {
  //   return http.get(url).then((http.Response response) {
  //     final String res = response.body;
  //     final int statusCode = response.statusCode;

  //     if (statusCode < 200 || statusCode > 400 || json == null) {
  //       throw new Exception("Error while fetching data");
  //     }
  //     return _decoder.convert(res);
  //   });
  // }



Future<dynamic> upload(String url, File imageFile ) async {
  print("???");
  SharedPreferences prefs = await SharedPreferences.getInstance();
    var Token =  prefs.getString('TOKEN').toString();
    
  var headers = new Map<String, String>();
    headers["api_key"] = Config.APIKEY;
    headers["token"] = Token;
    headers["version"] = Config.VERSION;
    // headers["Content-Type"] = "application/json";
  
   var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
      var length = await imageFile.length();

      var uri = Uri.parse(url);

     var request = new http.MultipartRequest("POST", uri, );     

      var multipartFile = new http.MultipartFile('file', stream, length,
          filename: basename(imageFile.path));
          //contentType: new MediaType('image', 'png'));
      request.headers.addAll(headers);
      request.files.add(multipartFile);
      
      var response = await request.send();
          if (response.statusCode!=200){
            return null;
          }
       var value = await  response.stream.transform(utf8.decoder).join();
       return json.decode(value);
}



Future<dynamic> get(String url, {Map headers, body, encoding}) async {

    // Uri outgoingUri = Uri.http(url,"",body);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var Token =  prefs.getString('TOKEN').toString();
    var s = "?ok=1";
    if (body!=null){
      for (var k in body.keys){
          s+="&"+k.toString()+"="+body[k].toString();
      }
    }
    print(s);
    //print(outgoingUri); 
    headers = new Map<String, String>();
    headers["api_key"] = Config.APIKEY;
    headers["token"] = Token;
    headers["version"] = Config.VERSION;
    headers["Content-Type"] = "application/json";
      print(url+s);  

  
  
    return http
        .get(url+s, headers: headers)
        .then((http.Response response) {
          print("but why..");          
      final String res = response.body;
      final int statusCode = response.statusCode;

       

      if (statusCode < 200 || statusCode > 400 || json == null) {
        print("error!!!");
        throw new Exception("Error while fetching data");
      }
      print("geting payloadf!!!");
      var data = _decoder.convert(res);
      print("geting payloadf!!!2");
      print(data);
       
      //setupPayLoad(data);                  
      return data;
    }).catchError((onError){
       print(onError);
      //  Global.showAlert(onError.toString());
       return null;
       //Global.mainContext.findRenderObject().parentData.
       
    });

}

  void setupPayLoad(data){
    if (data["Code"].toString()=="1071"){
        while( Navigator.canPop(Global.mainContext)){
              Navigator.pop(Global.mainContext);                                        }
              Global.router.navigateTo(Global.mainContext, "/ErrorPage",
            transition: TransitionType.fadeIn, replace: true);          
        }
    
    if (data["PayLoad"]!=null){

          // if (data["PayLoad"]["User"]!=null){              
          //     (data["PayLoad"]["User"] as List).forEach((f){              
          //       User.add(f);
          //   });
          // }
          
          
      }
  }

Future<dynamic> post(String url, {Map headers, body, encoding}) async {

    // Uri outgoingUri = Uri.http(url,"",body);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var Token =  prefs.getString('TOKEN').toString();
 
  
    //print(outgoingUri); 
    headers = new Map<String, String>();
    headers["api_key"] = Config.APIKEY;
    headers["token"] = Token;
    headers["version"] = Config.VERSION;
    // headers["Content-Type"] = "application/json";
      print(url);  

  
  
    return http
        .post(url, headers: headers, body: body)
        .then((http.Response response) {
          print("but why..");          
      final String res = response.body;
      final int statusCode = response.statusCode;

       

      if (statusCode < 200 || statusCode > 400 || json == null) {
        print("error!!!");
        throw new Exception("Error while fetching data");
      }
      print("geting payloadf!!!");
      var data = _decoder.convert(res);
      print("geting payloadf!!!2");
      print(data);
       
      setupPayLoad(data); 
      if (data["Code"].toString()=="1071"){
        while( Navigator.canPop(Global.mainContext)){
              Navigator.pop(Global.mainContext);                                        }
              Global.router.navigateTo(Global.mainContext, "/ErrorPage",
            transition: TransitionType.fadeIn, replace: true);          
        }
                       
      return data;
    }).catchError((onError){
       print(onError);
      //  Global.showAlert(onError.toString());
      return null;
       //Global.mainContext.findRenderObject().parentData.
       
    });

}

  Future<dynamic> post2(String url, {Map headers, body, encoding}) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var Token =  prefs.getString('TOKEN').toString();
    // if (Token==null||Token==""){
    //   Token = "1234567";
    //   prefs.setString("TOKEN", "1234567");
    // }
    headers = new Map<String, String>();
    //headers["admin_key"] = Config.ADMINKEY;
    headers["api_key"] = Config.APIKEY;
    headers["token"] = Token;
    headers["version"] = Config.VERSION;
    return http
        .post(url, headers: headers, body: body)
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {        
        //throw new Exception("Error while fetching data");        
      }else{
        var data = _decoder.convert(res);
      setupPayLoad(data);      
      return data;
      }
      
    });
  }
}