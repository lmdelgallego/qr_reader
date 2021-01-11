import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/maps_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QR Reader',
      initialRoute: 'maps',
      routes: {
        'home': (_) => HomePage(),
        'maps': (_) => MapsPage(),
      },
    );
  }
}
