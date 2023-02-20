import 'package:flutter/material.dart';

class Inventaris extends StatefulWidget {
  const Inventaris({Key? key}) : super(key: key);

  @override
  State<Inventaris> createState() => _InventarisState();
}

class _InventarisState extends State<Inventaris> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Inventaris"),
      ),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed("/sarana-in");
                },
                child: Container(
                  height: 120,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.black54.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: const Center(
                    child: Text("SARANA MASUK",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed("/sarana-out");
                },
                child: Container(
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.black54.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: const Center(
                    child: Text("SARANA KELUAR",
                        style: TextStyle(fontWeight: FontWeight.bold)),
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
        currentIndex: 1,
      ),
    );
  }
}
