import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlite_flutter/models/pemasukan.dart';
import 'package:sqlite_flutter/models/user.dart';
import 'package:sqlite_flutter/type/pp_type.dart';

class DbHelper {
  static DbHelper? _dbHelper;
  static Database? _database;
  DbHelper._createObject();

  Future<Database> initDb() async {
    //untuk menentukan nama database dan lokasi yg dibuat
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'finance.db';
    //create, read databases
    var itemDatabase = openDatabase(path, version: 6, onCreate: _createDb);
    //mengembalikan nilai object sebagai hasil dari fungsinya
    return itemDatabase;
  }

  // Future<Database> get database async {
  //   if (_database == null) {
  //     _database = await initDb();
  //   }
  //   return _database!;
  // }
  //buat tabel baru dengan nama item
  void _createDb(Database db, int version) async {
    await db.execute('''
        Create Table user(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          username TEXT,
          password TEXT
          )
          ''');
    await db.execute('''
        CREATE TABLE pemasukan (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date String,
        amount INTEGER,
        deksripsi TEXT,
        tipe TEXT
        )
      ''');
    await db.insert("user", {"username": "user", "password": "user"});
  }

  //create database
  Future<int> insertuser(User object) async {
    Database db = await initDb();
    int count = await db.insert('user', object.toMap());
    return count;
  }

  //create login user
  Future<bool> login(String username, String password) async {
    Database db = await initDb();
    List<Map> maps = await db.query('user',
        where: 'username = ? and password = ?',
        whereArgs: [username, password]);
    if (maps.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<int> gantipassword(String username, String password) async {
    Database db = await initDb();
    int result = await db.rawUpdate(
        'Update user set password = ? where username = ?',
        [password, username]);
    return result;
  }

  //get userlogin
  Future<List<User>> getUserLogin(String username) async {
    Database db = await initDb();
    List<Map<String, dynamic>> maps =
        await db.query('user', where: 'username = ?', whereArgs: [username]);

    List<User> user = [];
    for (int i = 0; i < maps.length; i++) {
      user.add(User.fromMap(maps[i]));
    }
    return user;
  }

  Future<User> getUserByUsername(String username) async {
    Database db = await initDb();
    List<Map<String, dynamic>> maps =
        await db.query('user', where: 'username = ?', whereArgs: [username]);
    return User.fromMap(maps[0]);
  }

  //Pemasukandatabase
  Future<int> insertPemasukandb(Pemasukan object) async {
    Database db = await initDb();
    int count = await db.insert('Pemasukan', object.toMap());
    return count;
  }

  //insert data pemasukan
  Future<int> insertpemasukan(String date, int amount, String deksripsi) async {
    Database db = await initDb();
    Pemasukan pemasukan = Pemasukan(date, amount, deksripsi, tipepemasukan);
    print(pemasukan.toMap());
    int count = await db.insert('Pemasukan', pemasukan.toMap());
    return count;
  }

  //insert data pengeluaran
  Future<int> insertpengeluaran(
      String date, int amount, String deksripsi) async {
    Database db = await initDb();
    Pemasukan pengeluaran = Pemasukan(date, amount, deksripsi, tipepengeluaran);
    int count = await db.insert('Pemasukan', pengeluaran.toMap());
    return count;
  }

  // get total pemasukan
  Future<int> getTotalPemasukan() async {
    Database db = await initDb();
    List<Map<String, dynamic>> maps = await db.rawQuery(
        'SELECT SUM(amount)as total FROM pemasukan WHERE tipe = "pemasukan"');
    if (maps.isNotEmpty && maps[0]['total'] != null) {
      int total = maps[0]['total'];
      return total;
    } else {
      return 0;
    }
  }

  //get total pengeluaran
  Future<int> getTotalPengeluaran() async {
    Database db = await initDb();
    List<Map<String, dynamic>> maps = await db.rawQuery(
        'SELECT SUM(amount) as total FROM pemasukan WHERE tipe = "pengeluaran"');

    if (maps.isNotEmpty && maps[0]['total'] != null) {
      int total = maps[0]['total'];
      return total;
    } else {
      return 0;
    }
  }

  //get data dari database
  Future<List<Pemasukan>> getItemList() async {
    Database db = await initDb();
    List<Map<String, dynamic>> maps = await db.query('Pemasukan');
    List<Pemasukan> pemasukan = [];
    for (int i = 0; i < maps.length; i++) {
      pemasukan.add(Pemasukan.fromMap(maps[i]));
    }
    return pemasukan;
  }

  //create data pemasukan
  Future<int> insertDataPemasukan(Pemasukan object) async {
    Database db = await initDb();
    int count = await db.insert('Pemasukan', object.toMap());
    return count;
  }

  //delete data pemasukan
  Future<void> deleteDataPemasukan(int id) async {
    Database db = await initDb();
    await db.delete('Pemasukan', where: 'id = ?', whereArgs: [id]);
  }

  factory DbHelper() {
    if (_dbHelper == null) {
      _dbHelper = DbHelper._createObject();
    }
    return _dbHelper!;
  }
  Future<Database> get database async {
    if (_database == null) {
      _database = await initDb();
    }
    return _database!;
  }
}
