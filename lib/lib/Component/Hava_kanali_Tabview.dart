import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:io';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:universal_html/html.dart' as html; // Web indirme işlemleri için
import 'package:flutter/foundation.dart' show kIsWeb; // Web kontrolü için


//---- CONTROLLER TANIMLARI ----
//Havahizi
final Havadebisi_controller = TextEditingController(text: '0');
final Kanalcapi_controller = TextEditingController(text: '0');
final Havahizi_controller = TextEditingController(text: '0');

//Prizmatik_kanal
final PrizmatikkanalA_controller = TextEditingController(text: '0');
final PrizmatikkanalB_controller = TextEditingController(text: '0');
final KanalYuzeyi =  TextEditingController(text: '');
final Basinckaybi_controller = TextEditingController(text: '0');
final Kanalboyu_controller = TextEditingController(text: '0');
final Kanalalani_controller = TextEditingController(text: '0');
final Toplambasinckaybi_controller = TextEditingController(text: '0');

//Dirsek Alanı
final Aci_controller = TextEditingController();
final R1_controller = TextEditingController();
final DirsekAlani_controller = TextEditingController();


//Checkbox
String sec = '';
//Check
bool prizmatikkanalB_check = false;
bool basinckaybi_check = false;
bool kanalalani_check = false;
bool toplambasinckaybi_check = false;
bool dirsekalani_check = false;


class Hava_kanali_Tabview extends StatefulWidget {
  @override
  Hava_kanali createState() => Hava_kanali();
}

class Hava_kanali extends State<Hava_kanali_Tabview>{

  final _formkeyHava = GlobalKey<FormState>();
  String _IsEmpty = '';

  @override
  Widget build(BuildContext context) {
    int selectedRadio = 0;
    void tumAlanlariTemizle() {
      setState(() {
        // 1. Controller'ları varsayılan değerlerine döndür
        Havadebisi_controller.text = '0';
        Kanalcapi_controller.text = '0';
        Havahizi_controller.text = '0';

        PrizmatikkanalA_controller.text = '0';
        PrizmatikkanalB_controller.text = '0';
        Basinckaybi_controller.text = '0';
        Kanalboyu_controller.text = '0';
        Kanalalani_controller.text = '0';
        Toplambasinckaybi_controller.text = '0';

        // Boş başlayanları temizle
        Aci_controller.clear();
        R1_controller.clear();
        DirsekAlani_controller.clear();

        // 2. Kontrol değişkenlerini (bool) sıfırla
        prizmatikkanalB_check = false;
        basinckaybi_check = false;
        kanalalani_check = false;
        toplambasinckaybi_check = false;
        dirsekalani_check = false;

        // Eğer bir RadioButton değişkeniniz varsa onu da sıfırlayabilirsiniz
        // selectedRadio = 0;
      });

      // Kullanıcıya bilgi verelim
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Tüm alanlar temizlendi."),
            duration: Duration(seconds: 1),
            backgroundColor: Colors.orangeAccent,
          )
      );
    }

    return Container(
      ///HAVA KANALI TAB_ITEM
      child: SingleChildScrollView(
          child: Center( // 1. Ortalamak için Center ekleyin
            child: SizedBox( // 2. Genişliği sınırlamak için SizedBox ekleyin
              // Web ise maksimum 600px genişlik olsun, değilse (mobil) tam ekran
              width: kIsWeb ? 600 : double.infinity,
              child: Card(
                elevation: 8,
                shadowColor: Colors.black,
                margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(color: Colors.grey.shade200, width: 1),
                ),
                color: Colors.white,
                child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Form(
                key: _formkeyHava,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                children: [
                Container(
                  alignment: Alignment.centerRight,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                            children: [
                              IconButton(
                                alignment: Alignment.topRight,
                                iconSize: 32,
                                icon: FaIcon(FontAwesomeIcons.solidFileExcel, color: Colors.green),
                                onPressed: () {
                                  if ((Havadebisi_controller.text.isEmpty || Havadebisi_controller.text == '0') && (Kanalcapi_controller.text.isEmpty || Kanalcapi_controller.text == '0')) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text("Lütfen Hesaplama Yapınız"))
                                    );
                                  } else {
                                    excelExportHavaKanali(context);
                                  }
                                },
                              ),
                              Text("Paylaş ve İndir", style: TextStyle(fontSize: 8,color: Colors.black26), textAlign: TextAlign.center,),
                            ],
                          ),

                          SizedBox(width: 1), // İki buton arasına boşluk

                          Column(
                            children: [
                              IconButton(
                                iconSize: 32,
                                // Çöp kutusu ikonu
                                icon: FaIcon(FontAwesomeIcons.trashCan, color: Colors.red),
                                onPressed: () {
                                  // Temizleme fonksiyonunu çağır
                                  tumAlanlariTemizle();
                                },
                              ),
                              Text("Temizle", style: TextStyle(fontSize: 8, color: Colors.black26)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                /// HAVA HIZI
                Text(
                  '- Hava Hızı -',
                  style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                ),

                SizedBox(
                  height: 13,
                ),

                TextFormField(
                  controller: Havadebisi_controller,
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.redAccent),
                    border: OutlineInputBorder(),
                    labelText: 'Hava Debisi',
                    suffixIcon: IconButton(
                      onPressed: Havadebisi_controller.clear,
                      icon: Icon(Icons.clear_sharp),
                      color: Colors.red,
                    ),
                    suffixText: 'm3/h',
                    hintText: 'Hava Debisini Yazınız (m3/h)',
                  ),
                  maxLines: 1,
                  onSaved: (deger) {
                  },
                  onChanged: (deger){
                    Havadebisi_controller.value.text;
                    setState((){
                      if(Havadebisi_controller.value.text!= null && Kanalcapi_controller.value.text!= null ){
                        Havahizi_Sonuc();
                        if(PrizmatikkanalA_controller.value.text != null && Kanalcapi_controller.value.text != null){
                          prizmatikkanalB_check = true;
                          PrizmatikkanalB_Sonuc();
                            if(PrizmatikkanalA_controller.value.text != null && PrizmatikkanalB_controller.value.text != null && Kanalboyu_controller.value.text != null) {
                              KanalAlani_Sonuc();
                              kanalalani_check = true;
                            }
                            else{
                              kanalalani_check = false;
                            }
                            if(Aci_controller.value != null && R1_controller.value != null){
                              DirsekAlani_Sonuc();
                              dirsekalani_check = true;
                            }
                            else{
                              dirsekalani_check = false;
                            }
                        }
                        else{
                          prizmatikkanalB_check = false;
                        }
                      }
                      if(Havadebisi_controller.value.text != null && Havahizi_controller.value.text != null){
                        Kanalcapi_Sonuc();
                        Basinckaybi_Sonuc();
                        basinckaybi_check = true;
                          if(Kanalboyu_controller.value.text != null && Basinckaybi_controller.value.text != null){
                            ToplambasincKaybi_Sonuc();
                            toplambasinckaybi_check = true;
                          }
                          else{
                            toplambasinckaybi_check = false;
                          }
                      }
                      else{
                        basinckaybi_check = false;
                      }

                    });
                  },
                  keyboardType: TextInputType.number,
                  validator: (deger) {
                    if (deger!.isEmpty) {
                      return 'Bir Değer Girmediniz!';
                    }
                    else{
                      return null;
                    }
                  },
                ),

                SizedBox(
                  height: 17,
                ),

                  TextFormField(
                    controller: Kanalcapi_controller,
                    decoration: InputDecoration(
                      errorStyle: TextStyle(color: Colors.redAccent),
                      border: OutlineInputBorder(),
                      labelText: 'Kanal Çapı',
                      hintText: 'Kanal Çapını(mm) Yazınız',

                      // 3 Butonu yan yana koymak için Row
                      suffixIcon: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[

                          // 1. Arttır Butonu
                          IconButton(
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                            color: Colors.red,
                            icon: Icon(Icons.add_circle),
                            iconSize: 24,
                            onPressed: () {
                              setState(() {
                                KanalcapiArttir();
                                if(Havadebisi_controller.value.text.isNotEmpty){
                                  // Hesaplama fonksiyonlarını çağır
                                  Havahizi_Sonuc();
                                  Basinckaybi_Sonuc();
                                }
                              });
                            },
                          ),

                          // 2. Azalt Butonu
                          IconButton(
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                            color: Colors.red,
                            icon: Icon(Icons.remove_circle),
                            iconSize: 24,
                            onPressed: () {
                              setState(() {
                                KanalcapiAzalt();
                                if(Havadebisi_controller.value.text.isNotEmpty){
                                  Havahizi_Sonuc();
                                  Basinckaybi_Sonuc();
                                }
                              });
                            },
                          ),

                          // 3. (GERİ EKLENEN) Temizleme Butonu
                          IconButton(
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                            icon: Icon(Icons.clear_sharp),
                            color: Colors.red,
                            iconSize: 24,
                            onPressed: () {
                              Kanalcapi_controller.clear();
                            },
                          ),

                        ],
                      ),
                    ),
                    maxLines: 1,
                    keyboardType: TextInputType.number,
                    // ... Diğer özellikler
                  ),

                  SizedBox(
                  height: 17,
                ),

                TextFormField(
                  controller: Havahizi_controller,
                  decoration: InputDecoration(
                    hintText: 'Hava Hızını Yazınız (m/s)',
                    errorStyle: TextStyle(color: Colors.redAccent),
                    border: OutlineInputBorder(),
                    labelText: 'Hava Hızı',
                    suffixIcon: IconButton(
                      onPressed: Havahizi_controller.clear,
                      icon: Icon(Icons.clear_sharp),
                      color: Colors.red,
                    ),
                    suffixText: 'm/s',
                  ),
                  keyboardType: TextInputType.number,
                  maxLines: 1,
                  onSaved: (deger) {
                    setState(() {
                    });
                  },
                  onChanged: (deger){
                    setState((){
                      Havahizi_controller.value.text;
                      if(Havadebisi_controller.value.text != null && Havahizi_controller.value.text != null){
                        Kanalcapi_Sonuc();
                        if(PrizmatikkanalA_controller.value.text != null && Kanalcapi_controller.value.text != null){
                          prizmatikkanalB_check = true;
                          PrizmatikkanalB_Sonuc();
                            if(PrizmatikkanalA_controller.value.text != null && PrizmatikkanalB_controller.value.text != null && Kanalboyu_controller.value.text != null) {
                              KanalAlani_Sonuc();
                              kanalalani_check = true;
                            }
                            else{
                              kanalalani_check = false;
                            }
                            if(Aci_controller.value != null && R1_controller.value != null){
                              DirsekAlani_Sonuc();
                              dirsekalani_check = true;
                            }
                            else{
                              dirsekalani_check = false;
                            }
                        }
                        else{
                          prizmatikkanalB_check = false;
                        }
                        Basinckaybi_Sonuc();
                        basinckaybi_check = true;
                          if(Kanalboyu_controller.value.text != null && Basinckaybi_controller.value.text != null){
                            ToplambasincKaybi_Sonuc();
                            toplambasinckaybi_check = true;
                          }
                          else{
                            toplambasinckaybi_check = false;
                          }
                      }
                      else{
                        basinckaybi_check = false;
                      }
                    });
                  },
                  validator: (deger) {
                    if (deger!.isEmpty) {
                      return 'Bir Değer Girmediniz!';
                    }
                    else {
                      return null;
                    }
                  },
                ),

                SizedBox(
                  height: 20,
                ),

                /// PRİZMATİK KANAL
                Text(
                  '- Prizmatik Kanal -',
                  style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                ),

                SizedBox(
                  height: 13,
                ),

                TextFormField(
                  controller: PrizmatikkanalA_controller,
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.redAccent),
                    border: OutlineInputBorder(),
                    labelText: 'Prizmatik Kanal A',
                    suffixIcon: IconButton(
                      onPressed: PrizmatikkanalA_controller.clear,
                      icon: Icon(Icons.clear_sharp),
                      color: Colors.red,
                    ),
                    suffixText: 'mm',
                    hintText: 'Prizmatik Kanal A değerini Yazınız (mm)',
                  ),
                  maxLines: 1,
                  onSaved: (deger) {
                    _IsEmpty = deger!;
                    setState(() {
                    });
                  },
                  onChanged: (deger){
                    setState((){
                      PrizmatikkanalA_controller.value.text;
                      if(PrizmatikkanalA_controller.value.text != null && Kanalcapi_controller.value.text != null){
                        prizmatikkanalB_check = true;
                        PrizmatikkanalB_Sonuc();
                          if(PrizmatikkanalA_controller.value.text != null && PrizmatikkanalB_controller.value.text != null && Kanalboyu_controller.value.text != null) {
                            KanalAlani_Sonuc();
                            kanalalani_check = true;
                          }
                          else{
                            kanalalani_check = false;
                          }
                          if(Aci_controller.value != null && R1_controller.value != null){
                            DirsekAlani_Sonuc();
                            dirsekalani_check = true;
                          }
                          else{
                            dirsekalani_check = false;
                          }
                      }
                      else{
                        prizmatikkanalB_check = false;
                      }
                      if(PrizmatikkanalA_controller.value.text != null && PrizmatikkanalB_controller.value.text != null && Kanalboyu_controller.value.text != null){
                        KanalAlani_Sonuc();
                        kanalalani_check = true;
                        if(Kanalboyu_controller.value.text != null && Basinckaybi_controller.value.text != null){
                          ToplambasincKaybi_Sonuc();
                          toplambasinckaybi_check = true;
                        }
                        else{
                          toplambasinckaybi_check = false;
                        }
                      }
                      else{
                        kanalalani_check = false;
                      }
                    });
                  },
                  keyboardType: TextInputType.number,
                  validator: (deger) {
                    if (deger!.isEmpty) {
                      return 'Bir Değer Girmediniz!';
                    } else {
                      return null;
                    }
                  },
                ),

                SizedBox(
                  height: 17,
                ),

                TextFormField(
                  controller: PrizmatikkanalB_controller,
                  enabled: prizmatikkanalB_check,
                  showCursor: false,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.lightGreen,
                        )
                    ),
                    errorStyle: TextStyle(color: Colors.redAccent),
                    border: OutlineInputBorder(),
                    labelText: 'Prizmatik Kanal B: ',
                    suffixText: 'mm',
                  ),
                  keyboardType: TextInputType.none,
                  maxLines: 1,
                  onSaved: (deger) {
                    setState(() {
                    });
                  },
                  onChanged: (deger){
                    setState((){
                      PrizmatikkanalB_controller.value.text;
                      if(PrizmatikkanalA_controller.value.text != null && PrizmatikkanalB_controller.value.text != null && Kanalboyu_controller.value.text != null) {
                        KanalAlani_Sonuc();
                        kanalalani_check = true;
                      }
                      else{
                        kanalalani_check = false;
                      }
                      if(Aci_controller.value != null && R1_controller.value != null){
                        DirsekAlani_Sonuc();
                        dirsekalani_check = true;
                      }
                      else{
                        dirsekalani_check = false;
                      }
                    });
                  },
                ),

                SizedBox(
                  height: 25,
                ),

                /// KANAL YÜZEYİ
                Text(
                  '- Kanal Yüzeyi -',
                  style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                ),

                //RadioButtons
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Row(
                  children: [
                    // 1. Seçenek
                    Expanded(
                      child: RadioListTile(
                            value: '0.023',
                            groupValue: sec,
                            activeColor: Colors.red,
                            onChanged: (deger){
                              setState(() {
                                if(Havadebisi_controller.value.text != null && Havahizi_controller.value.text != null){
                                  sec = deger.toString();
                                  Basinckaybi_Sonuc();
                                  basinckaybi_check = true;
                                  KanalYuzeyi.text = "Çok Düzgün";
                                }
                                else{
                                  basinckaybi_check = false;
                                }
                                if(Kanalboyu_controller.value.text != null && Basinckaybi_controller.value.text != null){
                                  ToplambasincKaybi_Sonuc();
                                  toplambasinckaybi_check = true;
                                  KanalYuzeyi.text = "Çok Düzgün";
                                }
                                else{
                                  toplambasinckaybi_check = false;
                                }
                              });
                            },title: Text('Çok Düzgün'),
                          ),
                    ),
                    Expanded(
                      child: RadioListTile(
                              value: '0.03',
                              groupValue: sec,
                              activeColor: Colors.red,
                              onChanged: (deger){
                                setState(() {
                                  if(Havadebisi_controller.value.text != null && Havahizi_controller.value.text != null){
                                    sec = deger.toString();
                                    Basinckaybi_Sonuc();
                                    basinckaybi_check = true;
                                    KanalYuzeyi.text = "Düzgün";
                                  }
                                  else{
                                    basinckaybi_check = false;
                                  }
                                  if(Kanalboyu_controller.value.text != null && Basinckaybi_controller.value.text != null){
                                    ToplambasincKaybi_Sonuc();
                                    toplambasinckaybi_check = true;
                                    KanalYuzeyi.text = "Düzgün";
                                  }
                                  else{
                                    toplambasinckaybi_check = false;
                                  }
                                });
                              },title: Text('Düzgün'),
                            ),
                    ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile(
                          value: '0.05',
                          groupValue: sec,
                          activeColor: Colors.red,
                          onChanged: (deger){
                            setState(() {
                              if(Havadebisi_controller.value.text != null && Havahizi_controller.value.text != null){
                                sec = deger.toString();
                                Basinckaybi_Sonuc();
                                basinckaybi_check = true;
                                KanalYuzeyi.text = "Pürüzlü";
                              }
                              else{
                                basinckaybi_check = false;
                              }
                              if(Kanalboyu_controller.value.text != null && Basinckaybi_controller.value.text != null){
                                ToplambasincKaybi_Sonuc();
                                toplambasinckaybi_check = true;
                                KanalYuzeyi.text = "Pürüzlü";
                              }
                              else{
                                toplambasinckaybi_check = false;
                              }
                            });
                          },title: Text('Pürüzlü'),
                        ),
                      ),
                      Expanded(
                        child: RadioListTile(
                          value: '0.06',
                          groupValue: sec,
                          activeColor: Colors.red,
                          onChanged: (deger){
                            setState(() {
                              if(Havadebisi_controller.value.text != null && Havahizi_controller.value.text != null){
                                sec = deger.toString();
                                Basinckaybi_Sonuc();
                                basinckaybi_check = true;
                                KanalYuzeyi.text = "Çok Pürüzlü";
                              }
                              else{
                                basinckaybi_check = false;
                              }
                              if(Kanalboyu_controller.value.text != null && Basinckaybi_controller.value.text != null){
                                ToplambasincKaybi_Sonuc();
                                toplambasinckaybi_check = true;
                                KanalYuzeyi.text = "Çok Pürüzlü";
                              }
                              else{
                                toplambasinckaybi_check = false;
                              }
                            });
                          },title: Text('Çok Pürüzlü'),
                        ),
                      ),
                    ],
                  )
                  ],
                ),
                SizedBox(
                  height: 17,
                ),

                TextFormField(
                  controller: Basinckaybi_controller,
                  enabled: basinckaybi_check,
                  showCursor: false,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.lightGreen,
                        )
                    ),
                    errorStyle: TextStyle(color: Colors.redAccent),
                    border: OutlineInputBorder(),
                    labelText: 'Basınç Kaybı: ',
                    suffixText: 'Pa/m',
                  ),
                  keyboardType: TextInputType.none,
                  maxLines: 1,
                  onSaved: (deger) {
                  },
                  onChanged: (deger){
                    setState(() {
                      Basinckaybi_controller.value.text;
                      if(Basinckaybi_controller.value.text != null && Kanalboyu_controller.value.text != null){
                        ToplambasincKaybi_Sonuc();
                        toplambasinckaybi_check = true;
                      }
                      else{
                        toplambasinckaybi_check = true;
                      }
                      if(PrizmatikkanalA_controller.value.text != null && PrizmatikkanalB_controller.value.text != null && Kanalboyu_controller.value.text != null){
                        KanalAlani_Sonuc();
                        kanalalani_check = true;
                        if(Kanalboyu_controller.value.text != null && Basinckaybi_controller.value.text != null){
                          ToplambasincKaybi_Sonuc();
                          toplambasinckaybi_check = true;
                        }
                        else{
                          toplambasinckaybi_check = false;
                        }
                      }
                      else{
                        kanalalani_check = false;
                      }
                    });
                  },
                ),

                SizedBox(
                  height: 17,
                ),

                TextFormField(
                  controller: Kanalboyu_controller,
                  decoration: InputDecoration(
                      errorStyle: TextStyle(color: Colors.redAccent),
                      border: OutlineInputBorder(),
                      labelText: 'Kanal Boyu',
                      suffixIcon: IconButton(
                        onPressed: Kanalboyu_controller.clear,
                        icon: Icon(Icons.clear_sharp),
                        color: Colors.red,
                      ),
                      suffixText: 'mt',
                      hintText: 'Kanal Boyunu Yazınız (mt)'
                  ),
                  keyboardType: TextInputType.number,
                  maxLines: 1,
                  onSaved: (deger) {
                    _IsEmpty = deger!;
                    setState(() {
                    });
                  },
                  onChanged: (deger){
                    setState(() {
                      if(PrizmatikkanalA_controller.value.text != null && PrizmatikkanalB_controller.value.text != null && Kanalboyu_controller.value.text != null){
                        KanalAlani_Sonuc();
                        kanalalani_check = true;
                        if(Kanalboyu_controller.value.text != null && Basinckaybi_controller.value.text != null){
                          ToplambasincKaybi_Sonuc();
                          toplambasinckaybi_check = true;
                        }
                        else{
                          toplambasinckaybi_check = false;
                        }
                      }
                      else{
                        kanalalani_check = false;
                      }
                      if(Kanalboyu_controller.value.text != null && Basinckaybi_controller.value.text != null){
                        ToplambasincKaybi_Sonuc();
                        toplambasinckaybi_check = true;
                      }
                      else{
                        toplambasinckaybi_check = false;
                      }
                    });
                  },

                  validator: (deger) {
                    if (deger!.isEmpty) {
                      return 'Bir Değer Girmediniz!';
                    } else {
                      return null;
                    }
                  },
                ),

                SizedBox(
                  height: 17,
                ),


                TextFormField(
                  controller: Kanalalani_controller,
                  enabled: kanalalani_check,
                  showCursor: false,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.lightGreen,
                        )
                    ),
                    errorStyle: TextStyle(color: Colors.redAccent),
                    border: OutlineInputBorder(),
                    labelText: 'Kanal Alanı: ',
                    suffixText: 'm2',
                  ),
                  keyboardType: TextInputType.none,
                  maxLines: 1,
                  onSaved: (deger) {
                    setState(() {
                    });
                  },
                  onChanged: (deger){
                    setState(() {
                      Kanalalani_controller.value.text;
                    });
                  },
                ),

                SizedBox(
                  height: 17,
                ),

                TextFormField(
                  controller: Toplambasinckaybi_controller,
                  enabled: toplambasinckaybi_check,
                  showCursor: false,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.lightGreen,
                        )
                    ),
                    errorStyle: TextStyle(color: Colors.redAccent),
                    border: OutlineInputBorder(),
                    labelText: 'Toplam Basınç Kaybı: ',
                    suffixText: 'Pa',
                  ),
                  keyboardType: TextInputType.none,
                  maxLines: 1,
                  onSaved: (deger) {
                    setState(() {
                    });
                  },
                  onChanged: (deger){
                    setState(() {
                      Toplambasinckaybi_controller.value.text;
                    });
                  },
                ),

                SizedBox(
                   height: 20,
                ),

                /// DİRSEK ALANI

                Text(
                  '- Dirsek Alanı -',
                  style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                ),

                SizedBox(
                  height: 6,
                ),

                Image.asset(
                  'assets/dirsekalani.jpg',
                  height: 120,
                  fit: BoxFit.contain,
                ),

                SizedBox(
                  height: 13,
                ),

                TextFormField(
                  controller: PrizmatikkanalA_controller,
                  enabled: false,
                  showCursor: false,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.lightGreen,
                        )
                    ),
                    errorStyle: TextStyle(color: Colors.redAccent),
                    border: OutlineInputBorder(),
                    labelText: 'A: ',
                    suffixText: 'mm',
                  ),
                  keyboardType: TextInputType.none,
                  maxLines: 1,
                  onSaved: (deger) {
                    setState(() {
                      if(Aci_controller.value != null && R1_controller.value != null){
                        DirsekAlani_Sonuc();
                        dirsekalani_check = true;
                      }
                      else{
                        dirsekalani_check = false;
                      }
                    });
                  },
                ),

                SizedBox(
                  height: 17,
                ),

                TextFormField(
                  controller: PrizmatikkanalB_controller,
                  enabled: false,
                  showCursor: false,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.lightGreen,
                        )
                    ),
                    errorStyle: TextStyle(color: Colors.redAccent),
                    border: OutlineInputBorder(),
                    labelText: 'B: ',
                    suffixText: 'mm',
                  ),
                  keyboardType: TextInputType.none,
                  maxLines: 1,
                  onSaved: (deger) {
                    setState(() {
                    });
                  },
                  onChanged: (deger){
                    setState(() {
                      if(Aci_controller.value != null && R1_controller.value != null){
                        DirsekAlani_Sonuc();
                        dirsekalani_check = true;
                      }
                      else{
                        dirsekalani_check = false;
                      }
                    });
                  },
                ),

                SizedBox(
                  height: 17,
                ),

                TextFormField(
                  controller: Aci_controller,
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.redAccent),
                    border: OutlineInputBorder(),
                    labelText: 'Açı',
                    suffixIcon: IconButton(
                      onPressed: Aci_controller.clear,
                      icon: Icon(Icons.clear_sharp),
                      color: Colors.red,
                    ),
                    suffixText: '°',
                    hintText: 'Açı Değerini Yazınız',
                  ),
                  keyboardType: TextInputType.number,
                  maxLines: 1,
                  onSaved: (deger) {
                    _IsEmpty = deger!;
                    setState(() {
                    });
                  },
                  onChanged: (deger){
                    setState(() {
                      if(Aci_controller.value != null && R1_controller.value != null){
                        DirsekAlani_Sonuc();
                        dirsekalani_check = true;
                      }
                      else{
                        dirsekalani_check = false;
                      }
                    });
                  },

                  validator: (deger) {
                    if (deger!.isEmpty) {
                      return 'Bir Değer Girmediniz!';
                    } else {
                      return null;
                    }
                  },
                ),

                SizedBox(
                  height: 17,
                ),

                TextFormField(
                  controller: R1_controller,
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.redAccent),
                    border: OutlineInputBorder(),
                    labelText: 'R1',
                    suffixIcon: IconButton(
                      onPressed: R1_controller.clear,
                      icon: Icon(Icons.clear_sharp),
                      color: Colors.red,
                    ),
                    suffixText: 'mm',
                    hintText: 'R1 Değerini Yazınız (mm)',
                  ),
                  keyboardType: TextInputType.number,
                  maxLines: 1,
                  onSaved: (deger) {
                    _IsEmpty = deger!;
                    setState(() {
                    });
                  },
                  onChanged: (deger){
                    setState(() {
                      if(Aci_controller.value != null && R1_controller.value != null){
                        DirsekAlani_Sonuc();
                        dirsekalani_check = true;
                      }
                      else{
                        dirsekalani_check = false;
                      }
                    });
                  },

                  validator: (deger) {
                    if (deger!.isEmpty) {
                      return 'Bir Değer Girmediniz!';
                    } else {
                      return null;
                    }
                  },
                ),

                SizedBox(
                  height: 17,
                ),

                TextFormField(
                  controller: DirsekAlani_controller,
                  enabled: dirsekalani_check,
                  showCursor: false,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.lightGreen,
                        )
                    ),
                    errorStyle: TextStyle(color: Colors.redAccent),
                    border: OutlineInputBorder(),
                    labelText: 'Dirsek Alanı: ',
                    suffixText: 'm2',
                  ),
                  keyboardType: TextInputType.none,
                  maxLines: 1,
                  onSaved: (deger) {
                    setState(() {
                      DirsekAlani_controller.value.text;
                    });
                  },
                ),

                SizedBox(
                  height: 17,
                ),

              ],
            ),
              ),
             ),
            ),
          ),
        ),
      ),
    );
  }
}


@override
void dispose() {
  Havadebisi_controller.dispose();
  Kanalcapi_controller.dispose();
  Havahizi_controller.dispose();
  PrizmatikkanalA_controller.dispose();
  PrizmatikkanalB_controller.dispose();
  Basinckaybi_controller.dispose();
  Kanalboyu_controller.dispose();
  Kanalalani_controller.dispose();
  Toplambasinckaybi_controller.dispose();
  Aci_controller.dispose();
  R1_controller.dispose();
  DirsekAlani_controller.dispose();
}


Future<void> excelExportHavaKanali(BuildContext context) async {
  var excel = Excel.createExcel();

  // --- EXCEL SAYFA AYARLARI ---
  Sheet sheetObject = excel['Hava Kanalı Hesabı'];
  excel.delete('Sheet1'); // Varsayılan boş sayfayı sil

  // Stil Tanımları
  CellStyle headerStyle = CellStyle(
    fontFamily: getFontFamily(FontFamily.Calibri),
    bold: true,
  );

  // --- BAŞLIKLAR (Hava Kanalı İçin Özel) ---
  List<String> basliklar = [
    "Hava Debisi (m3/h)",
    "Hava Hızı (m/s)",
    "Kanal Çapı (mm)",
    "Kanal A (mm)",
    "Kanal B (mm)",
    "Birim Basınç Kaybı (Pa/m)",
    "Kanal Boyu (m)",
    "Kanal Alanı (m2)",
    "Top. Basınç Kaybı (Pa)",
    "Dirsek Açısı",
    "Dirsek R1 (mm)",
    "Dirsek Alanı (m2)"
  ];

  // Başlıkları Yazdır
  for (int i = 0; i < basliklar.length; i++) {
    var cell = sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0));
    cell.value = TextCellValue(basliklar[i]);
    cell.cellStyle = headerStyle;
  }

  // --- VERİLERİ TOPLA ---
  // Controller'lardan verileri alıyoruz
  List<String> veriler = [
    Havadebisi_controller.text,
    Havahizi_controller.text,
    Kanalcapi_controller.text,
    PrizmatikkanalA_controller.text,
    PrizmatikkanalB_controller.text,
    Basinckaybi_controller.text,
    Kanalboyu_controller.text,
    Kanalalani_controller.text,
    Toplambasinckaybi_controller.text,
    Aci_controller.text,
    R1_controller.text,
    DirsekAlani_controller.text
  ];

  // Verileri Yazdır
  for (int i = 0; i < veriler.length; i++) {
    // Boş veri varsa "-" koyalım
    String veri = veriler[i].isEmpty ? "-" : veriler[i];
    sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 1)).value = TextCellValue(veri);
  }
  // -------------------------------------------------------

  // Dosya İsmi
  String fileName = "Hava_Kanali_Hesap_${DateTime.now().millisecondsSinceEpoch}.xlsx";

  // --- KRİTİK DÜZELTME ---
  // excel.save() yerine excel.encode() kullanıyoruz.
  // Bu sayede Web'de otomatik (çift) indirmeyi engelliyoruz.
  var fileBytes = excel.encode();

  if (fileBytes != null) {

    // --- WEB İÇİN ÖZEL KOD ---
    if (kIsWeb) {
      final blob = html.Blob([fileBytes], 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
      final url = html.Url.createObjectUrlFromBlob(blob);

      final anchor = html.AnchorElement(href: url)
        ..setAttribute("download", fileName) // İsmi buradan alır
        ..click();

      html.Url.revokeObjectUrl(url);
      return;
    }
    // -------------------------

    // --- MOBİL (ANDROID / IOS) ---
    if (Platform.isAndroid) {
      try {
        Directory directory = Directory('/storage/emulated/0/Download');
        if (!await directory.exists()) {
          directory = (await getExternalStorageDirectory())!;
        }

        final path = "${directory.path}/$fileName";

        File(path)
          ..createSync(recursive: true)
          ..writeAsBytesSync(fileBytes);

        // Banner Gösterimi
        if (context.mounted) {
          ScaffoldMessenger.of(context).showMaterialBanner(
            MaterialBanner(
              content: Text("Excel dosyası 'İndirilenler' klasörüne kaydedildi.", style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.green,
              actions: <Widget>[
                TextButton(
                  child: Text('KAPAT', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  onPressed: () {
                    ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                  },
                ),
              ],
            ),
          );
          Future.delayed(Duration(seconds: 5), () {
            if (context.mounted) {
              ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
            }
          });
        }
        await _shareFile(fileBytes, fileName);

      } catch (e) {
        await _shareFile(fileBytes, fileName);
      }
    } else {
      // iOS
      await _shareFile(fileBytes, fileName);
    }
  }
}

// Yardımcı Paylaşım Fonksiyonu (Dosyada zaten varsa tekrar eklemeyin)
Future<void> _shareFile(List<int> bytes, String fileName) async {
  final directory = await getTemporaryDirectory();
  final path = "${directory.path}/$fileName";
  File(path)
    ..createSync(recursive: true)
    ..writeAsBytesSync(bytes);
  await Share.shareXFiles([XFile(path)], text: 'Hava Kanalı Hesaplama Sonuçları');
}

//Hesaplamalar
double Kanalcapi_Sonuc(){
  double a =  ( double.parse(Havadebisi_controller.value.text) / (double.parse(Havahizi_controller.value.text) * 3600 * 3.14));
  double b = pow(a, (0.5)).toDouble();
  double sonuc = 1000 * 2 * b;
  sonuc = sonuc.round().toDouble();
  Kanalcapi_controller.text = sonuc.toString();
  return double.parse(Kanalcapi_controller.value.text);
}

double KanalcapiArttir(){
  double sonuc = double.parse(Kanalcapi_controller.value.text) + 5;
  sonuc = sonuc.round().toDouble();
  Kanalcapi_controller.text = sonuc.toString();
  return double.parse(Kanalcapi_controller.value.text);
}

double KanalcapiAzalt(){
  double sonuc =  double.parse(Kanalcapi_controller.value.text) - 5;
  sonuc = sonuc.round().toDouble();
  Kanalcapi_controller.text = sonuc.toString();
  return double.parse(Kanalcapi_controller.value.text);
}

double Havahizi_Sonuc(){
  double M4 = double.parse(Kanalcapi_controller.value.text) / 1000;
  num _pow = pow(M4, 2);
  double M3 = _pow.toDouble();
  double M5 = (22/28) * M3;
  double sonuc = double.parse(Havadebisi_controller.value.text) / (M5 * 3600);
  Havahizi_controller.text = sonuc.toStringAsFixed(2);
  return double.parse(Havahizi_controller.value.text);
}

double PrizmatikkanalB_Sonuc(){
  double M4 = double.parse(Kanalcapi_controller.value.text) / 1000;
  num _pow = pow(M4, 2);
  double M3 = _pow.toDouble();
  double M5 = (22/28) * M3;
  double sonuc = M5 * 1000000 / double.parse(PrizmatikkanalA_controller.value.text);
  sonuc = sonuc.roundToDouble();
  PrizmatikkanalB_controller.text = sonuc.toString();
  return double.parse(PrizmatikkanalB_controller.value.text);
}

double Basinckaybi_Sonuc(){
  double P4 = double.parse(Havadebisi_controller.value.text) / 3600;
  double M4 = double.parse(Kanalcapi_controller.value.text) / 1000;
  num _pow = pow(P4, 2) / pow(M4, 5);
  double sonuc = 0.81 * 1.204 * double.parse(sec) * _pow.toDouble();
  Basinckaybi_controller.text = sonuc.toStringAsFixed(2);
  return double.parse(Basinckaybi_controller.value.text);
}

double KanalAlani_Sonuc(){
  double sonuc = (double.parse(PrizmatikkanalA_controller.value.text) + double.parse(PrizmatikkanalB_controller.value.text)) * 2 * 0.001 * double.parse(Kanalboyu_controller.value.text);
  Kanalalani_controller.text = sonuc.toStringAsFixed(1);
  return double.parse(Kanalalani_controller.value.text);
}

double ToplambasincKaybi_Sonuc(){
  double sonuc =double.parse(Kanalboyu_controller.value.text) * double.parse(Basinckaybi_controller.value.text);
  Toplambasinckaybi_controller.text = sonuc.toStringAsFixed(2);
  return double.parse(Toplambasinckaybi_controller.value.text);
}

double DirsekAlani_Sonuc(){
  double sonuc = (double.parse(PrizmatikkanalA_controller.value.text) / 2 + double.parse(R1_controller.value.text)) * double.parse(Aci_controller.value.text) * (double.parse(PrizmatikkanalA_controller.value.text) + double.parse(PrizmatikkanalB_controller.value.text)) * 0.00000003488 * 1.1;
  DirsekAlani_controller.text = sonuc.toStringAsFixed(2);
  return double.parse(DirsekAlani_controller.value.text);
}
