import 'package:flutter/material.dart';

import 'package:sqflite/sqflite.dart';
import 'package:sqlite_flutter/db/dbhelper.dart';
import 'package:sqlite_flutter/models/pemasukan.dart';
import 'package:sqlite_flutter/type/pp_type.dart';
import 'Entrymasuk.dart';

class Cash extends StatefulWidget {
  @override
  CashState createState() => CashState();
}

class CashState extends State<Cash> {
  DbHelper dbHelper = DbHelper();
  List<Pemasukan> pemasukanData = [];

  void initState() {
    super.initState();
    getdatacash();
  }

  Future<void> getdatacash() async {
    DbHelper dbHelper = DbHelper();
    dbHelper.initDb();
    List<Pemasukan> pemasukan = await dbHelper.getItemList();

    setState(() {
      pemasukanData = pemasukan;
    });
  }

  Future<void> deletedatacash(int index) async {
    DbHelper dbHelper = DbHelper();
    dbHelper.initDb();
    await dbHelper.deleteDataPemasukan(pemasukanData[index].id!);
    setState(() {
      pemasukanData.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Cashflow'),
      ),
      body: ListView.builder(
        itemCount: pemasukanData.length,
        itemBuilder: (context, index) {
          final pemasukan = pemasukanData[index];
          final type = pemasukan.tipe == tipepemasukan;
          return Container(
            child: ListTile(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 2,
                  color: Colors.green.shade400,
                ),
              ),
              trailing: Icon(
                type ? Icons.arrow_forward : Icons.arrow_back_ios,
                color: type ? Colors.green : Colors.red,
                size: 50,
              ),
              title: Text(
                type
                    ? '[ + ] Rp. ' + pemasukan.amount.toString()
                    : '[ - ] Rp. ' + pemasukan.amount.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    pemasukan.deksripsi.toString(),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    pemasukan.date.toString(),
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
              // trailing: GestureDetector(
              //   onTap: () async {
              //     deletedatacash(index);
              //   },
              //   child: Icon(Icons.delete, color: Colors.red),
              // ),
            ),
          );
        },
      ),
    );
  }
}
