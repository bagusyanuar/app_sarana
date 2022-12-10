import 'dart:developer';

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
  String? selectedRoom;
  String? selectedSaranaRoom;
  List<Map<String, dynamic>> _listRoom = DataDummy.DummyRoom;
  List<Map<String, dynamic>> _listSaranaRoom = DataDummy.DummySaranaRoom;
  final TextEditingController _textRoomController = TextEditingController();
  final TextEditingController _textSaranaRoomController =
      TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DateTime now = DateTime.now();
    setState(() {
      currentDate = DateFormat('yyyy-MM-dd').format(now);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _textRoomController.dispose();
    _textSaranaRoomController.dispose();
    super.dispose();
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
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2050),
                        );

                        if (pickedDate != null) {
                          log(pickedDate.toString());
                          setState(() {
                            currentDate =
                                DateFormat("yyyy-MM-dd").format(pickedDate);
                          });
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.only(top: 5, bottom: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: 50,
                        width: MediaQuery.of(context).size.width,
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
                      margin: const EdgeInsets.only(bottom: 5),
                      padding: const EdgeInsets.only(left: 10, right: 5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          isExpanded: true,
                          hint: Text(
                            "Pilih Ruangan",
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                          items: _listRoom
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e["id"].toString(),
                                  child: Text(e["name"]),
                                ),
                              )
                              .toList(),
                          value: selectedRoom,
                          onChanged: (value) {
                            setState(() {
                              selectedRoom = value as String;
                            });
                          },
                          buttonHeight: 50,
                          buttonWidth: MediaQuery.of(context).size.width,
                          itemHeight: 40,
                          dropdownMaxHeight: 250,
                          searchController: _textRoomController,
                          searchInnerWidget: Padding(
                            padding: const EdgeInsets.only(
                              top: 8,
                              bottom: 4,
                              right: 8,
                              left: 8,
                            ),
                            child: TextFormField(
                              controller: _textRoomController,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 8,
                                ),
                                hintText: 'Search for an item...',
                                hintStyle: const TextStyle(fontSize: 12),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                          searchMatchFn: (item, searchValue) {
                            return (item.value
                                .toString()
                                .contains(searchValue));
                          },
                          onMenuStateChange: (isOpen) {
                            if (!isOpen) {
                              _textRoomController.clear();
                            }
                          },
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      child: const Text("Sarana / Prasarana"),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      padding: const EdgeInsets.only(left: 10, right: 5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          isExpanded: true,
                          hint: Text(
                            "Pilih Sarana",
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                          items: _listSaranaRoom
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e["id"].toString(),
                                  child: Text(e["name"]),
                                ),
                              )
                              .toList(),
                          value: selectedSaranaRoom,
                          onChanged: (value) {
                            log(value as String);
                            setState(() {
                              selectedSaranaRoom = value as String;
                            });
                          },
                          buttonHeight: 50,
                          buttonWidth: MediaQuery.of(context).size.width,
                          itemHeight: 40,
                          dropdownMaxHeight: 250,
                          searchController: _textSaranaRoomController,
                          searchInnerWidget: Padding(
                            padding: const EdgeInsets.only(
                              top: 8,
                              bottom: 4,
                              right: 8,
                              left: 8,
                            ),
                            child: TextFormField(
                              controller: _textSaranaRoomController,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 8,
                                ),
                                hintText: 'Search for an item...',
                                hintStyle: const TextStyle(fontSize: 12),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                          searchMatchFn: (item, searchValue) {
                            log(item.value);
                            return (item.value
                                .toString()
                                .contains(searchValue));
                          },
                          onMenuStateChange: (isOpen) {
                            if (!isOpen) {
                              _textSaranaRoomController.clear();
                            }
                          },
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      child: const Text("Keterangan / Keperluan"),
                    ),
                    TextField(
                      onChanged: (text) {},
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          hintText: "Keterangan / Keperluan"),
                      maxLines: 5,
                    ),
                  ],
                ),
              ),
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
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
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: ((value) {
            if (value == 0) {
              Navigator.of(context).pop();
            }

            if (value == 2) {
              Navigator.of(context).popAndPushNamed("/sarana-in");
            }
          }),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Dashboard"),
            BottomNavigationBarItem(
                icon: Icon(Icons.outbox_rounded), label: "Sarana Keluar"),
            BottomNavigationBarItem(
                icon: Icon(Icons.move_to_inbox), label: "Sarana Masuk"),
          ],
          currentIndex: 1,
        ),
      ),
    );
  }
}
