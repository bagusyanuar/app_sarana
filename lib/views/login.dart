import 'package:app_sarana/controller/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String username = '';
  String password = '';
  String server = '';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                height: 180,
                width: MediaQuery.of(context).size.width * 0.5,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/logo.png"), fit: BoxFit.fill),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              margin: const EdgeInsets.only(bottom: 15),
              child: TextField(
                onChanged: (text) {
                  setState(() {
                    username = text;
                  });
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    prefixIcon: const Icon(Icons.account_circle_outlined),
                    hintText: "Username"),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              margin: const EdgeInsets.only(bottom: 20),
              child: TextField(
                onChanged: (text) {
                  setState(() {
                    password = text;
                  });
                },
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    prefixIcon: const Icon(Icons.lock_outline),
                    hintText: "Password"),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              margin: const EdgeInsets.only(bottom: 15),
              child: TextField(
                onChanged: (text) {
                  setState(() {
                    server = text;
                  });
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    prefixIcon: const Icon(Icons.settings),
                    hintText: "Server"),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GestureDetector(
                onTap: () {
                  if (!isLoading) {
                    login(context);
                  }
                },
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue[700]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      isLoading
                          ? Container(
                              height: 20,
                              width: 20,
                              margin: const EdgeInsets.only(right: 5),
                              child: const CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : Container(),
                      const Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }

  void login(BuildContext context) async {
    Map<String, String> data = {"username": username, "password": password};
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // preferences.setString("server", server);
    // print(data);
    setState(() {
      isLoading = true;
    });
    await loginHandler(data, context);
    setState(() {
      isLoading = false;
    });
    if (username == 'karyawan') {
      Navigator.popAndPushNamed(context, "/dashboard-karyawan");
    }
  }
}
