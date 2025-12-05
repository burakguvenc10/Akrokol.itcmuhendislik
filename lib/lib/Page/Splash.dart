import 'dart:async';
import 'package:flutter/material.dart';
import '../Component/Splash_item.dart';
import '../Model/Splash_model.dart';
import 'package:flutter/services.dart';
import '../Anim/Animated_splash.dart';
import '../main.dart';

class Splash extends StatefulWidget {
  @override
  _SplashPage createState() => _SplashPage();
}

class _SplashPage extends State<Splash> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 1), (){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=> MyHomePage()));
    });
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.red[700],
          child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing:3,
                    crossAxisSpacing: 3,
                    crossAxisCount: 2,
                  ),
                  children: Data.map((item) => Splash_item(item.asset, item.title)).toList(),
                ),
              ),

      ),
    );
  }
}

const Data = [
  Splash_model(asset: 'assets/akrobot_kolu.jpg', title: 'Akrobat Emiş Kolları'),
  Splash_model(asset: 'assets/mobil_unite.png', title: 'Mobil Emiş Üniteleri'),
  Splash_model(asset: 'assets/labaratuvar_kolu.png', title: 'Laboratuvar Emiş Kolu'),
  Splash_model(asset: 'assets/santrifüj.png', title: 'Santrifüj Yağ Ayırıcı'),
  Splash_model(asset: 'assets/vakum_supurge.png', title: 'Vakum Süpürge'),
  Splash_model(asset: 'assets/jetpulse.png', title: 'Jetpulse Toz Toplama Üniteleri'),
  Splash_model(asset: 'assets/sulu_filtre.png', title: 'Sulu Filtre Sistemleri'),
  Splash_model(asset: 'assets/kaynak_tezgah.png', title: 'Taşlama Tezgahları ve Kabinler'),
  Splash_model(asset: 'assets/elektrostatik.png', title: 'Elektrostatik Filtre Sistemleri'),
  Splash_model(asset: 'assets/endustriyel.png', title: 'Havalandırma Kanal Sistemleri'),
  Splash_model(asset: 'assets/aksesuar.png', title: 'Aksesuar ve Yedek Parça'),

];