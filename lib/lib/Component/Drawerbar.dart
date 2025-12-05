import 'package:flutter/material.dart';
import 'Drawer_Body.dart';
import 'Drawer_Header.dart';

class Drawerbar extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Drawer_Header(),
            Drawer_Body(),
          ],
         ),
        ),
      ),
    );

  }
}
