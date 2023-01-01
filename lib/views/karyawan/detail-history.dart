import 'dart:developer';

import 'package:app_sarana/components/base-loader.dart';
import 'package:app_sarana/controller/transaksi.dart';
import 'package:flutter/material.dart';

class DetailHistory extends StatefulWidget {
  const DetailHistory({Key? key}) : super(key: key);

  @override
  State<DetailHistory> createState() => _DetailHistoryState();
}

class _DetailHistoryState extends State<DetailHistory> {
  String type = "";
  String status = "";
  int id = 0;
  Map<String, dynamic>? data = {};
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Map<String, dynamic> args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      int t = args["type"] as int;
      int i = args["id"] as int;
      setState(() {
        id = i;
      });
      if (t == 0) {
        setState(() {
          type = "Masuk";
        });
      } else {
        setState(() {
          type = "Keluar";
        });
      }

      log(args.toString());
      _getDetail();
    });
    super.initState();
  }

  void _getDetail() async {
    setState(() {
      isLoading = true;
    });
    Map<String, dynamic>? _data;
    if (type == "Masuk") {
      _data = await reportSaranaInDetailHandler(id);
    } else {
      _data = await reportSaranaOutDetailHandler(id);
    }
    log(_data.toString());
    if (_data != null) {
      String _status = "";
      switch (_data["status"] as int) {
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
        data = _data;
        status = _status;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Riwayat Transaksi $type"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Detail Sarana $type",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const Divider(),
            Expanded(
              child: isLoading
                  ? const BaseLoader()
                  : SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: Text("Tanggal $type"),
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
                                    data!["tanggal"].toString(),
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
                          Container(
                            margin: const EdgeInsets.only(bottom: 5),
                            child: const Text("Ruangan"),
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
                                    data!["ruangan"]["nama"].toString(),
                                    style: const TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 5),
                            child: const Text("Sarana / Prasarana"),
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
                                    data!["sarana"]["name"].toString(),
                                    style: const TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 5),
                            child: const Text("Jumlah"),
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
                                    data!["qty"].toString(),
                                    style: const TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 5),
                            child: const Text("Keterangan"),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5, bottom: 10),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            height: 120,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    data!["keterangan"].toString(),
                                    style: const TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
                    ),
            )
          ],
        ),
      ),
    );
  }
}
