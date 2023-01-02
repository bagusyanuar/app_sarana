import 'dart:developer';
import 'dart:io';

import 'package:app_sarana/components/base-loader.dart';
import 'package:app_sarana/controller/keluhan.dart';
import 'package:app_sarana/controller/profil.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DashboardMahasiswa extends StatefulWidget {
  const DashboardMahasiswa({Key? key}) : super(key: key);

  @override
  State<DashboardMahasiswa> createState() => _DashboardMahasiswaState();
}

class _DashboardMahasiswaState extends State<DashboardMahasiswa> {
  String fileString = 'pilih gambar / foto...';
  File? file;
  final ImagePicker _picker = ImagePicker();
  String deskripsi = "";
  bool isLoading = false;
  bool isLoadingSave = false;
  String username = "";
  String kelas = "";

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) async {});
    super.initState();
    getProfil();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        "Form Keluhan Mahasiswa",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const Divider(),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 5),
                            child: const Text("Isi Keluhan"),
                          ),
                          TextField(
                            onChanged: (text) {
                              setState(() {
                                deskripsi = text;
                              });
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                hintText: "Isi Keluhan"),
                            maxLines: 6,
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 5, top: 10),
                            child: const Text("Foto / Gambar"),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            height: 60,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: Text(
                                    fileString,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _getFromGallery();
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Center(
                                      child: Text("Cari..."),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (!isLoadingSave) {
                          _saveKeluhan(context);
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.only(top: 20),
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            isLoadingSave
                                ? Container(
                                    height: 20,
                                    width: 20,
                                    margin: const EdgeInsets.only(right: 5),
                                    child: const CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Icon(
                                    Icons.send,
                                    color: Colors.white,
                                  ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              "Kirim Keluhan",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   type: BottomNavigationBarType.fixed,
      //   onTap: ((value) {
      //     if (value == 1) {
      //       Navigator.of(context).pushNamed("/keluhan-riwayat");
      //     }
      //   }),
      //   items: const [
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: "Beranda"),
      //     BottomNavigationBarItem(icon: Icon(Icons.history), label: "Riwayat"),
      //   ],
      //   currentIndex: 0,
      // ),
    );
  }

  _getFromGallery() async {
    log("test");
    try {
      XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 1000,
        maxWidth: 100,
      );
      if (pickedFile != null) {
        File imageFile = File(pickedFile.path);
        String fileName = imageFile.path.split('/').last;
        setState(() {
          fileString = fileName;
          file = imageFile;
        });
        log(fileName);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  void _saveKeluhan(BuildContext ctx) async {
    Map<String, dynamic> data = {
      "file": file,
      "deskripsi": deskripsi,
    };
    setState(() {
      isLoadingSave = true;
    });
    bool result = await keluhanSave(data, file, ctx);
    log(result.toString());
    if (result == true) {
      Navigator.pop(context);
    }
    setState(() {
      isLoadingSave = false;
    });
  }

  void getProfil() async {
    setState(() {
      isLoading = true;
    });
    Map<String, dynamic>? _data = await getProfilMahasiswaHandler();
    log(_data.toString());
    if (_data != null) {
      setState(() {
        username = _data["mahasiswa"]["nama"].toString();
        kelas = _data["mahasiswa"]["kelas"]["nama"].toString();
        isLoading = false;
      });
      log(username);
    }
  }
}
