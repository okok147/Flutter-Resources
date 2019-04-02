import 'package:flutter/material.dart';
import 'package:ravepay/ravepay.dart';

class RaveResponse {
  final Response<Result> response;
  RaveResponse({
    @required this.response,
  }) : assert(response != null, 'Cannot pass an empty ravepay response');

  Future responseData() async {
    if (response.data.chargeResponseCode == ResponseCode.SUCCESSFUL) {
      return response.data.chargeResponseMessage;
    }
    if (response.data.chargeResponseCode == ResponseCode.VALIDATION) {
      return response.data.chargeResponseMessage;
    }
  }
}

class ResponseCode {
  ResponseCode._();
  static const String SUCCESSFUL = "00";
  static const String VALIDATION = "02";
  static const String PIN = "PIN";
  static const String VBVSECURECODE = "VBVSECURECODE";
}
