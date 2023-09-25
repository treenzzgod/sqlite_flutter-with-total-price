import 'package:flutter/material.dart';
import 'package:sqlite_flutter/home.dart';

import 'home_page.dart';

//package letak folder Anda
void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
 return MaterialApp(
 debugShowCheckedModeBanner: false,
 title: 'Tambahkan Item',
 theme: ThemeData(
 primarySwatch: Colors.blueGrey,
 ),
 home: Homepage(),
 );
 }
}