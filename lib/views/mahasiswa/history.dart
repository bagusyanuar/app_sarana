import 'package:app_sarana/dummy/data.dart';
import 'package:flutter/material.dart';

class HistoryKeluhan extends StatefulWidget {
  const HistoryKeluhan({Key? key}) : super(key: key);

  @override
  State<HistoryKeluhan> createState() => _HistoryKeluhanState();
}

class _HistoryKeluhanState extends State<HistoryKeluhan> {
  final List<Map<String, dynamic>> _listKeluhan = DataDummy.DummyKeluhan;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Riwayat Keluhan"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: const Text("Data Keluhan"),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _listKeluhan
                        .map(
                          (e) => Container(
                            height: 70,
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.black54.withOpacity(0.2),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 60,
                                    child: Text(
                                      e["deskripsi"],
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                    ),
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Expanded(
                                        child: Text(e["tanggal"]),
                                      ),
                                      Text(
                                        "Di Terima",
                                        style: TextStyle(color: Colors.green),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
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
        }),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Beranda"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "Riwayat"),
        ],
        currentIndex: 1,
      ),
    );
  }
}
