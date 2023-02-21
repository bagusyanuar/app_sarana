import 'dart:async';
import 'dart:developer';

import 'package:app_sarana/controller/ruangan.dart';
import 'package:flutter/material.dart';

import '../../components/base-loader.dart';

class DetailRuanganMahasiswa extends StatefulWidget {
  const DetailRuanganMahasiswa({Key? key}) : super(key: key);

  @override
  State<DetailRuanganMahasiswa> createState() => _DetailRuanganMahasiswaState();
}

class _DetailRuanganMahasiswaState extends State<DetailRuanganMahasiswa> {
  bool isLoading = true;
  String title = 'Nama Ruangan';
  String param = '';
  List<dynamic> _stocks = [];
  int ruanganId = 0;
  Timer? _debounce;

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      int id = ModalRoute.of(context)!.settings.arguments as int;
      log("Argument Value $id");
      setState(() {
        ruanganId = id;
        isLoading = true;
      });
      Map<String, dynamic>? detail = await getDetailRuanganMahasiswaHandler(id);
      List<dynamic> stocks = await getStockByRoomMahasiswa(id, param);
      if (detail != null) {
        setState(() {
          title = detail["nama"] as String;
          _stocks = stocks;
          isLoading = false;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
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
                        top: 20, bottom: 20, left: 20, right: 20),
                    child: TextField(
                      onChanged: (text) {
                        _getStockByRoom(text);
                      },
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
              ],
            ),
            Expanded(
              child: isLoading
                  ? const BaseLoader()
                  : RefreshIndicator(
                      onRefresh: () {
                        return _refresh();
                      },
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: _stocks
                                .map(
                                  (e) => Container(
                                    height: 50,
                                    margin: const EdgeInsets.only(bottom: 10),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Colors.black54.withOpacity(0.2),
                                        width: 1,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            e['sarana']['name'],
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          e['qty'].toString(),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _getStockByRoom(String p) async {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      setState(() {
        isLoading = true;
        param = p;
      });
      List<dynamic> stocks = await getStockByRoomMahasiswa(ruanganId, param);
      setState(() {
        _stocks = stocks;
        isLoading = false;
      });
    });
  }

  _refresh() async {
    setState(() {
      isLoading = true;
    });
    List<dynamic> stocks = await getStockByRoomMahasiswa(ruanganId, param);
    setState(() {
      _stocks = stocks;
      isLoading = false;
    });
  }
}
