import 'package:app_sarana/components/base-card.dart';
import 'package:app_sarana/components/base-loader.dart';
import 'package:app_sarana/components/room-card.dart';
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
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: TextField(
                onChanged: (text) {},
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
                          children: DataDummy.DummyProperties.map(
                            (e) => RoomCard(
                              name: e['name'].toString(),
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed('/detail-ruangan');
                              },
                            ),
                          ).toList(),
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
        onTap: ((value) {
          if (value == 1) {
            Navigator.of(context).pushNamed("/sarana-out");
          }

          if (value == 2) {
            Navigator.of(context).pushNamed("/sarana-in");
          }
        }),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Dashboard"),
          BottomNavigationBarItem(
              icon: Icon(Icons.outbox_rounded), label: "Sarana Keluar"),
          BottomNavigationBarItem(
              icon: Icon(Icons.move_to_inbox), label: "Sarana Masuk"),
        ],
        currentIndex: 0,
      ),
    );
  }

  _refresh() async {}
}
