import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqlite_flutter/cashflow.dart';

import 'item.dart';

class EntryForm extends StatefulWidget {
  final Item? item;
  EntryForm(this.item);
  @override
  EntryFormState createState() => EntryFormState(item);
}

//class controller
class EntryFormState extends State<EntryForm> {
  Item? item;
  EntryFormState(this.item);
  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController deksripsiController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //kondisi
    if (item != null) {
      dateController.text = item!.date.toString();
      priceController.text = item!.price.toString();
      deksripsiController.text = item!.deksripsi;
    }
    //rubah
    return Scaffold(
        appBar: AppBar(
          title: item == null ? Text('Tambah') : Text('Ubah'),
          leading: Icon(Icons.keyboard_arrow_left),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
          child: ListView(
            children: <Widget>[
              // date
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(),
                child: TextField(
                  controller: dateController,
                  decoration: InputDecoration(
                    labelText: "Tanggal",
                    icon: Icon(
                      Icons.calendar_today_rounded,
                    ),
                  ),
                  onTap: () async {
                    DateTime? pickeddate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (pickeddate != null) {
                      setState(() {
                        dateController.text =
                            DateFormat('yyyy-MM-dd').format(pickeddate);
                      });
                    }
                  },
                ),
              ),
              // harga
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Harga',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),
              // stock
              // kode barang
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: deksripsiController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Deksripsi',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),
              // tombol button
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Row(
                  children: <Widget>[
                    // tombol simpan
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColorDark,
                            textStyle: TextStyle(
                                color: Theme.of(context).primaryColorLight)),
                        child: Text(
                          'Save',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          if (item == null) {
                            // tambah data
                            item = Item(
                              dateController.text,
                              int.parse(priceController.text),
                              deksripsiController.text,
                            );
                          } else {
                            // ubah data
                            item?.date = dateController.text;
                            item?.price = int.parse(priceController.text);
                            item?.deksripsi = deksripsiController.text;
                          }
                          // kembali ke layar sebelumnya dengan membawa objek item
                          Navigator.pop(context, item);
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => Cash(),
                          //   ),
                          // );
                        },
                      ),
                    ),
                    Container(
                      width: 5.0,
                    ),
                    // tombol batal
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColorDark,
                            textStyle: TextStyle(
                                color: Theme.of(context).primaryColorLight)),
                        child: Text(
                          'Cancel',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
