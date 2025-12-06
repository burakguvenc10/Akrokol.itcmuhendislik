import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Drawer_Body extends StatefulWidget {
  @override
  Drawer_BodyState createState() => Drawer_BodyState();
}

class Drawer_BodyState extends State<Drawer_Body> {
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 5.0),
            child:Text(
              "Hakkımızda",style: TextStyle(color: Colors.black26, fontSize: 15),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 80.0, right: 80.0,top: 3,bottom: 2),
            height: 1.0,
            color: Colors.grey.shade400,
          ),
          Padding(
              padding: EdgeInsets.only(left:15,right: 15,bottom: 15),
              child:Text(
              ' 2005 yılında İstanbul’da kurulmuş olan ITC MUHENDISLİK TAAHHÜT ENDÜSTRİYEL SİSTEMLER SAN. VE TİC. LTD. ŞTİ. girişimci ruhu ile farklı iş alanlarında faaliyet göstermekte olup ana faaliyet alanları bina mekanik tesisatı (HVAC), sac işleme ve boyama teknolojileri, boya ve kaplama tesisleri ile toz ve duman emiş sistemlerinin projelendirilmesi ve uygulamalarıdır. Teknoloji ve donanım yönünden sürekli kendini geliştirerek iş hacmini ve kalitesini artırmayı hedefleyen şirketimizin misyonu sürekli ve hızlı gelişen teknoloji destekli mühendislik hizmeti ile, müşterilerin beklentilerini en güvenilir ve en kaliteli ürünlerle yerine getirmektir. Sektöründe yeni projeler üreten ve bunları gerçeğe dönüştüren ITC Mühendislik “doğru zamanda, doğru yerde kaliteli ürünlerle hizmet” ilkesini edinmiştir.'
              ,style: TextStyle(
              fontSize: 13,  fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
              ),
          ),

          Container(
            margin: const EdgeInsets.only(top: 2.0),
            child:Text(
              "Bize Ulaşın",style: TextStyle(color: Colors.black26, fontSize: 15),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 80.0, right: 80.0,top: 3,bottom: 4),
            height: 1.0,
            color: Colors.grey.shade400,
          ),
          Text(
            'ITC MÜHENDİSLİK TAAHHÜT ENDÜSTRİYEL \nSAN. VE TİC. LTD. ŞTİ.\nFabrika:\nOsmangazi Mah.Ayasofya Cad.No:49/1\nEsenyurt- İstanbul'
            ,style: TextStyle(
            fontSize: 16,  fontWeight: FontWeight.bold,
          ),
            textAlign: TextAlign.center,
          ),
          Container(
            margin: const EdgeInsets.only(top:12, left: 40.0),
            child: Column(
            children: [
              Row(
                children: [
                  FaIcon(FontAwesomeIcons.phone, color: Colors.green,weight: 3,fontWeight: FontWeight.bold),

                  Text(
                    '  0 212 671 70 97 – 98'
                    ,style: TextStyle(
                    fontSize: 16,  fontWeight: FontWeight.bold,
                  ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),

              SizedBox(
                height: 6,
              ),

              Row(
                children: [
                  FaIcon(FontAwesomeIcons.google, color: Colors.red,weight: 3,fontWeight: FontWeight.bold),
                  Text(
                    '  itc@itcmuhendislik.com'
                    ,style: TextStyle(
                    fontSize: 16,  fontWeight: FontWeight.bold,
                  ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),

              SizedBox(
                height: 6,
              ),

              Row(
                children: [
                  FaIcon(FontAwesomeIcons.globe, color: Colors.blueAccent,weight: 3, fontWeight: FontWeight.bold,),

                  Text(
                    '  akrokol.itcmuhendislik.com'
                    ,style: TextStyle(
                    fontSize: 16,  fontWeight: FontWeight.bold,
                  ),
                    textAlign: TextAlign.center,
                  ),
                ],
               ),
             ],
            ),
          ),

          SizedBox(
            height: 17,
          ),
        ],


      ),
    );
  }
}


