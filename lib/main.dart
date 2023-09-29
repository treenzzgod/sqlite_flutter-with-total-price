import 'package:flutter/material.dart';
import 'package:sqlite_flutter/pages/pages.dart';

//package letak folder Anda

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "FinPlan App",
      initialRoute: '/',
      routes: {
        '/': (context) => Login(),
        '/home': (context) => Home(),
        '/entrymasuk': (context) => EntryMasuk(),
        '/entryluar': (context) => EntryLuar(),
        '/cashflow': (context) => Cash(),
        '/setting': (context) => Setting(),
      },
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
    );
  }
}
