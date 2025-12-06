import 'package:flutter/material.dart';
import 'Hava_kanali_Tabview.dart';
import 'Fan_motoru_Tabview.dart';
import 'package:flutter/foundation.dart' show kIsWeb; // Web kontrolü için

class Tabbar extends StatefulWidget {
  const Tabbar({Key? key}) : super(key:key);

  @override
  Tabbar_BodyState createState() => Tabbar_BodyState();
}

class Tabbar_BodyState extends State<Tabbar> {

  @override
  Widget build(BuildContext context) {
    int selectedRadio = 0;

    @override
    void initState() {
      super.initState();
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Center(
          // Web ise maksimum 600-800px genişlik olsun, değilse ekranı kaplasın
          child:Container(
          alignment: Alignment.center,
          constraints: BoxConstraints(maxWidth: kIsWeb ? 800 : double.infinity),
          child: Column(
            children: [
              //TAbBAR
              TabBar(
                indicatorColor: Colors.redAccent,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey[500],
                tabs:[
                  Tab(
                    child: Text('Hava Kanalı',
                    style:TextStyle(
                      fontSize: 18
                      ),
                     ),
                    ),
                  Tab(
                    child: Text('Fan Motoru',
                      style:TextStyle(
                          fontSize: 18
                      ),
                    ),
                  ),
                ],
              ),

              Expanded(
                child: TabBarView(
                    children: [

                      /* TAB 1 */
                        //HAVA KANALI
                      Hava_kanali_Tabview(),

                      /* TAB 2 */
                        // FAN MOTORU TAB_ITEM
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

