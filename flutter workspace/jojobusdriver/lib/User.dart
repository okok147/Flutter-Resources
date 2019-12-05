import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class User{
  int ID;
  String name;
  String email;
  String shopName;
  Color shopColor;
  String shopImage;
  String shopID;
  String lisence;
  MaterialColor color;
  
  
  static Map<int,User> cache = new Map();
  User(Map<String,dynamic> obj ){
    if (obj!=null){
       update(obj);
    }
  }
  void update(Map<String,dynamic> obj ){
    this.ID =(obj["ID"]!=null)?int.parse(obj["ID"].toString()):0;
    this.email =obj["email"].toString();
    this.name =obj["name"].toString();
    this.shopID =obj["shopID"].toString();
    this.lisence =obj["lisence"].toString();
    
    if (obj["shopName"]!=null) this.shopName = obj["shopName"].toString();
    //if (obj["shopColor"]!=null) shopColor = Color( int.parse(obj["shopColor"].toString(),radix: 16));
    if (obj["shopColor"]=="yellow")color = Colors.yellow;
    if (obj["shopColor"]=="blue")color = Colors.blue;
    if (obj["shopColor"]=="red")color = Colors.red;
    if (obj["shopColor"]=="teal")color = Colors.teal;
    if (obj["shopColor"]=="amber")color = Colors.amber;
    if (obj["shopColor"]=="blueGrey")color = Colors.blueGrey;
    if (obj["shopColor"]=="brown")color = Colors.brown;
    if (obj["shopColor"]=="cyan")color = Colors.cyan;
    if (obj["shopColor"]=="deepOrange")color = Colors.deepOrange;
    if (obj["shopColor"]=="deepPurple")color = Colors.deepPurple;
    if (obj["shopColor"]=="green")color = Colors.green;
    if (obj["shopColor"]=="grey")color = Colors.grey;
    if (obj["shopColor"]=="indigo")color = Colors.indigo;
    if (obj["shopColor"]=="lightBlue")color = Colors.lightBlue;
    if (obj["shopColor"]=="lightGreen")color = Colors.lightGreen;
    if (obj["shopColor"]=="lime")color = Colors.lime;
    if (obj["shopColor"]=="orange")color = Colors.orange;
    if (obj["shopColor"]=="pink")color = Colors.pink;
    if (obj["shopColor"]=="purple")color = Colors.purple;    

    if (obj["shopImage"]!=null) this.shopImage = obj["shopImage"].toString();
    
  
    // if (this.dob != null){
    //   var formatter = new DateFormat('yyyy-MM-dd');
    //   dob = formatter.format(DateTime.parse(this.dob));
    // }
    
    

    
    //print(this.image);

  }


static User Get(int ID){
  return cache[ID];
}
  static User add(Map<String,dynamic> obj){
        var ID = int.parse(obj["ID"].toString());
        if (cache.containsKey(ID)){
            cache[ID].update(obj);
        }else{
            cache[ID] =new User(obj);
        }
        return cache[ID];
  }



}



