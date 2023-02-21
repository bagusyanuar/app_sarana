import 'dart:async';
import 'dart:developer';

import 'package:app_sarana/controller/ruangan.dart';
import 'package:flutter/material.dart';

import '../../components/base-loader.dart';
import '../../components/room-card.dart';

class Ruangan extends StatefulWidget {
  const Ruangan({Key? key}) : super(key: key);

  @override
  State<Ruangan> createState() => _RuanganState();
}

class _RuanganState extends State<Ruangan> {
  String param = '';
  Timer? _debounce;
  bool isLoading = true;
  bool isLoadingItem = false;
  List<dynamic> _dataRuangan = [];
  String username = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getListRuangan(param);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _debounce?.cancel();
    super.dispose();
  }

  void getListRuangan(String param) async {
    setState(() {
      isLoadingItem = true;
    });
    List<dynamic> list = await getListRuanganMahasiswaHandler(param);
    setState(() {
      isLoadingItem = false;
      _dataRuangan = list;
    });
    log(list.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ruangan"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: TextField(
              onChanged: (text) {
                _handlerOnChange(text);
              },
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
            child: isLoadingItem
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
                        children: _dataRuangan
                            .map(
                              (e) => RoomCard(
                                name: e['nama'].toString(),
                                onTap: () {
                                  int id = e['id'] as int;
                                  Navigator.of(context).pushNamed(
                                      '/detail-ruangan-mahasiswa',
                                      arguments: id);
                                },
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    onRefresh: () {
                      return _refresh();
                    },
                  ),
          ),
        ],
      ),
    );
  }

  _refresh() async {
    getListRuangan(param);
  }

  void _handlerOnChange(String text) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      getListRuangan(text);
    });
  }
}
