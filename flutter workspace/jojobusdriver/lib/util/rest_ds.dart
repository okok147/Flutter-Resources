import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../User.dart';
import 'Global.dart';
import 'network_util.dart';
import 'Config.dart' as Config;

class RestDatasource {
  NetworkUtil _netUtil = new NetworkUtil();
  static const BASE_URL = Config.BASEURL;
  // static String TOKEN = Config.TOKEN;
  static const UpdateFirebaseToken = BASE_URL + "admin/UpdateFirebaseToken";
  static const GetConstants = BASE_URL + "api/GetConstants";
  static const LoginByPhone = BASE_URL + "admin/LoginByPhone";
  static const GetProfile = BASE_URL + "admin/driver/GetProfile";
  static const GetBookings = BASE_URL + "admin/GetBookings";
  static const GetSingleBooking = BASE_URL + "admin/GetSingleBooking";
  static const MakeBooking = BASE_URL + "admin/MakeBooking";
  static const CancelBooking = BASE_URL + "admin/CancelBooking";
  static const GetPath = BASE_URL + "admin/GetPath";
  static const PaidBooking = BASE_URL + "admin/PaidBooking";
  static const EditBooking = BASE_URL + "api/EditBooking";
  static const ScoreBooking = BASE_URL + "api/ScoreBooking";
  static const EditProfile = BASE_URL + "api/EditProfile";
  static const EditCard = BASE_URL + "api/EditCard";
  static const DeleteCard = BASE_URL + "api/DeleteCard";
  static const GetCard = BASE_URL + "api/GetCard";
  static const UploadImage = BASE_URL + "api/UploadImage";
  static const AdminLogin = BASE_URL + "admin/driver/Login";
  static const ConfirmBooking = BASE_URL + "admin/ConfirmBooking";
  static const ConfirmPayment = BASE_URL + "admin/ConfirmPayment";
  static const ConfirmPayment2 = BASE_URL + "admin/ConfirmPayment2";
  static const ConfirmPayment3 = BASE_URL + "admin/ConfirmPayment3";

  static const ListDrivers = BASE_URL + "admin/ListDrivers";
  static const EditDriver = BASE_URL + "admin/EditDriver";
  static const ListSingleDriver = BASE_URL + "admin/ListSingleDriver";
  static const GetBusType = BASE_URL + "api/GetBusType";

  static const UpgradeCar = BASE_URL + "admin/upgradeCar";
  static const SendRemind = BASE_URL + "admin/sendRemind";

  // static const AdminLogin = BASE_URL + "admin/AdminLogin";
  // static const AdminLogin = BASE_URL + "admin/AdminLogin";

  Future<RequestObj> updateFirebaseToken({fireBaseTOKEN}) {
    print("uploading");
    return _netUtil.post(EditProfile, body: {
      "FirebaseToken": fireBaseTOKEN,
    }).then((res) {
      var r = RequestObj(res);
      if (r.Code == 200) {
        if (r.Data["TOKEN"] != null) {
          Global.me = User.add(r.Data);
          SharedPreferences.getInstance().then((tar) {
            tar.setString("TOKEN", r.Data["TOKEN"]);
          });
        }
      } else {
        //Global.showAlert(r.Msg);
      }
    });
  }

  Future<RequestObj> uploadImage(File f) {
    return _netUtil.upload(UploadImage, f).then((res) {
      print("haha");
      print(res);
      var r = RequestObj(res);
      if (r.Code == 200) {
      } else {
        Global.showAlert(r.Msg);
      }
      return r;
    });
  }

  Future<RequestObj> adminLogin(Map<String, String> body) {
    return _netUtil.post(AdminLogin, body: body).then((res) {
      var r = RequestObj(res);
      if (r.Code == 200) {
        if (r.Data["TOKEN"] != null) {
          Global.me = User.add(r.Data);
          SharedPreferences.getInstance().then((tar) {
            tar.setString("TOKEN", r.Data["TOKEN"]);
          });
        }
      } else {
        //Global.showAlert(r.Msg);
      }
      return r;
    });
  }




  Future<RequestObj> getProfile({fireBaseTOKEN}) async{
  //  var r = await _netUtil.get(GetProfile);
 //   return null;
    return _netUtil.get(GetProfile,body:{"type":"admin"}).then((res) {
      var r = RequestObj(res);
      if (r.Code == 200) {
        Global.me = User.add(r.Data);
      } else {
        //Global.showAlert(r.Msg);
      }
      return r;
    });
  }

  
}

class RequestObj {
  int Code;
  String Msg;
  dynamic Data;
  RequestObj(Map<dynamic, dynamic> obj) {
    if (obj == null) {
      Code = 500;
      Msg = "發生無法認知的錯誤";
    } else {
      Code = obj["Code"];
      Data = obj["Data"];
      Msg = obj["Msg"];
    }
  }
}
