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
      // Tarayıcı sekmesinde görünen yazı
      title: 'Akrokol Hesaplama',
      theme: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: 'Akrobat-Semibold',
      ),
      // Web'de splash ekranını atlıyoruz
      home: kIsWeb ? MyHomePage() : Animated_splash(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {

  // --- MOBİL İÇİN DEĞİŞKENLER ---
  late TabController _mobileTopTabController;
  int _mobileBottomIndex = 0;

  // --- WEB İÇİN DEĞİŞKENLER ---
  final PageController _webPageController = PageController();

  @override
  void initState() {
    super.initState();
    _mobileTopTabController = TabController(length: 2, vsync: this);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  // --- WEB İÇİN SAYFA DEĞİŞTİRME FONKSİYONU ---
  void _webSayfaDegistir(int index) {
    if (_webPageController.hasClients) {
      _webPageController.jumpToPage(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return _buildWebLayout();
    } else {
      return _buildMobileLayout();
    }
  }

  // ===========================================================================
  // 1. WEB TASARIMI
  // ===========================================================================
  Widget _buildWebLayout() {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 56.0),
        child: Appbar(onPageChange: _webSayfaDegistir),
      ),
      drawer: Drawerbar(),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _webPageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Hava_kanali_Tabview(), // Index 0
                Fan_motoru_Tabview(),  // Index 1
                Bilgi(),               // Index 2
              ],
            ),
          ),
          // DÜZELTME: Footer'a fonksiyonu gönderiyoruz ki linkler çalışsın
          Footer(onLinkTap: _webSayfaDegistir),
        ],
      ),
    );
  }

  // ===========================================================================
  // 2. MOBİL TASARIMI
  // ===========================================================================
  Widget _buildMobileLayout() {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 56.0),
        child: Appbar(onPageChange: (i) {}),
      ),
      drawer: Drawerbar(),
      bottomNavigationBar: Bottombar(onTap: (index) {
        setState(() {
          _mobileBottomIndex = index;
        });
      }),
      body: _getMobileBody(),
    );
  }

  Widget _getMobileBody() {
    switch (_mobileBottomIndex) {
      case 0:
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
        return Urunler();
      case 2:
        return Bilgi();
      default:
        return Container();
    }
  }
}
