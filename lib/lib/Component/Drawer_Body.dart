import 'package:flutter/material.dart';

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
            margin: const EdgeInsets.only(top: 10.0),
            child:Text(
              "Hakkımızda",style: TextStyle(color: Colors.yellow[700], fontSize: 18),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 80.0, right: 80.0,top: 3,bottom: 4),
            height: 1.0,
            color: Colors.grey.shade400,
          ),
          Padding(
              padding: EdgeInsets.only(left:15,right: 15,bottom: 15),
              child:Text(
              ' 2005 yılında İstanbul’da kurulmuş olan ITC MUHENDISLİK TAAHHÜT ENDÜSTRİYEL SİSTEMLER SAN. VE TİC. LTD. ŞTİ. girişimci ruhu ile farklı iş alanlarında faaliyet göstermekte olup ana faaliyet alanları bina mekanik tesisatı (HVAC), sac işleme ve boyama teknolojileri, boya ve kaplama tesisleri ile toz ve duman emiş sistemlerinin projelendirilmesi ve uygulamalarıdır. Teknoloji ve donanım yönünden sürekli kendini geliştirerek iş hacmini ve kalitesini artırmayı hedefleyen şirketimizin misyonu sürekli ve hızlı gelişen teknoloji destekli mühendislik hizmeti ile, müşterilerin beklentilerini en güvenilir ve en kaliteli ürünlerle yerine getirmektir. Sektöründe yeni projeler üreten ve bunları gerçeğe dönüştüren ITC Mühendislik “doğru zamanda, doğru yerde kaliteli ürünlerle hizmet” ilkesini edinmiştir.'
              ,style: TextStyle(
              fontSize: 14,  fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
              ),
          ),

          Container(
            margin: const EdgeInsets.only(top: 12.0),
            child:Text(
              "Bize Ulaşın",style: TextStyle(color: Colors.yellow[700], fontSize: 18),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 80.0, right: 80.0,top: 3,bottom: 4),
            height: 1.0,
            color: Colors.grey.shade400,
          ),
          Text(
            'ITC MÜHENDİSLİK TAAHHÜT ENDÜSTRİYEL \nSAN. VE TİC. LTD. ŞTİ.\nMerkez / Fabrika Hadımköy Mah.\n Atatürk OSB Mustafa İnan Cad. No: 41/1\n Kat: -2 Arnavutköy – İstanbul'
            ,style: TextStyle(
            fontSize: 16,  fontWeight: FontWeight.bold,
          ),
            textAlign: TextAlign.center,
          ),
          Container(
            margin: const EdgeInsets.only(top:15, left: 40.0),
            child: Column(
            children: [
              Row(
                children: [
                  Image(
                      height: 20,
                      width: 20,
                      image: AssetImage('assets/phone.png'),
                      fit: BoxFit.contain,
                  ),
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
                  Image(
                      height: 20,
                      width: 20,
                      image: AssetImage('assets/fax.png'),
                      fit: BoxFit.contain
                  ),
                  Text(
                    '  0 212 671 70 99'
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
                  Image(
                      height: 20,
                      width: 20,
                      image: AssetImage('assets/mail.png'),
                      fit: BoxFit.contain
                  ),
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
                  Image(
                      height: 20,
                      width: 20,
                      image: AssetImage('assets/web.png'),
                      fit: BoxFit.contain
                  ),
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


