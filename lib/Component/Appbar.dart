import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Appbar extends StatelessWidget implements PreferredSizeWidget {
  final Function(int) onPageChange;

  const Appbar({Key? key, required this.onPageChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    // Ekran çok darsa (örneğin 600px altı) sadece ikon göster,
    // orta genişlikteyse yazı göster.
    bool showText = screenWidth > 750;

    return AppBar(
      backgroundColor: Colors.redAccent,
      elevation: 0,
      centerTitle: kIsWeb ? false : true,
      title: kIsWeb
          ? Row(
        children: [
          // 1. LOGO
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Image.asset('assets/Logo.png', height: 28, color: Colors.white),
          ),

          const Spacer(),

          // 2. BUTONLAR (Dar ekranda sadece ikona dönüşür)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _navButton(
                label: "Hava Kanalı",
                icon: FontAwesomeIcons.wind,
                index: 0,
                showText: showText,
              ),
              const SizedBox(width: 10),
              _navButton(
                label: "Fan Motoru",
                icon: FontAwesomeIcons.fan,
                index: 1,
                showText: showText,
              ),
              const SizedBox(width: 10),
              _navButton(
                label: "Bilgi",
                icon: CupertinoIcons.info_circle,
                index: 2,
                showText: showText,
              ),
            ],
          ),

          const Spacer(flex: 2),
        ],
      )
          : Image.asset('assets/Logo.png', height: 25, color: Colors.white),
      actions: kIsWeb ? [const SizedBox(width: 20)] : null,
    );
  }

  // Akıllı Buton Tasarımı: Genişliğe göre yazı ekler veya kaldırır
  Widget _navButton({
    required String label,
    required IconData icon,
    required int index,
    required bool showText,
  }) {
    return TextButton.icon(
      onPressed: () => onPageChange(index),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 8),
      ),
      icon: FaIcon(icon, color: Colors.white, size: 18),
      label: showText
          ? Text(
        label,
        style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold),
      )
          : const SizedBox.shrink(), // Ekran darsa yazıyı gizle
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
