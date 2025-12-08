import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/foundation.dart';

class Bottombar extends StatelessWidget {
  final Function(int) onTap; // onTap fonksiyonu parametre olarak alınır

  Bottombar({required this.onTap});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return const SizedBox.shrink();
    }

    return ConvexAppBar(
        style: TabStyle.fixedCircle,
        height: 50,
        backgroundColor: Color(0xFDE11010),
        activeColor: Color(0xfff1f0f0),
        items: [
          TabItem(icon: CupertinoIcons.home, title: 'Anasayfa'),
          TabItem(icon: FontAwesomeIcons.wind, title: 'Ürünler'),
          TabItem(icon: CupertinoIcons.info_circle, title: 'Bilgi'),
        ],
        initialActiveIndex: 0,
        onTap: onTap
    );
  }

  @override
  Size get prefferredSize => Size.fromHeight(kToolbarHeight);
}