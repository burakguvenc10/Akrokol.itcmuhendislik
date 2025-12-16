import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart'; // kIsWeb için

// --- IMPORTLAR ---
import 'Anim/Animated_splash.dart';
import 'Component/Appbar.dart';
import 'Component/Bottombar.dart';
import 'Component/Drawerbar.dart';
import 'Component/Footer.dart';

// Sayfalar
import 'Component/Hava_kanali_Tabview.dart';
import 'Component/Fan_motoru_Tabview.dart';
import 'page/Urunler.dart';
import 'page/Bilgi.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Akrokol',
      theme: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: 'Akrobat-Semibold',
      ),
      home: Animated_splash(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {

  // --- MOBİL İÇİN DEĞİŞKENLER ---
  // Mobilde Anasayfa içindeki 2 sekmeyi (Hava/Fan) yönetir
  late TabController _mobileTopTabController;
  // Mobilde BottomBar geçişlerini yönetir (0: Anasayfa, 1: Ürünler, 2: Bilgi)
  int _mobileBottomIndex = 0;

  // --- WEB İÇİN DEĞİŞKENLER ---
  // Web'de sayfalar arası geçişi yönetir (0: Hava, 1: Fan, 2: Bilgi)
  final PageController _webPageController = PageController();

  @override
  void initState() {
    super.initState();
    // Mobilde üstte sadece 2 sekme var: Hava Kanalı ve Fan Motoru
    _mobileTopTabController = TabController(length: 2, vsync: this);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  // --- WEB İÇİN SAYFA DEĞİŞTİRME ---
  void _webSayfaDegistir(int index) {
    _webPageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    // BURASI ÇOK ÖNEMLİ:
    // Web ve Mobil için tamamen farklı yapılar döndürüyoruz.
    if (kIsWeb) {
      return _buildWebLayout();
    } else {
      return _buildMobileLayout();
    }
  }

  // ===========================================================================
  // 1. WEB TASARIMI (Tabbar Yok, AppBar Butonları Var, Footer Var)
  // ===========================================================================
  Widget _buildWebLayout() {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 56.0),
        // Web'de AppBar butonları çalışsın diye fonksiyonu veriyoruz
        child: Appbar(onPageChange: _webSayfaDegistir),
      ),

      // --- DRAWER EKLENDİ (WEB) ---
      drawer: Drawerbar(),

      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _webPageController,
              physics: const NeverScrollableScrollPhysics(), // Kaydırma kapalı, tıklama ile geçiş
              children: [
                Hava_kanali_Tabview(), // Index 0
                Fan_motoru_Tabview(),  // Index 1
                Bilgi(),               // Index 2
              ],
            ),
          ),
          // Footer Web'de sabit
          const Footer(),
        ],
      ),
    );
  }

  // ===========================================================================
  // 2. MOBİL TASARIMI (Üstte Tabbar, Altta BottomBar)
  // ===========================================================================
  Widget _buildMobileLayout() {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 56.0),
        // Mobilde AppBar butonları işlevsiz, sadece logo ve başlık için
        child: Appbar(onPageChange: (i) {}),
      ),

      // --- DRAWER EKLENDİ (MOBİL) ---
      drawer: Drawerbar(),

      // Bottom Bar Tıklamaları
      bottomNavigationBar: Bottombar(onTap: (index) {
        setState(() {
          _mobileBottomIndex = index;
        });
      }),

      // İçerik, BottomBar'a göre değişiyor
      body: _getMobileBody(),
    );
  }

  // Mobilde hangi sayfanın gösterileceğini seçen fonksiyon
  Widget _getMobileBody() {
    switch (_mobileBottomIndex) {
      case 0:
      // --- ANASAYFA (Hava Kanalı ve Fan Motoru Sekmeleri) ---
        return Column(
          children: [
            Container(
              color: Colors.white,
              child: TabBar(
                controller: _mobileTopTabController,
                indicatorColor: Colors.redAccent,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey[500],
                tabs: const [
                  Tab(child: Text('Hava Kanalı', style: TextStyle(fontSize: 18))),
                  Tab(child: Text('Fan Motoru', style: TextStyle(fontSize: 18))),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _mobileTopTabController,
                children: [
                  Hava_kanali_Tabview(),
                  Fan_motoru_Tabview(),
                ],
              ),
            ),
          ],
        );

      case 1:
      // --- ÜRÜNLER SAYFASI ---
        return Urunler();

      case 2:
      // --- BİLGİ SAYFASI ---
        return Bilgi();

      default:
        return Container();
    }
  }
}
