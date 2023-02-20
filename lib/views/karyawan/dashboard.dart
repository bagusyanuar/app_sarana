import 'dart:async';
import 'dart:developer';

import 'package:app_sarana/components/base-card.dart';
import 'package:app_sarana/components/base-loader.dart';
import 'package:app_sarana/components/room-card.dart';
import 'package:app_sarana/controller/profil.dart';
import 'package:app_sarana/controller/ruangan.dart';
import 'package:app_sarana/dummy/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardKaryawan extends StatefulWidget {
  const DashboardKaryawan({Key? key}) : super(key: key);

  @override
  State<DashboardKaryawan> createState() => _DashboardKaryawanState();
}

class _DashboardKaryawanState extends State<DashboardKaryawan> {
  String param = '';
  Timer? _debounce;
  bool isLoading = true;
  bool isLoadingItem = false;
  List<dynamic> _dataRuangan = [];
  String username = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfil();
    getListRuangan(param);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _debounce?.cancel();
    super.dispose();
  }

  void getProfil() async {
    setState(() {
      isLoading = true;
    });
    Map<String, dynamic>? _data = await getProfilAdminHandler();
    if (_data != null) {
      setState(() {
        username = _data["username"].toString();
        isLoading = false;
      });
    }
  }

  void getListRuangan(String param) async {
    setState(() {
      isLoadingItem = true;
    });
    List<dynamic> list = await getListRuanganHandler(param);
    setState(() {
      isLoadingItem = false;
      _dataRuangan = list;
    });
    log(list.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: isLoading
            ? const SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: BaseLoader())
            : Column(
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
                          children: [
                            Text(
                              username,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const Text("Admin")
                          ],
                        ),
                        GestureDetector(
                          onTap: () async {
                            SharedPreferences preferences =
                                await SharedPreferences.getInstance();
                            preferences.remove("token");
                            preferences.remove("role");
                            Navigator.pushNamedAndRemoveUntil(context, "/login",
                                ModalRoute.withName("/login"));
                          },
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
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                          prefixIcon: const Icon(Icons.search),
                          hintText: "Cari Ruangan / Lokasi..."),
                    ),
                  ),
                  Expanded(
                    child: isLoadingItem
                        ? const BaseLoader()
                        : RefreshIndicator(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
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
            Navigator.of(context).pushNamed("/inventaris");
          }

          // if (value == 2) {
          //   Navigator.of(context).pushNamed("/sarana-in");
          // }

          if (value == 2) {
            Navigator.of(context).pushNamed("/sarana-riwayat");
          }
        }),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Dashboard"),
          BottomNavigationBarItem(
              icon: Icon(Icons.storage), label: "Inventaris"),
          // BottomNavigationBarItem(
          //     icon: Icon(Icons.outbox_rounded), label: "Sarana Keluar"),
          // BottomNavigationBarItem(
          //     icon: Icon(Icons.move_to_inbox), label: "Sarana Masuk"),
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
