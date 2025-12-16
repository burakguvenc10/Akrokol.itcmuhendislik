import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb; // Web kontrolü için

class Appbar extends StatelessWidget implements PreferredSizeWidget {
  // Sayfa değiştirmek için dışarıdan bir fonksiyon alıyoruz
  final Function(int) onPageChange;

  const Appbar({Key? key, required this.onPageChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.redAccent,
      // Logo ve Başlık
      title: Row(
        mainAxisSize: MainAxisSize.min, // Sadece içeriği kadar yer kapla
        children: [
          // Logonuz varsa:
          Image.asset('assets/Logo.png', height: 20, color: Colors.white),
        ],
      ),

      // --- WEB İÇİN NAVİGASYON BUTONLARI ---
      actions: kIsWeb
          ? [
        // 1. HAVA KANALI BUTONU
        TextButton(
          onPressed: () => onPageChange(0), // 0. Sayfaya git
          child: Text(
            "Hava Kanalı",
            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),

        SizedBox(width: 20),

        // 2. FAN MOTORU BUTONU
        TextButton(
          onPressed: () => onPageChange(1), // 1. Sayfaya git
          child: Text(
            "Fan Motoru",
            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),

        SizedBox(width: 20),

        // 3. BİLGİ BUTONU (Varsa)
        TextButton(
          onPressed: () => onPageChange(2), // 2. Sayfaya git
          child: Text(
            "Bilgi",
            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),

        SizedBox(width: 20), // Sağ boşluk
      ]
          : null, // Mobil ise actions boş kalsın (veya hamburger menü vs.)

      centerTitle: kIsWeb ? false : true, // Web'de sola yaslı, mobilde ortalı
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
