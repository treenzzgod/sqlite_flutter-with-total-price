import 'package:flutter/material.dart';
import 'package:sqlite_flutter/db/dbhelper.dart';

class Setting extends StatefulWidget {
  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  TextEditingController passwordsaatiniController = TextEditingController();
  TextEditingController passwordbaruController = TextEditingController();
  final DbHelper dbHelper = DbHelper();

  String get nama => 'Giovanni Iqbal Rahmadan';

  String get nim => '2141764002';

  String getCurrentDateFormatted() {
    DateTime now = DateTime.now();
    return '${now.year}-${now.month}-${now.day}';
  }

  @override
  Widget build(BuildContext context) {
    bool _obsecureText = true;
    return Scaffold(
      appBar: AppBar(
        title: Text("Pengaturan"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Ubah Password",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextField(
                  controller: passwordsaatiniController,
                  obscureText: true,
                  decoration: InputDecoration(labelText: "Password Saat Ini"),
                ),
                TextField(
                  controller: passwordbaruController,
                  obscureText: true,
                  decoration: InputDecoration(labelText: "Password Baru"),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Simpan passwo
                    String inputpasssaatini = passwordsaatiniController.text;
                    String inputpassbaru = passwordbaruController.text;

                    if (inputpassbaru.isNotEmpty &&
                        inputpasssaatini.isNotEmpty) {
                      // Password saat ini benar, simpan password baru
                      dbHelper.gantipassword(inputpasssaatini, inputpassbaru);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Password berhasil diubah.",
                          ),
                        ),
                      );
                    } else {
                      // Password saat ini salah
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Password saat ini salah. Ubah password gagal.",
                          ),
                        ),
                      );
                    }

                    // _changePassword(user!);
                  },
                  child: Text("Simpan Password Baru"),
                ),
                SizedBox(height: 200),
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 3),
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            )),
                        width: 150,
                        height: 200,
                        child: Image.asset(
                          'images/profile.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              ' "Duwekku" ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Aplikasi ini dibuat oleh :'),
                            Text('Nama ' + nama),
                            Text('NIM : ' + nim),
                            Text(
                              'Tangal :' + getCurrentDateFormatted(),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
