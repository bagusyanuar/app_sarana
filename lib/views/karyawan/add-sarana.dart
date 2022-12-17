import 'dart:developer';

import 'package:app_sarana/components/base-loader.dart';
import 'package:app_sarana/controller/ruangan.dart';
import 'package:app_sarana/dummy/data.dart';
import 'package:flutter/material.dart';

import '../../components/room-card.dart';

class AddSarana extends StatefulWidget {
  const AddSarana({Key? key}) : super(key: key);

  @override
  State<AddSarana> createState() => _AddSaranaState();
}

class _AddSaranaState extends State<AddSarana> {
  bool isLoading = false;
  List<dynamic> _stocks = [];
  int ruanganId = 0;
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
      List<dynamic> data = await getListStocksRuanganHandler(id);
      setState(() {
        _stocks = data;
        isLoading = false;
      });
      log(data.toString());
    });
    super.initState();
  }

  void addNewStock(int id) async {
    setState(() {
      isLoading = true;
    });
    await addStockRuanganHandler(ruanganId, id);
    List<dynamic> data = await getListStocksRuanganHandler(ruanganId);
    setState(() {
      _stocks = data;
      isLoading = false;
    });
    log(id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Tambah Jenis Sarana"),
        ),
        body: Column(
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
                    hintText: "Cari Sarana / Prasarana..."),
              ),
            ),
            Expanded(
              child: isLoading
                  ? const BaseLoader()
                  : RefreshIndicator(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: _stocks.map(
                            (e) {
                              List<dynamic> exists =
                                  e['stocks'] as List<dynamic>;
                              bool isExists = exists.isNotEmpty ? true : false;
                              var itemId = e['id'] as int;
                              return Container(
                                height: 50,
                                margin: const EdgeInsets.only(bottom: 10),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Colors.black54.withOpacity(0.2),
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        e['name'],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    isExists
                                        ? const Icon(
                                            Icons.check,
                                            color: Colors.green,
                                          )
                                        : GestureDetector(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (BuildContext ctx) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                        "Konfirmasi!"),
                                                    content: const Text(
                                                        "Apakah anda yakin ingin menambahkan sarana / prasarana ini?"),
                                                    actions: <Widget>[
                                                      GestureDetector(
                                                        onTap: () {
                                                          Navigator.of(ctx)
                                                              .pop();
                                                        },
                                                        child: Container(
                                                          height: 30,
                                                          width: 70,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            border: Border.all(
                                                                color:
                                                                    Colors.blue,
                                                                width: 1),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: const [
                                                              Icon(
                                                                Icons.close,
                                                                color:
                                                                    Colors.red,
                                                                size: 12,
                                                              ),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Text("Batal")
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          Navigator.of(ctx)
                                                              .pop();
                                                          addNewStock(itemId);
                                                        },
                                                        child: Container(
                                                          height: 30,
                                                          width: 70,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.blue,
                                                            border: Border.all(
                                                                color:
                                                                    Colors.blue,
                                                                width: 1),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: const [
                                                              Icon(
                                                                Icons.check,
                                                                color: Colors
                                                                    .white,
                                                                size: 12,
                                                              ),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Text(
                                                                "OK",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        12),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            child: Container(
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: Colors.blue[400],
                                              ),
                                              child: const Center(
                                                child: Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          )
                                  ],
                                ),
                              );
                            },
                          ).toList(),
                        ),
                      ),
                      onRefresh: () {
                        return _refresh();
                      },
                    ),
            )
          ],
        ),
      ),
    );
  }

  _refresh() async {
    setState(() {
      isLoading = true;
    });
    List<dynamic> data = await getListStocksRuanganHandler(ruanganId);
    setState(() {
      _stocks = data;
      isLoading = false;
    });
  }
}
