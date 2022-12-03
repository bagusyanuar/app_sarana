import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class DashboardKaryawan extends StatefulWidget {
  const DashboardKaryawan({Key? key}) : super(key: key);

  @override
  State<DashboardKaryawan> createState() => _DashboardKaryawanState();
}

class _DashboardKaryawanState extends State<DashboardKaryawan> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          const BottomNavigationBarItem(
              icon: Icon(Icons.home), label: "Dashboard"),
          const BottomNavigationBarItem(
              icon: Icon(Icons.outbox_rounded), label: "Transaksi Sarana"),
        ],
      ),
    ));
  }
}
