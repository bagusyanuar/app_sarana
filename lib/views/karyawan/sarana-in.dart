import 'package:flutter/material.dart';

class SaranaIn extends StatefulWidget {
  const SaranaIn({Key? key}) : super(key: key);

  @override
  State<SaranaIn> createState() => _SaranaInState();
}

class _SaranaInState extends State<SaranaIn> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Sarana Masuk"),
        ),
        body: Container(),
        bottomNavigationBar: BottomNavigationBar(
          onTap: ((value) {
            if (value == 0) {
              Navigator.of(context).pop();
            }

            if (value == 1) {
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
          currentIndex: 2,
        ),
      ),
    );
  }
}
