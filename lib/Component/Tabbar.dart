import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // kIsWeb için
import 'Hava_kanali_Tabview.dart';
import 'Fan_motoru_Tabview.dart';

class Tabbar extends StatefulWidget {
  const Tabbar({Key? key}) : super(key: key);

  @override
  Tabbar_BodyState createState() => Tabbar_BodyState();
}

class Tabbar_BodyState extends State<Tabbar> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      // Mobilde ve Web'de (Footer'lı sayfada) sadece 2 sekme olacak: Hava Kanalı ve Fan Motoru
      length: 2,
      child: Scaffold(
        body: Center(
          // Web ise içeriği maksimum 800px genişlikte tutarak ortala.
          // Mobil ise (double.infinity) ekranın tamamını kapla.
          child: Container(
            alignment: Alignment.center,
            constraints:
            BoxConstraints(maxWidth: kIsWeb ? 800 : double.infinity),
            child: Column(
              children: [
                // TABBAR MENÜSÜ
                TabBar(
                  indicatorColor: Colors.redAccent,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey[500],
                  tabs: [
                    Tab(
                      child: Text(
                        'Hava Kanalı',
                        style: TextStyle(fontSize: kIsWeb ? 20 : 18),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Fan Motoru',
                        style: TextStyle(fontSize: kIsWeb ? 20 : 18),
                      ),
                    ),
                  ],
                ),

                // SAYFA İÇERİKLERİ
                Expanded(
                  child: TabBarView(
                    children: [
                      /* TAB 1: HAVA KANALI */
                      Hava_kanali_Tabview(),

                      /* TAB 2: FAN MOTORU */
                      Fan_motoru_Tabview(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
