import 'package:flutter/material.dart';
import '../Component/Tabbar.dart';

class Anasayfa extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Anasayfa> {
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body: Tabbar(),
      );

 }
}