import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// 1. implements PreferredSizeWidget eklemeliyiz (AppBar için zorunludur)
class Appbar extends StatelessWidget implements PreferredSizeWidget {

  // 2. Controller'ı dışarıdan almalıyız ki ana sayfayı yönetebilsin
  final PageController pageController;

  // Constructor (Kurucu metod) ile controller'ı istiyoruz
  const Appbar({Key? key, required this.pageController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // HEM MOBİL HEM WEB İÇİN ORTALA
      centerTitle: true,

      // Başlık boşluğunu sıfırla (Web'de menü sığsın diye)
      titleSpacing: 0,

      // --- TITLE KISMI ---
      title: kIsWeb
          ? Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Web Logosu (Beyaz)
          Image.asset('assets/Logo.png', height: 30, color: Colors.white),

          SizedBox(width: 40),

          TextButton.icon(
            icon: Icon(CupertinoIcons.home, color: Colors.white),
            label: Text("Anasayfa", style: TextStyle(color: Colors.white)),
            onPressed: () => pageController.jumpToPage(0),
          ),
          SizedBox(width: 20),
          TextButton.icon(
            icon: Icon(CupertinoIcons.info_circle, color: Colors.white),
            label: Text("Bilgi", style: TextStyle(color: Colors.white)),
            onPressed: () => pageController.jumpToPage(1),
          ),
        ],
      )
      // --- MOBİL GÖRÜNÜMÜ (BEYAZ ZEMİN, KIRMIZI LOGO) ---
          : Image.asset(
        'assets/Logo.png',
        height: 20, // Logo boyutu
        color: Colors.redAccent, // Kırmızı Logo
      ),

      actions: null,

      // --- ARKA PLAN RENGİ AYARI ---
      // Web ise Kırmızı, Mobil ise Beyaz
      backgroundColor: kIsWeb ? Colors.redAccent : Colors.white,

      // --- İKON TEMASI (GERİ BUTONU VS.) ---
      // Mobil arka plan beyaz olduğu için ikonlar kırmızı olsun
      iconTheme: IconThemeData(
        color: kIsWeb ? Colors.white : Colors.redAccent,
      ),

      elevation: 0,
      automaticallyImplyLeading: true,
    );
  }



  // 3. PreferredSizeWidget ayarı
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
