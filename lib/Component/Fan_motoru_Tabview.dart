import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:io'; // Dosya işlemleri için
import 'package:excel/excel.dart'; // Excel oluşturmak için
import 'package:path_provider/path_provider.dart'; // Telefon hafızasına erişim için
import 'package:share_plus/share_plus.dart'; // Dosyayı paylaşmak/kaydetmek için
import 'package:universal_html/html.dart' as html; // Web indirme işlemleri için
import 'package:flutter/foundation.dart' show kIsWeb; // Web kontrolü için


//--CONTROLLER TANIMLARI --
final Havadebisi_controller = TextEditingController();
final Toplambasinckaybi_controller = TextEditingController();
final Motorverimi_controller = TextEditingController();
final Fanverimi_controller = TextEditingController();
final Motorgucu_controller = TextEditingController();

bool motorgucu_check = false;


class Fan_motoru_Tabview extends StatefulWidget {
  @override
  Fan_motoru createState() => Fan_motoru();
}

class Fan_motoru extends State<Fan_motoru_Tabview> {

  final _formKeyMotor = GlobalKey<FormState>();

  void tumAlanlariTemizle() {
    setState(() {
      // Controller'ları sıfırla
      Havadebisi_controller.text = "";
      Toplambasinckaybi_controller.text = "";
      Motorverimi_controller.text = "";
      Fanverimi_controller.text = "";
      Motorgucu_controller.text = "";
    });

    // Kullanıcıya bilgi ver
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Tüm alanlar temizlendi."),
          duration: Duration(seconds: 1),
          backgroundColor: Colors.orangeAccent,
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      /// FAN MOTORU TAB_ITEM
      child: SingleChildScrollView(
          child: Center( // 1. Ortalamak için Center ekleyin
            child: Container( // 2. Genişliği sınırlamak için SizedBox ekleyin
              // Web ise maksimum 600px genişlik olsun, değilse (mobil) tam ekran
              width: kIsWeb ? 800 : double.infinity,
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
                    key: _formKeyMotor,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children:[
                        Text(
                          'FAN MOTORU HESABI',
                          style: TextStyle(fontSize: 14,
                            fontWeight: FontWeight.w300, // Daha ince ve zarif
                            color: Colors.grey[800],
                            letterSpacing: 2, // Çok geniş harf aralığı
                            fontStyle: FontStyle.italic,
                          ),
                        ),

                        Container(
                          alignment: Alignment.centerRight,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end, // Sağa yasla
                                children: [
                                  Column(
                                    children: [
                                      IconButton(
                                        iconSize: 32,
                                        icon: FaIcon(FontAwesomeIcons.solidFileExcel, color: Colors.green),
                                        onPressed: () {
                                          if (Havadebisi_controller.text.isEmpty || Motorgucu_controller.text.isEmpty) {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(content: Text("Lütfen Hesaplama Yapınız"))
                                            );
                                          } else {
                                            excelExport(context); // Excel fonksiyonunu çağır
                                          }},
                                      ),
                                      Text("Paylaş ve İndir", style: TextStyle(fontSize: 8, color: Colors.black26), textAlign: TextAlign.center,),
                                    ],
                                  ),
                                  SizedBox(width: 1), // İki buton arası boşluk
                                  Column(
                                    children: [
                                      IconButton(
                                        iconSize: 32,
                                        icon: FaIcon(FontAwesomeIcons.trashCan, color: Colors.red),
                                        onPressed: () {
                                          tumAlanlariTemizle(); // Fonksiyonu çağır
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
                        Text(
                          '- Motor Gücü -',style: TextStyle(fontSize: 12,color: Colors.grey[500]),
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
                              hintText: 'Hava Debisini Yazınız (m3/h)'
                          ),
                          keyboardType: TextInputType.number,
                          maxLines: 1,
                          onSaved: (deger) {
                            setState(() {
                            });},
                          onChanged: (deger){
                            setState(() {
                              if(Havadebisi_controller.value.text != null && Toplambasinckaybi_controller.value.text != null && Fanverimi_controller.value.text != null){
                                MotorGucu_Sonuc();
                                motorgucu_check = true;
                              }
                              else{
                                motorgucu_check = false;
                              }
                            });},
                          validator: (deger) {
                            if(deger!.isEmpty){
                              return 'Bir Değer Girmediniz!';
                            }else{
                              return null;
                            }},
                        ),
                        SizedBox(
                          height: 17,
                        ),
                        TextFormField(
                          controller: Toplambasinckaybi_controller,
                          decoration: InputDecoration(
                              errorStyle: TextStyle(color: Colors.redAccent),
                              border: OutlineInputBorder(),
                              labelText: 'Toplam Basınç Kaybı',
                              suffixIcon: IconButton(
                                onPressed: Toplambasinckaybi_controller.clear,
                                icon: Icon(Icons.clear_sharp),
                                color: Colors.red,
                              ),
                              suffixText: 'Pa',
                              hintText: 'Toplam Basınç Kaybını Yazınız (Pa)'
                          ),
                          keyboardType: TextInputType.number,
                          maxLines: 1,
                          onSaved: (deger) {
                            setState(() {
                            });},
                          onChanged: (deger){
                            setState(() {
                              if(Havadebisi_controller.value.text != null && Toplambasinckaybi_controller.value.text != null && Fanverimi_controller.value.text != null){
                                MotorGucu_Sonuc();
                                motorgucu_check = true;
                              }
                              else{
                                motorgucu_check = false;
                              }
                            });},
                          validator: (deger) {
                            if(deger!.isEmpty){
                              return 'Bir Değer Girmediniz!';
                            }else{
                              return null;
                            }},
                        ),
                        SizedBox(
                          height: 17,
                        ),
                        TextFormField(
                          controller: Motorverimi_controller,
                          decoration: InputDecoration(
                              errorStyle: TextStyle(color: Colors.redAccent),
                              border: OutlineInputBorder(),
                              labelText: 'Motor Verimi',
                              suffixIcon: IconButton(
                                onPressed: Motorverimi_controller.clear,
                                icon: Icon(Icons.clear_sharp),
                                color: Colors.red,
                              ),
                              suffixText: '%',
                              hintText: 'Motor Verimini Yazınız (%)'
                          ),
                          keyboardType: TextInputType.number,
                          maxLines: 1,
                          onSaved: (deger) {
                            //_IsEmpty = deger!;
                            setState(() {
                            });},
                          onChanged: (deger){
                            setState(() {
                              if(Havadebisi_controller.value.text != null && Toplambasinckaybi_controller.value.text != null && Fanverimi_controller.value.text != null){
                                MotorGucu_Sonuc();
                                motorgucu_check = true;
                              }
                              else{
                                motorgucu_check = false;
                              }
                            });},
                          validator: (deger) {
                            if(deger!.isEmpty){
                              return 'Bir Değer Girmediniz!';
                            }else{
                              return null;
                            }},
                        ),
                        SizedBox(
                          height: 17,
                        ),
                        TextFormField(
                          controller: Fanverimi_controller,
                          decoration: InputDecoration(
                              errorStyle: TextStyle(color: Colors.redAccent),
                              border: OutlineInputBorder(),
                              labelText: 'Fan Verimi',
                              suffixIcon: IconButton(
                                onPressed: Fanverimi_controller.clear,
                                icon: Icon(Icons.clear_sharp),
                                color: Colors.red,
                              ),
                              suffixText: '%',
                              hintText: 'Fan Verimini Yazınız (%)'
                          ),
                          keyboardType: TextInputType.number,
                          maxLines: 1,
                          onSaved: (deger) {
                            //_IsEmpty = deger!;
                            setState(() {
                            });},
                          onChanged: (deger){
                            setState(() {
                              if(Havadebisi_controller.value.text != null && Toplambasinckaybi_controller.value.text != null && Fanverimi_controller.value.text != null){
                                MotorGucu_Sonuc();
                                motorgucu_check = true;
                              }
                              else{
                                motorgucu_check = false;
                              }
                            });},
                          validator: (deger) {
                            if(deger!.isEmpty){
                              return 'Bir Değer Girmediniz!';
                            }else{
                              return null;
                            }},
                        ),
                        SizedBox(
                          height: 17,
                        ),
                        TextFormField(
                          controller: Motorgucu_controller,
                          enabled: motorgucu_check,
                          showCursor: false,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.lightGreen,
                                )
                            ),
                            errorStyle: TextStyle(color: Colors.redAccent),
                            border: OutlineInputBorder(),
                            labelText: 'Motor Gücü ',
                            suffixText: 'Kw',
                          ),
                          keyboardType: TextInputType.none,
                          maxLines: 1,
                          onSaved: (deger) {
                            setState(() {
                            });},
                          onChanged: (deger){
                            setState((){
                              Motorgucu_controller.value.text;
                            });},
                        ),
                        SizedBox(
                          height: 13,
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

Future<void> excelExport(BuildContext context) async {
  var excel = Excel.createExcel();

  // Sayfa Ayarları
  Sheet sheetObject = excel['Motor Gücü Hesabı'];
  excel.delete('Sheet1');

  // Stil Tanımları
  CellStyle headerStyle = CellStyle(
    fontFamily: getFontFamily(FontFamily.Calibri),
    bold: true,
  );

  // Başlıkları Ekle
  sheetObject.cell(CellIndex.indexByString("A1"))
    ..value = TextCellValue("Hava Debisi (m3/h)")
    ..cellStyle = headerStyle;

  sheetObject.cell(CellIndex.indexByString("B1"))
    ..value = TextCellValue("Toplam Basınç Kaybı (Pa)")
    ..cellStyle = headerStyle;

  sheetObject.cell(CellIndex.indexByString("C1"))
    ..value = TextCellValue("Motor Verimi (%)")
    ..cellStyle = headerStyle;

  sheetObject.cell(CellIndex.indexByString("D1"))
    ..value = TextCellValue("Fan Verimi (%)")
    ..cellStyle = headerStyle;

  sheetObject.cell(CellIndex.indexByString("E1"))
    ..value = TextCellValue("Hesaplanan Motor Gücü (Kw)")
    ..cellStyle = headerStyle;

  // Verileri Ekle
  sheetObject.cell(CellIndex.indexByString("A2")).value = TextCellValue(Havadebisi_controller.text);
  sheetObject.cell(CellIndex.indexByString("B2")).value = TextCellValue(Toplambasinckaybi_controller.text);
  sheetObject.cell(CellIndex.indexByString("C2")).value = TextCellValue(Motorverimi_controller.text);
  sheetObject.cell(CellIndex.indexByString("D2")).value = TextCellValue(Fanverimi_controller.text);
  sheetObject.cell(CellIndex.indexByString("E2")).value = TextCellValue(Motorgucu_controller.text);

  // Dosya ismini benzersiz yapalım
  String fileName = "Fan_Motoru_${DateTime.now().millisecondsSinceEpoch}.xlsx";

  // --- DÜZELTME BURADA YAPILDI ---
  // excel.save() Web'de otomatik indirme tetikler.
  // excel.encode() ise sadece veriyi oluşturur, indirmeyi bizim kontrolümüze bırakır.
  var fileBytes = excel.encode();

  if (fileBytes != null) {

    // --- WEB İÇİN ÖZEL KOD BLOĞU ---
    if (kIsWeb) {
      final blob = html.Blob([fileBytes], 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: url)
        ..setAttribute("download", fileName)
        ..click();
      html.Url.revokeObjectUrl(url);
      return;
    }
    // -------------------------------

    if (Platform.isAndroid) {
      // --- ANDROID İÇİN İNDİRİLENLER KLASÖRÜNE KAYIT ---
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
              content: Text(
                "Excel dosyası 'İndirilenler' klasörüne kaydedildi.",
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.green,
              actions: <Widget>[
                TextButton(
                  child: Text(
                    'KAPAT',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
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

// Kod tekrarını önlemek için yardımcı fonksiyon
Future<void> _shareFile(List<int> bytes, String fileName) async {
  final directory = await getTemporaryDirectory();
  final path = "${directory.path}/$fileName";
  File(path)
    ..createSync(recursive: true)
    ..writeAsBytesSync(bytes);

  // Paylaşım ekranını aç
  await Share.shareXFiles([XFile(path)], text: 'Fan Motoru Hesaplama Sonuçları');
}

double MotorGucu_Sonuc(){
  double sonuc = 0.002725 * double.parse(Havadebisi_controller.value.text) * double.parse(Toplambasinckaybi_controller.value.text) / ( double.parse(Motorverimi_controller.value.text) * double.parse(Fanverimi_controller.value.text) );
  sonuc = sonuc.round().toDouble();
  Motorgucu_controller.text = sonuc.toString();
  return double.parse(Motorgucu_controller.value.text);
}