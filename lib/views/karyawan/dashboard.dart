import 'dart:async';
import 'dart:developer';

import 'package:app_sarana/components/base-card.dart';
import 'package:app_sarana/components/base-loader.dart';
import 'package:app_sarana/components/room-card.dart';
import 'package:app_sarana/controller/ruangan.dart';
import 'package:app_sarana/dummy/data.dart';
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
  String param = '';
  Timer? _debounce;
  bool isLoading = true;
  List<dynamic> _dataRuangan = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getListRuangan(param);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _debounce?.cancel();
    super.dispose();
  }

  void getListRuangan(String param) async {
    setState(() {
      isLoading = true;
    });
    List<dynamic> list = await getListRuanganHandler(param);
    setState(() {
      isLoading = false;
      _dataRuangan = list;
    });
    log(list.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Bambang",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text("Admin")
                    ],
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const Icon(Icons.logout),
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: TextField(
                onChanged: (text) {
                  _handlerOnChange(text);
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    prefixIcon: const Icon(Icons.search),
                    hintText: "Cari Ruangan / Lokasi..."),
              ),
            ),
            Expanded(
              child: isLoading
                  ? const BaseLoader()
                  : RefreshIndicator(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: GridView(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10),
                          children: _dataRuangan
                              .map(
                                (e) => RoomCard(
                                  name: e['nama'].toString(),
                                  onTap: () {
                                    int id = e['id'] as int;
                                    Navigator.of(context).pushNamed(
                                        '/detail-ruangan',
                                        arguments: id);
                                  },
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      onRefresh: () {
                        return _refresh();
                      },
                    ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: ((value) {
          if (value == 1) {
            Navigator.of(context).pushNamed("/sarana-out");
          }

          if (value == 2) {
            Navigator.of(context).pushNamed("/sarana-in");
          }

          if (value == 3) {
            Navigator.of(context).pushNamed("/sarana-riwayat");
          }
        }),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Dashboard"),
          BottomNavigationBarItem(
              icon: Icon(Icons.outbox_rounded), label: "Sarana Keluar"),
          BottomNavigationBarItem(
              icon: Icon(Icons.move_to_inbox), label: "Sarana Masuk"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "Riwayat"),
        ],
        currentIndex: 0,
      ),
    );
  }

  _refresh() async {
    getListRuangan(param);
  }

  void _handlerOnChange(String text) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      getListRuangan(text);
    });
  }
}
