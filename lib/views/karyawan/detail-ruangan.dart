import 'dart:developer';

import 'package:app_sarana/dummy/data.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class DetailRuangan extends StatefulWidget {
  const DetailRuangan({Key? key}) : super(key: key);

  @override
  State<DetailRuangan> createState() => _DetailRuanganState();
}

class _DetailRuanganState extends State<DetailRuangan> {
  int? selectedValue;
  final TextEditingController textEditSaranaController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ruangan 1"),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(
                        top: 20, bottom: 20, left: 20, right: 5),
                    child: TextField(
                      onChanged: (text) {},
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                          prefixIcon: const Icon(Icons.search),
                          hintText: "Cari Sarana / Prasarana..."),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 20, bottom: 20, right: 20),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed("/add-sarana");
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
