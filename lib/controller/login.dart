import 'dart:developer';

import 'package:app_sarana/helper/static_variable.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> loginHandler(
    Map<String, String> data, BuildContext context) async {
  try {
    var formData = FormData.fromMap(data);
    final response = await Dio().post(
      "$HostAddress/login",
      options: Options(
        headers: {"Accept": "application/json"},
      ),
      data: formData,
    );
    final String token = response.data["payload"]["access_token"] as String;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("token", token);
    Fluttertoast.showToast(
      msg: "Login Success",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );

    // ignore: use_build_context_synchronously
    Navigator.pushNamedAndRemoveUntil(
        context, "/dashboard-karyawan", ModalRoute.withName("/dashboard"));
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
    log(e.toString());
  }
}
