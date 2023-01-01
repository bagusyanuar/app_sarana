import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helper/static_variable.dart';

Future<bool> keluhanSave(
    Map<String, dynamic> data, File? file, BuildContext context) async {
  bool result = false;
  try {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString("token");
    var formData = FormData.fromMap({
      "deskripsi": data["deskripsi"],
      "file": await MultipartFile.fromFile(file!.path),
    });
    final response = await Dio().post(
      "$HostAddress/mahasiswa/keluhan",
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
    result = true;
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
