import 'dart:developer';

import 'package:app_sarana/helper/static_variable.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<List<dynamic>> getListRuanganHandler() async {
  List<dynamic> results = [];
  try {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString("token");
    final response = await Dio().get(
      "$HostAddress/admin/ruangan",
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
