import 'package:flutter/material.dart';

class Drawer_Header extends StatefulWidget {
  @override
  Drawer_HeaderState createState() => Drawer_HeaderState();
}

class Drawer_HeaderState extends State<Drawer_Header> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      width: double.infinity,
      height: 200,
      padding: EdgeInsets.only(top: 26.0),
      child: Image.asset('assets/header.png',fit: BoxFit.contain, width: 100, alignment: Alignment.center,opacity: const AlwaysStoppedAnimation(.6),),
    );
  }
}