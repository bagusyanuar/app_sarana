import 'dart:developer';

import 'package:app_sarana/controller/transaksi.dart';
import 'package:app_sarana/dummy/data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../components/base-loader.dart';

class HistorySarana extends StatefulWidget {
  const HistorySarana({Key? key}) : super(key: key);

  @override
  State<HistorySarana> createState() => _HistorySaranaState();
}

class _HistorySaranaState extends State<HistorySarana>
    with TickerProviderStateMixin {
  late TabController _tabController;
  String startDate = '-- pilih tanggal --';
  String endDate = '-- pilih tanggal --';
  List<dynamic> _listSaranaIn = [];
  List<dynamic> _listSaranaOut = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    _tabController = TabController(length: 2, vsync: this);
    setState(() {
      startDate = DateFormat('yyyy-MM-dd').format(now);
      endDate = DateFormat('yyyy-MM-dd').format(now);
    });
    _getHistory();
  }

  void _getHistory() async {
    setState(() {
      isLoading = true;
    });
    List<dynamic> dataSaranaIn =
        await reportSaranaInHandler(startDate, endDate);
    List<dynamic> dataSaranaOut =
        await reportSaranaOutHandler(startDate, endDate);
    setState(() {
      isLoading = false;
      _listSaranaIn = dataSaranaIn;
      _listSaranaOut = dataSaranaOut;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Riwayat Transaksi"),
        bottom: TabBar(
          controller: _tabController,
          tabs: const <Widget>[
            Tab(
              icon: Icon(Icons.move_to_inbox),
              text: "Sarana Masuk",
            ),
            Tab(
              icon: Icon(Icons.outbox_rounded),
              text: "Sarana Keluar",
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: const Text("Tanggal Awal"),
                        ),
                        GestureDetector(
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2020),
                              lastDate: DateTime(2050),
                            );

                            if (pickedDate != null) {
                              setState(() {
                                startDate =
                                    DateFormat("yyyy-MM-dd").format(pickedDate);
                              });
                              _getHistory();
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 5, bottom: 10),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            height: 50,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                    startDate,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                const Icon(
                                  Icons.calendar_month,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: const Text("Tanggal Akhir"),
                        ),
                        GestureDetector(
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2020),
                              lastDate: DateTime(2050),
                            );

                            if (pickedDate != null) {
                              setState(() {
                                endDate =
                                    DateFormat("yyyy-MM-dd").format(pickedDate);
                              });
                              _getHistory();
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 5, bottom: 10),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            height: 50,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                    endDate,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                const Icon(
                                  Icons.calendar_month,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: const Text(
                            "Data Sarana Masuk",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: isLoading
                              ? const BaseLoader()
                              : SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: _listSaranaIn.map(
                                      (e) {
                                        var status = "";
                                        switch (e["status"] as int) {
                                          case 0:
                                            status = "menunggu";
                                            break;
                                          case 6:
                                            status = "Di Tolak";
                                            break;
                                          case 9:
                                            status = "Di Terima";
                                            break;
                                          default:
                                        }
                                        return GestureDetector(
                                          onTap: () {
                                            Map<String, dynamic> args = {
                                              "id": e["id"] as int,
                                              "type": 0
                                            };
                                            Navigator.of(context).pushNamed(
                                                "/detail-sarana-riwayat",
                                                arguments: args);
                                          },
                                          child: Container(
                                            height: 70,
                                            margin: const EdgeInsets.only(
                                                bottom: 10),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                color: Colors.black54
                                                    .withOpacity(0.2),
                                                width: 1,
                                              ),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          e["tanggal"]
                                                              .toString(),
                                                          style:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        status,
                                                        style: const TextStyle(
                                                            fontSize: 14),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        e["sarana"]["name"]
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      e["qty"].toString(),
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ).toList(),
                                  ),
                                ),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: const Text(
                            "Data Sarana Keluar",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: isLoading
                              ? const BaseLoader()
                              : SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: _listSaranaOut.map(
                                      (e) {
                                        var status = "";
                                        switch (e["status"] as int) {
                                          case 0:
                                            status = "menunggu";
                                            break;
                                          case 6:
                                            status = "Di Tolak";
                                            break;
                                          case 9:
                                            status = "Di Terima";
                                            break;
                                          default:
                                        }
                                        return GestureDetector(
                                          onTap: () {
                                            Map<String, dynamic> args = {
                                              "id": e["id"] as int,
                                              "type": 1
                                            };
                                            Navigator.of(context).pushNamed(
                                                "/detail-sarana-riwayat",
                                                arguments: args);
                                          },
                                          child: Container(
                                            height: 70,
                                            margin: const EdgeInsets.only(
                                                bottom: 10),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                color: Colors.black54
                                                    .withOpacity(0.2),
                                                width: 1,
                                              ),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          e["tanggal"]
                                                              .toString(),
                                                          style:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        status,
                                                        style: const TextStyle(
                                                            fontSize: 14),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        e["sarana"]["name"]
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      e["qty"].toString(),
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ).toList(),
                                  ),
                                ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: ((value) {
          if (value == 0) {
            Navigator.of(context).pop();
          }

          if (value == 1) {
            Navigator.of(context).popAndPushNamed("/inventaris");
          }
        }),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Dashboard"),
          BottomNavigationBarItem(
              icon: Icon(Icons.storage), label: "Inventaris"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "Riwayat"),
        ],
        currentIndex: 2,
      ),
    );
  }
}
