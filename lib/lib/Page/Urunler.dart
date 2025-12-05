import 'package:flutter/material.dart';
import '../Component/Webview_item.dart';
import '../Page/Webview.dart';

class Urunler extends StatefulWidget {
  @override
  _UrunlerPage createState() => _UrunlerPage();
}

class _UrunlerPage extends State<Urunler> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Scrollbar(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Webview_item(),
            /*child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  crossAxisCount: 2,
                ),
                itemCount: Assets.length,
                itemBuilder: (BuildContext context, int index){
                  return GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Webview()));
                    },
                    child: new Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(padding: EdgeInsets.all(4)),
                          Image.asset(
                            "${Assets[index]['asset']}",
                            height: 140,
                            fit: BoxFit.fill,
                          ),

                          Text(
                            "${Title[index]['title']}",
                            style: TextStyle(fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      color: Colors.white,
                      shadowColor: Colors.black,
                      elevation: 5,

                    ),
                  );
                },*/

         ),
      ),
    );
  }
}

/*const Assets = [
  {
    "asset" : "assets/akrobot_kolu.jpg"
  },
  {
    "asset" : "assets/mobil_unite.png"
  },
  {
    "asset" : "assets/labaratuvar_kolu.png"
  },
  {
    "asset" : "assets/santrifüj.png"
  },
  {
    "asset" : "assets/vakum_supurge.png"
  },
  {
    "asset" : "assets/jetpulse.png"
  },
  {
    "asset" : "assets/sulu_filtre.png"
  },
  {
    "asset" : "assets/kaynak_tezgah.png"
  },
  {
    "asset" : "assets/elektrostatik.png"
  },
  {
    "asset" : "assets/endustriyel.png"
  },
  {
    "asset" : "assets/aksesuar.png"
  },

];

const Title = [
  {
    "title" : "Akrobat Emiş Kolları"
  },
  {
    "title" : "Mobil Emiş Üniteleri"
  },
  {
    "title" : "Laboratuvar Emiş Kolu"
  },
  {
    "title" : "Santrifüj Yağ Ayırıcı"
  },
  {
    "title" : "Vakum Süpürge"
  },
  {
    "title" : "Jetpulse Toz Toplama Üniteleri"
  },
  {
    "title" : "Sulu Filtre Sistemleri"
  },
  {
    "title" : "Taşlama Tezgahları ve Kabinler"
  },
  {
    "title" : "Elektrostatik Filtre Sistemleri"
  },
  {
    "title" : "Havalandırma Kanal Sistemleri"
  },
  {
    "title" : "Aksesuar ve Yedek Parça"
  },

];*/