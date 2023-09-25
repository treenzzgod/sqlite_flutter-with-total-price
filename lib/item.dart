
class Item {
  int? _id;
  String? _date;
  int? _price;
  String? _deksripsi;

  int get id => _id!;

  String get date => _date!;
  set date(String value) => _date = value;

  int get price => _price!;
  set price(int value) => _price = value;

  String get deksripsi => _deksripsi!;
  set deksripsi(String value) => _deksripsi = value;

  Item(
    this._date,
    this._price,
    this._deksripsi,
  );

  Item.fromMap(Map<String, dynamic> map) {
    _id = map['id'];
    _date = map['date'];
    _deksripsi = map['deksripsi'];
    _price = map['price'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = _id;
    map['date'] = date;
    map['price'] = price;
    map['deksripsi'] = deksripsi;
    return map;
  }
}
