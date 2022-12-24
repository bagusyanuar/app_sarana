import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helper/static_variable.dart';

Future<void> saranaOutHandler(
    Map<String, dynamic> data, BuildContext context) async {
  try {
    var id = data["room_id"];
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString("token");
    var formData = FormData.fromMap(data);
    final response = await Dio().post(
      "$HostAddress/admin/ruangan/$id/sarana/keluar",
      options: Options(
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        },
      ),
      data: formData,
    );
    Fluttertoast.showToast(
      msg: "Success",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );

    log(response.data.toString());
  } on DioError catch (e) {
    Fluttertoast.showToast(
      msg: "Terjadi Kesalahan ${e.message}",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
    log(e.response!.data.toString());
  }
}

Future<void> saranaInHandler(
    Map<String, dynamic> data, BuildContext context) async {
  try {
    var id = data["room_id"];
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString("token");
    var formData = FormData.fromMap(data);
    final response = await Dio().post(
      "$HostAddress/admin/ruangan/$id/sarana/masuk",
      options: Options(
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        },
      ),
      data: formData,
    );
    Fluttertoast.showToast(
      msg: "Success",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );

    log(response.data.toString());
  } on DioError catch (e) {
    Fluttertoast.showToast(
      msg: "Terjadi Kesalahan ${e.message}",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
    log(e.response!.data.toString());
  }
}

Future<List<dynamic>> reportSaranaInHandler(
    String startDate, String endDate) async {
  List<dynamic> result = [];
  try {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString("token");
    final response = await Dio().get(
      "$HostAddress/admin/ruangan/all/sarana/masuk?start_date=$startDate&end_date=$endDate",
      options: Options(
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        },
      ),
    );
    log(response.data["payload"].toString());
    result = response.data["payload"] as List<dynamic>;
    Fluttertoast.showToast(
      msg: "Success",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );

    log(response.data.toString());
  } on DioError catch (e) {
    Fluttertoast.showToast(
      msg: "Terjadi Kesalahan ${e.message}",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
    log(e.response!.data.toString());
  }
  return result;
}

Future<List<dynamic>> reportSaranaOutHandler(
    String startDate, String endDate) async {
  List<dynamic> result = [];
  try {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString("token");
    final response = await Dio().get(
      "$HostAddress/admin/ruangan/all/sarana/keluar?start_date=$startDate&end_date=$endDate",
      options: Options(
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        },
      ),
    );
    log(response.data["payload"].toString());
    result = response.data["payload"] as List<dynamic>;
    Fluttertoast.showToast(
      msg: "Success",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );

    log(response.data.toString());
  } on DioError catch (e) {
    Fluttertoast.showToast(
      msg: "Terjadi Kesalahan ${e.message}",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
    log(e.response!.data.toString());
  }
  return result;
}
