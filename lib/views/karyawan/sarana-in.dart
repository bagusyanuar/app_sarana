import 'package:app_sarana/dummy/data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SaranaIn extends StatefulWidget {
  const SaranaIn({Key? key}) : super(key: key);

  @override
  State<SaranaIn> createState() => _SaranaInState();
}

class _SaranaInState extends State<SaranaIn> {
  String currentDate = '-- pilih tanggal --';
  int? selectedRoom;
  int? selectedSaranaRoom;
  final List<Map<String, dynamic>> _listRoom = DataDummy.DummyRoom;
  final List<Map<String, dynamic>> _listSaranaRoom = DataDummy.DummySaranaRoom;

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
          title: const Text("Sarana Masuk"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Transaksi Sarana / Prasarana Masuk",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const Divider(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: const Text("Tanggal Masuk"),
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
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.only(bottom: 5),
                        padding: const EdgeInsets.only(left: 10, right: 5),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: DropdownButton<int>(
                          underline: Container(),
                          isExpanded: true,
                          value: selectedRoom,
                          items: _listRoom
                              .map((e) => DropdownMenuItem(
                                    value: e['id'] as int,
                                    child: Text(e["name"]),
                                  ))
                              .toList(),
                          onChanged: (int? value) {
                            setState(() {
                              selectedRoom = value;
                            });
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
                        padding: const EdgeInsets.only(left: 10, right: 5),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: DropdownButton<int>(
                          underline: Container(),
                          isExpanded: true,
                          value: selectedSaranaRoom,
                          items: _listSaranaRoom
                              .map((e) => DropdownMenuItem(
                                    value: e['id'] as int,
                                    child: Text(e["name"]),
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
              ),
              Container(
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
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: ((value) {
            if (value == 0) {
              Navigator.of(context).pop();
            }

            if (value == 1) {
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
          currentIndex: 2,
        ),
      ),
    );
  }
}
