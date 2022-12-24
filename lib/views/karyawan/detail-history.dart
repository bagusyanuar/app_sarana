import 'dart:developer';

import 'package:flutter/material.dart';

class DetailHistory extends StatefulWidget {
  const DetailHistory({Key? key}) : super(key: key);

  @override
  State<DetailHistory> createState() => _DetailHistoryState();
}

class _DetailHistoryState extends State<DetailHistory> {
  String type = "";
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Map<String, dynamic> args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      int t = args["type"] as int;
      if (t == 0) {
        setState(() {
          type = "Masuk";
        });
      } else {
        setState(() {
          type = "Keluar";
        });
      }
      log(args.toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Riwayat Transaksi $type"),
      ),
      body: Column(),
    );
  }
}
