import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Anim/Animated_splash.dart';
import 'Component/Appbar.dart';
import 'Component/Bottombar.dart';
import 'Component/Drawerbar.dart';
import 'page/Splash.dart';
import 'page/Urunler.dart';
import 'page/Anasayfa.dart';
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

class _MyHomePageState extends State<MyHomePage> {
  //Başlangıçtaki tab index
  int _selectedIndex = 0;
  final PageController pageController = PageController();

  void onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size(MediaQuery.of(context).size.width,56.0), child: Appbar()),
      bottomNavigationBar: Bottombar(onTap: onTabTapped,),
      body:  PageView(
        controller: pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: <Widget>[
          Anasayfa(),
          Urunler(),
          Bilgi()
        ],
      ),

      drawer: Drawerbar(),

    );
  }


  @override
  void initState(){
    super.initState();
    //Ekran dönmesini engelleme
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,

    ]);
  }
}
