import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    _initSplash();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 180,
                    width: 180,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/logo.png"),
                          fit: BoxFit.contain),
                    ),
                  ),
                  const Text(
                    "Sistem Sarana dan Prasarana",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.only(bottom: 10),
              child: const Text("Alex \u00a9 2022"),
            ),
          )
        ],
      ),
    );
  }

  void _initSplash() async {
    await Future.delayed(const Duration(seconds: 2));
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString("token");
    String? role = preferences.getString("role");
    if (token != null && role != null) {
      if (role == "admin") {
        Navigator.pushNamedAndRemoveUntil(context, "/dashboard-karyawan",
            ModalRoute.withName("/dashboard-karyawan"));
      } else {
        Navigator.pushNamedAndRemoveUntil(context, "/dashboard-mahasiswa",
            ModalRoute.withName("/dashboard-mahasiswa"));
      }
    } else {
      Navigator.popAndPushNamed(context, "/login");
    }
  }
}
