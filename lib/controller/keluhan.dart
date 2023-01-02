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
    Map<String, dynamic> _tmpData = {
      "deskripsi": data["deskripsi"],
    };

    if (file != null) {
      _tmpData["file"] = await MultipartFile.fromFile(file.path);
    }
    var formData = FormData.fromMap(_tmpData);
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

Future<List<dynamic>> dataKeluhanHandler() async {
  List<dynamic> result = [];
  try {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString("token");
    final response = await Dio().get(
      "$HostAddress/mahasiswa/keluhan",
      options: Options(
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        },
      ),
    );
    log(response.data["payload"].toString());
    result = response.data["payload"] as List<dynamic>;
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

Future<Map<String, dynamic>?> detailKeluhanHandler(int id) async {
  Map<String, dynamic>? result;
  try {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString("token");
    final response = await Dio().get(
      "$HostAddress/mahasiswa/keluhan/$id",
      options: Options(
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        },
      ),
    );
    result = response.data["payload"] as Map<String, dynamic>?;
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
  }
  return result;
}
