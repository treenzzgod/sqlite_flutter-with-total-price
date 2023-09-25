import 'package:flutter/material.dart';

import 'package:sqflite/sqflite.dart';
import 'package:sqlite_flutter/db/dbhelper.dart';
import 'package:sqlite_flutter/item.dart';
import 'entryform.dart';

class Cash extends StatefulWidget {
  @override
  CashState createState() => CashState();
}

class CashState extends State<Cash> {
  DbHelper dbHelper = DbHelper();
  int count = 0;
  List<Item>? itemList;
  @override
  Widget build(BuildContext context) {
    updateListView();

    if (itemList == null) {
      itemList = <Item>[];
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Cashflow'),
      ),
      body: Column(children: [
        Text(
            "total harga: Rp  ${itemList!.fold<int>(0, (sum, item) => sum + item.price)} "),
        Expanded(
          child: createListView(),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              child: Text("Tambah Item"),
              onPressed: () async {
                var item = await navigateToEntryForm(context, null);
                if (item != null) {
                  //TODO 2 Panggil Fungsi untuk Insert ke DB
                  int result = await dbHelper.insert(item);
                  if (result > 0) {
                    updateListView();
                  }
                }
              },
            ),
          ),
        ),
      ]),
    );
  }

  Future<Item?> navigateToEntryForm(BuildContext context, Item? item) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (BuildContext context) {
        return EntryForm(item);
      }),
    );
    return result;
  }

  void updateListView() {
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then((database) {
      //TODO 1 Select data dari DB
      Future<List<Item>> itemListFuture = dbHelper.getItemList();
      itemListFuture.then((itemList) {
        setState(() {
          this.itemList = itemList;
          this.count = itemList.length;
        });
      });
    });
  }

  ListView createListView() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            isThreeLine: true,
            leading: CircleAvatar(
              backgroundColor: Colors.red,
              child: Icon(Icons.ad_units),
            ),
            title: Text(
              this.itemList![index].date.toString(),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Price : " + this.itemList![index].price.toString()),
                SizedBox(
                  height: 5.0,
                ),
                Text("Stock : " + this.itemList![index].deksripsi.toString()),
              ],
            ),
            trailing: GestureDetector(
              child: Icon(Icons.delete),
              onTap: () async {
                //TODO 3 Panggil Fungsi untuk Delete dari DB berdasarkan Item
                dbHelper.delete(itemList![index].id);
                updateListView();
              },
            ),
            onTap: () async {
              var item =
                  await navigateToEntryForm(context, this.itemList![index]);
              //TODO 4 Panggil Fungsi untuk Edit data
              dbHelper.update(item!);
              updateListView();
            },
          ),
        );
      },
    );
  }
}
