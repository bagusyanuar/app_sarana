import 'dart:developer';

import 'package:app_sarana/helper/static_variable.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<List<dynamic>> getListRuanganHandler(String param) async {
  List<dynamic> results = [];
  try {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString("token");
    final response = await Dio().get(
      "$HostAddress/admin/ruangan?q=$param",
      options: Options(headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      }),
    );
    results = response.data["payload"] as List<dynamic>;
    log(results.toString());
  } on DioError catch (e) {
    log(e.toString());
  }
  return results;
}

Future<Map<String, dynamic>?> getDetailRuanganHandler(int id) async {
  Map<String, dynamic>? result;
  try {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString("token");
    final response = await Dio().get(
      "$HostAddress/admin/ruangan/$id",
      options: Options(headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      }),
    );
    result = response.data["payload"] as Map<String, dynamic>;
    log(response.data.toString());
  } on DioError catch (e) {
    log(e.toString());
  }
  return result;
}

Future<List<dynamic>> getListStocksRuanganHandler(int id, String param) async {
  List<dynamic> results = [];
  try {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString("token");
    final response = await Dio().get(
      "$HostAddress/admin/ruangan/$id/sarana?name=$param",
      options: Options(headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      }),
    );
    results = response.data["payload"] as List<dynamic>;
    log(results.toString());
  } on DioError catch (e) {
    log(e.toString());
  }
  return results;
}

Future<List<dynamic>> getStockByRoom(int id, String name) async {
  List<dynamic> results = [];
  try {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString("token");
    final response = await Dio().get(
      "$HostAddress/admin/stock/by-room?room_id=$id&name=$name",
      options: Options(headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      }),
    );
    results = response.data["payload"] as List<dynamic>;
  } on DioError catch (e) {
    log(e.message);
  }
  return results;
}

Future<void> addStockRuanganHandler(int ruanganId, int id) async {
  try {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString("token");
    Map<String, int> data = {"item_id": id};
    var formData = FormData.fromMap(data);
    final response = await Dio().post(
      "$HostAddress/admin/ruangan/$ruanganId/sarana/add",
      options: Options(headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      }),
      data: formData,
    );
    log(response.data.toString());
  } on DioError catch (e) {
    log(e.toString());
  }
}
