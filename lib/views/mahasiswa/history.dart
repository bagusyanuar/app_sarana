import 'dart:developer';

import 'package:app_sarana/controller/keluhan.dart';
import 'package:app_sarana/dummy/data.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/base-loader.dart';
import '../../controller/profil.dart';

class HistoryKeluhan extends StatefulWidget {
  const HistoryKeluhan({Key? key}) : super(key: key);

  @override
  State<HistoryKeluhan> createState() => _HistoryKeluhanState();
}

class _HistoryKeluhanState extends State<HistoryKeluhan> {
  List<dynamic> _listKeluhan = DataDummy.DummyKeluhan;
  bool isLoading = false;
  bool isLoadingItem = false;
  String username = "";
  String kelas = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfil();
  }

  void getProfil() async {
    setState(() {
      isLoading = true;
    });
    Map<String, dynamic>? _data = await getProfilMahasiswaHandler();
    List<dynamic> dataKeluhan = await dataKeluhanHandler();
    log(_data.toString());
    if (_data != null) {
      setState(() {
        username = _data["mahasiswa"]["nama"].toString();
        kelas = _data["mahasiswa"]["kelas"]["nama"].toString();
        _listKeluhan = dataKeluhan;
        isLoading = false;
      });
      log(dataKeluhan.toString());
    }
  }

  _refresh() async {
    setState(() {
      isLoadingItem = true;
    });
    List<dynamic> dataKeluhan = await dataKeluhanHandler();
    setState(() {
      _listKeluhan = dataKeluhan;
      isLoadingItem = false;
    });
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
                            Text(kelas)
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
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: const Text(
                      "Data Keluhan",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: isLoadingItem
                        ? const BaseLoader()
                        : RefreshIndicator(
                            onRefresh: () {
                              return _refresh();
                            },
                            child: SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: _listKeluhan.map((e) {
                                    var status = "";
                                    Color colorStatus = Colors.black;
                                    switch (e["status"] as int) {
                                      case 0:
                                        status = "menunggu";
                                        colorStatus = Colors.orange;
                                        break;
                                      case 6:
                                        status = "Di Tolak";
                                        colorStatus = Colors.red;
                                        break;
                                      case 9:
                                        status = "Di Terima";
                                        colorStatus = Colors.green;
                                        break;
                                      default:
                                    }
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                            "/detail-keluhan",
                                            arguments: e["id"]);
                                      },
                                      child: Container(
                                        height: 70,
                                        margin:
                                            const EdgeInsets.only(bottom: 10),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            color:
                                                Colors.black54.withOpacity(0.2),
                                            width: 1,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: SizedBox(
                                                height: 60,
                                                child: Text(
                                                  e["deskripsi"],
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 3,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.2,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Expanded(
                                                    child: Text(e["tanggal"]),
                                                  ),
                                                  Text(
                                                    status,
                                                    style: TextStyle(
                                                        color: colorStatus),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                  )
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("/tambah-keluhan");
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: ((value) {
          if (value == 1) {
            Navigator.of(context).pushNamed("/ruangan");
          }
        }),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Dashboard"),
          BottomNavigationBarItem(
              icon: Icon(Icons.storage), label: "Inventaris"),
        ],
        currentIndex: 0,
      ),
    );
  }
}
