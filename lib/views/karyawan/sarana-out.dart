import 'dart:developer';

import 'package:app_sarana/dummy/data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SaranaOut extends StatefulWidget {
  const SaranaOut({Key? key}) : super(key: key);

  @override
  State<SaranaOut> createState() => _SaranaOutState();
}

class _SaranaOutState extends State<SaranaOut> {
  String currentDate = '-- pilih tanggal --';
  List<Map<String, dynamic>> _listRoom = DataDummy.DummyRoom;

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
                      child: const Text("Sarana / Prasarana"),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      child: const Text("Keterangan"),
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
