import 'package:flutter/material.dart';

class Bilgi extends StatefulWidget {
  @override
  _BilgiPage createState() => _BilgiPage();
}

class _BilgiPage extends State<Bilgi> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(

          child: Column(
            children: [
              Card(
                shadowColor: Colors.black,
                elevation: 5,
                //shape: ,
                margin: EdgeInsets.symmetric(
                  horizontal: 25.0,
                  vertical: 20.0,
                ),
                color:  Color(0xFDDDD8D8),
                  child:Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Hava Kanalı Hız Seçimi",style: TextStyle(color: Colors.black, fontSize: 25),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 20.0, right: 20.0,top: 3),
                          height: 1.0,
                          color: Color(0xFDBDBCBC),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "- Zımpara/bileme/cila 20-25 m/s\n- Hububat/Tahıl/Boya tozu 16-18 m/s\n- Kimyasal ürün 16-22,5 m/s\n- Metal işleme tozu 18-20 m/s\n- Yağ çözücüçözelti/Asidik Gaz 12-17 m/s\n- İplik veya kumaş tiftiği 14-18 m/s\n- Kaynak dumanı 6-9 m/s\n- Tahta talaşı 18-22 m/s\n- Dökümhane tozu 18-23 m/s",
                          style: TextStyle(color: Colors.black, fontSize: 15,),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
              ),

              Card(
                shadowColor: Colors.black,
                elevation: 5,
                //shape: ,
                margin: EdgeInsets.symmetric(
                  horizontal: 25.0,
                  vertical: 20.0,
                ),
                color: Color(0xFDDDD8D8),
                  child:Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Hava Değişim Sayısı",style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 25),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 20.0, right: 20.0,top: 3),
                          height: 1.0,
                          color: Color(0xFDBDBCBC),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "- Kuaförler 10-15 Egzoz+Besleme\n- Hastane/Hasta odası 6-8 Egzoz+Besleme\n- Hastane/Ameliyathane 10-15 Egzoz+Besleme\n- Mutfak (mustakil) 15-25 Egzoz\n- Mutfak (Sanayi) 15-30 Egzoz+Besleme\n- Laboratuarlar 8-15 Egzoz+Besleme\n- Çamaşırhaneler 10-20 Egzoz\n- Kütüphaneler 4-5 Egzoz\n- Asansörler 5-7 Egzoz+Besleme\n- Asansör Makine odası 10-30 Egzoz\n- Makine Daireleri 10-40 Egzoz\n- Ofisler 4-8 Egzoz+Besleme\n- Lokantalar 8-12 Egzoz+Besleme\n- Tuvaletler(özel) 4-5 Egzoz\n- Tuvaletler(Genel) 8-15 Egzoz\n- Dershaneler 5-7 Egzoz\n- Dükkanlar 4-8 Egzoz\n- Duşlar 15-25 Egzoz\n- Süpermarketler 10-15 Egzoz+Besleme\n- Yüzme Havuzları 10-15 Egzoz+Besleme\n- Tiyatrolar 5-8 Egzoz+Besleme\n- Kaynak Atolyeleri 20-30 Egzoz",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                ),



          ],
        ),
      ),
    );
  }
}