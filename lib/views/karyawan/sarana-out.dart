import 'dart:developer';

import 'package:app_sarana/components/base-loader.dart';
import 'package:app_sarana/controller/ruangan.dart';
import 'package:app_sarana/controller/transaksi.dart';
import 'package:app_sarana/dummy/data.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SaranaOut extends StatefulWidget {
  const SaranaOut({Key? key}) : super(key: key);

  @override
  State<SaranaOut> createState() => _SaranaOutState();
}

class _SaranaOutState extends State<SaranaOut> {
  String currentDate = '-- pilih tanggal --';
  int? selectedRoom;
  int? selectedSaranaRoom;
  List<dynamic> _listRoom = [];
  List<dynamic> _listSaranaRoom = [];
  bool isLoading = true;
  String keterangan = '';
  int qty = 0;

  @override
  void initState() {
    // TODO: implement initState
    getListRuangan();
    super.initState();
    DateTime now = DateTime.now();
    setState(() {
      currentDate = DateFormat('yyyy-MM-dd').format(now);
    });
  }

  void getListRuangan() async {
    setState(() {
      isLoading = true;
    });
    List<dynamic> list = await getListRuanganHandler("");
    if (list.isNotEmpty) {
      int currentRoomId = list.first["id"] as int;
      List<dynamic> listSarana = await getStockByRoom(currentRoomId, '');
      if (listSarana.isNotEmpty) {
        int currentSaranaRoomId = listSarana.first["id"] as int;
        setState(() {
          selectedSaranaRoom = currentSaranaRoomId;
        });
      }
      setState(() {
        isLoading = false;
        selectedRoom = currentRoomId;
        _listRoom = list;
        _listSaranaRoom = listSarana;
      });
    }
    log(list.toString());
  }

  void _getStockByRoom() async {
    setState(() {
      _listSaranaRoom = [];
    });
    List<dynamic> listSarana = await getStockByRoom(selectedRoom!, '');
    if (listSarana.isNotEmpty) {
      int currentSaranaRoomId = listSarana.first["id"] as int;
      setState(() {
        selectedSaranaRoom = currentSaranaRoomId;
      });
    }
    setState(() {
      _listSaranaRoom = listSarana;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Sarana Keluar"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Transaksi Sarana / Prasarana Keluar",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const Divider(),
              Expanded(
                  child: isLoading
                      ? const BaseLoader()
                      : Column(
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(top: 10),
                                      child: const Text("Tanggal Keluar"),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        DateTime? pickedDate =
                                            await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(2020),
                                          lastDate: DateTime(2050),
                                        );

                                        if (pickedDate != null) {
                                          log(pickedDate.toString());
                                          setState(() {
                                            currentDate =
                                                DateFormat("yyyy-MM-dd")
                                                    .format(pickedDate);
                                          });
                                        }
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            top: 5, bottom: 10),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        height: 50,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey, width: 1),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                currentDate,
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
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 5),
                                      child: const Text("Ruangan"),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin: const EdgeInsets.only(bottom: 5),
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 5),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey, width: 1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: DropdownButton<int>(
                                        underline: Container(),
                                        isExpanded: true,
                                        value: selectedRoom,
                                        items: _listRoom
                                            .map((e) => DropdownMenuItem(
                                                  value: e['id'] as int,
                                                  child: Text(e["nama"]),
                                                ))
                                            .toList(),
                                        onChanged: (int? value) {
                                          log(value.toString());
                                          setState(() {
                                            selectedRoom = value;
                                          });
                                          _getStockByRoom();
                                        },
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 5),
                                      child: const Text("Sarana / Prasarana"),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin: const EdgeInsets.only(bottom: 5),
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 5),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey, width: 1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: DropdownButton<int>(
                                        underline: Container(),
                                        isExpanded: true,
                                        value: selectedSaranaRoom,
                                        items: _listSaranaRoom
                                            .map((e) => DropdownMenuItem(
                                                  value: e['sarana_id'] as int,
                                                  child:
                                                      Text(e["sarana"]['name']),
                                                ))
                                            .toList(),
                                        onChanged: (int? value) {
                                          setState(() {
                                            selectedSaranaRoom = value;
                                          });
                                        },
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 5),
                                      child: const Text("Jumlah"),
                                    ),
                                    TextField(
                                      onChanged: (text) {
                                        setState(() {
                                          qty = int.parse(text);
                                        });
                                      },
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 10),
                                          hintText: "0"),
                                      keyboardType: TextInputType.number,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 5),
                                      child:
                                          const Text("Keterangan / Keperluan"),
                                    ),
                                    TextField(
                                      onChanged: (text) {
                                        setState(() {
                                          keterangan = text;
                                        });
                                      },
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 10),
                                          hintText: "Keterangan / Keperluan"),
                                      maxLines: 5,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _saveTransaction(context);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(top: 20),
                                height: 60,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.save,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "SIMPAN",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        )),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: ((value) {
            if (value == 0) {
              Navigator.of(context).pop();
            }

            if (value == 2) {
              Navigator.of(context).popAndPushNamed("/sarana-in");
            }

            if (value == 3) {
              Navigator.of(context).popAndPushNamed("/sarana-riwayat");
            }
          }),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Dashboard"),
            BottomNavigationBarItem(
                icon: Icon(Icons.outbox_rounded), label: "Sarana Keluar"),
            BottomNavigationBarItem(
                icon: Icon(Icons.move_to_inbox), label: "Sarana Masuk"),
            BottomNavigationBarItem(
                icon: Icon(Icons.history), label: "Riwayat"),
          ],
          currentIndex: 1,
        ),
      ),
    );
  }

  void _saveTransaction(BuildContext ctx) async {
    Map<String, dynamic> data = {
      "tanggal": currentDate,
      "room_id": selectedRoom,
      "sarana_id": selectedSaranaRoom,
      "keterangan": keterangan,
      "qty": qty
    };
    await saranaOutHandler(data, ctx);
    log(data.toString());
  }
}
