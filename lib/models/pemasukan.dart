import 'package:flutter/material.dart';

class Pemasukan {
  int? _id;
  String? _date;
  int? _amount;
  String? _deksripsi;
  String? _tipe;

  int? get id => _id!;

  String? get date => _date;
  set date(String? value) {
    _date = value;
  }

  int? get amount => _amount!;
  set amount(int? value) {
    _amount = value;
  }

  String? get deksripsi => _deksripsi!;
  set deksripsi(String? value) {
    _deksripsi = value;
  }

  String? get tipe => _tipe!;
  set tipe(String? value) {
    _tipe = value;
  }

  Pemasukan(this._date, this._amount, this._deksripsi, this._tipe);

  Pemasukan.fromMap(Map<String, dynamic> map) {
    _id = map['id'];
    _date = map['date'];
    _amount = map['amount'];
    _deksripsi = map['deksripsi'];
    _tipe = map['tipe'];
  }
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = _id;
    map['date'] = _date;
    map['amount'] = _amount;
    map['deksripsi'] = _deksripsi;
    map['tipe'] = _tipe;
    return map;
  }
}
