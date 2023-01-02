import 'dart:developer';

import 'package:app_sarana/controller/keluhan.dart';
import 'package:flutter/material.dart';

import '../../components/base-loader.dart';

class DetailKeluhan extends StatefulWidget {
  const DetailKeluhan({Key? key}) : super(key: key);

  @override
  State<DetailKeluhan> createState() => _DetailKeluhanState();
}

class _DetailKeluhanState extends State<DetailKeluhan> {
  Map<String, dynamic>? data;
  String status = "";
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      int args = ModalRoute.of(context)!.settings.arguments as int;
      Map<String, dynamic>? tmpData = await detailKeluhanHandler(args);
      setState(() {
        data = tmpData;
      });
      if (tmpData != null) {
        String _status = "";
        switch (tmpData["status"] as int) {
          case 0:
            _status = "menunggu";
            break;
          case 6:
            _status = "Di Tolak";
            break;
          case 9:
            _status = "Di Terima";
            break;
          default:
        }
        setState(() {
          status = _status;
        });
      }
      setState(() {
        isLoading = false;
      });
      log(tmpData.toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Keluhan"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Data Keluhan Mahasiswa",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const Divider(),
            Expanded(
              child: isLoading
                  ? const BaseLoader()
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 5),
                          child: const Text("Isi Keluhan"),
                        ),
                        Container(
                          height: 120,
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          margin: const EdgeInsets.only(top: 5, bottom: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            data!["deskripsi"].toString(),
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 5),
                          child: const Text("Gambar"),
                        ),
                        Container(
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(top: 5, bottom: 10),
                          child: data!["file"] != null
                              ? Image.network(
                                  "http://192.168.100.120:8000/${data!["file"]}",
                                  fit: BoxFit.fill,
                                )
                              : Container(),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 5),
                          child: const Text("Status"),
                        ),
                        Container(
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
                                  status,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            )
          ],
        ),
      ),
    );
  }
}
