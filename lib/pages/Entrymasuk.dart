import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqlite_flutter/db/dbhelper.dart';

class EntryMasuk extends StatefulWidget {
  @override
  EntryMasukState createState() => EntryMasukState();
}

//class controller
class EntryMasukState extends State<EntryMasuk> {
  TextEditingController dateController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController deksripsiController = TextEditingController();

  DbHelper dbhelper = DbHelper();

  @override
  Widget build(BuildContext context) {
    void initState() {
      super.initState();
      dateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    }

    //reset input
    void reset() {
      dateController.clear();
      amountController.clear();
      deksripsiController.clear();
    }

    //kondisi
    //rubah
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Pemasukan'),
      ),
      body: Stack(
        // scrollDirection: Axis.vertical,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 10,
                  bottom: 10,
                ),
                child: Text(
                  'Tanggal:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 10.0,
                  right: 10,
                ),
                child: Container(
                  // padding: EdgeInsets.all(5),
                  // decoration: BoxDecoration(
                  //     border: Border.all(
                  //   color: Colors.black,
                  // )),
                  child: TextField(
                    controller: dateController,
                    readOnly: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      // labelText: "Tanggal",
                      suffixIcon: Icon(Icons.calendar_month_rounded),
                    ),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          dateController.text =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                        });
                      }
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 10,
                ),
                child: Text(
                  'Nominal:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: 10.0,
                  left: 10,
                  right: 10,
                ),
                child: TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  // decoration: InputDecoration(
                  //   // labelText: 'Amount',
                  //   border: OutlineInputBorder(
                  //     borderRadius: BorderRadius.circular(5.0),
                  //   ),
                  // ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 10,
                ),
                child: Text(
                  'Keterangan:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: 20.0,
                  left: 10,
                  right: 10,
                ),
                child: TextField(
                  controller: deksripsiController,
                  keyboardType: TextInputType.text,
                  // decoration: InputDecoration(
                  //   // labelText: 'Amount',
                  //   border: OutlineInputBorder(
                  //     borderRadius: BorderRadius.circular(5.0),
                  //   ),
                  // ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 3,
                      ),
                    ),
                    shadowColor: Color(
                      0xFF000000,
                    ),
                    primary: Colors.orange,
                    minimumSize: Size(
                      MediaQuery.of(context).size.width * 0.9,
                      40,
                    ),
                  ),
                  onPressed: () {
                    reset();
                  },
                  child: Text(
                    'Reset',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 3,
                      ),
                    ),
                    shadowColor: Color(
                      0xFF000000,
                    ),
                    primary: Colors.green[100],
                    minimumSize: Size(
                      MediaQuery.of(context).size.width * 0.9,
                      40,
                    ),
                  ),
                  onPressed: () async {
                    String date = dateController.text;
                    int amount = int.parse(amountController.text);
                    String deksripsi = deksripsiController.text;

                    if (date.toString().isNotEmpty &&
                        amount.toString().isNotEmpty &&
                        deksripsi.isNotEmpty) {
                      int count = await dbhelper.insertpemasukan(
                        date,
                        amount,
                        deksripsi,
                      );
                      if (count > 0) {
                        reset();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Pemasukan Berhasil Ditambahkan',
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Pemasukan Gagal',
                            ),
                          ),
                        );
                      }
                    }
                  },
                  child: Text(
                    'Simpan',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 3,
                      ),
                    ),
                    shadowColor: Color(
                      0xFF000000,
                    ),
                    primary: Colors.blue,
                    minimumSize: Size(
                      MediaQuery.of(context).size.width * 0.9,
                      40,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    '<< Kembali',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
