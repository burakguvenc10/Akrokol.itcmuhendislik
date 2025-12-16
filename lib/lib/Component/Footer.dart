import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Ekran genişliğine göre düzeni ayarla (Responsive)
    bool isMobile = MediaQuery.of(context).size.width < 800;

    return Container(
      color: Colors.grey[900], // Koyu arka plan (Web standardı)
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
      child: Column(
        children: [
          // ÜST KISIM (Bilgiler)
          isMobile
              ? Column(
            children: _buildFooterContents(context),
          )
              : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _buildFooterContents(context),
          ),

          const Divider(color: Colors.white24, height: 40),

          // ALT KISIM (Copyright ve Sosyal Medya)
          Column(
            children: [
              Text(
                "© ${DateTime.now().year} Akrokol - ITC Mühendislik. Tüm Hakları Saklıdır.",
                style: const TextStyle(color: Colors.white54, fontSize: 12),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Sosyal Medya Linklerini buraya ekleyebilirsiniz
                  _socialIcon(FontAwesomeIcons.facebook, "https://www.facebook.com"),
                  const SizedBox(width: 15),
                  _socialIcon(FontAwesomeIcons.instagram, "https://www.instagram.com"),
                  const SizedBox(width: 15),
                  _socialIcon(FontAwesomeIcons.linkedin, "https://www.linkedin.com"),
                  const SizedBox(width: 15),
                  _socialIcon(FontAwesomeIcons.twitter, "https://twitter.com"),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  // Footer İçeriği (Sütunlar)
  List<Widget> _buildFooterContents(BuildContext context) {
    return [
      // 1. SÜTUN: Şirket Bilgisi
      SizedBox(
        width: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Logonuz varsa burayı açın:
            // Image.asset('assets/Logo.png', height: 40, color: Colors.white),
            const Text(
              "AKROKOL",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5),
            ),
            const SizedBox(height: 15),
            const Text(
              "Toz, Duman ve Buhar için profesyonel mühendislik çözümleri sunuyoruz.",
              style: TextStyle(color: Colors.white70, fontSize: 14, height: 1.5),
            ),
          ],
        ),
      ),

      const SizedBox(height: 30), // Mobilde boşluk bırakır

      // 2. SÜTUN: İletişim (Linkli)
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "İLETİŞİM",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          // Harita Linki (Google Maps)
          _contactItem(
              Icons.location_on,
              "Esenyurt, İstanbul, Türkiye",
              "https://www.google.com/maps/search/?api=1&query=İkitelli+OSB+İstanbul"
          ),
          // Telefon Arama Linki (tel:)
          _contactItem(
              Icons.phone,
              "0 212 671 70 97",
              "tel:+902126717097"
          ),
          // Mail Atma Linki (mailto:)
          _contactItem(
              Icons.email,
              "itc@itcmuhendislik.com",
              "mailto:itc@itcmuhendislik.com"
          ),
        ],
      ),

      const SizedBox(height: 30),

      // 3. SÜTUN: Hızlı Linkler
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "HIZLI LİNKLER",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          _linkItem("Hava Kanalı"),
          _linkItem("Fan Motoru"),
          _linkItem("Bilgi"),
        ],
      ),
    ];
  }

  // Yardımcı Widget: İletişim Satırı (Tıklanabilir)
  Widget _contactItem(IconData icon, String text, String url) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: () async {
          final Uri uri = Uri.parse(url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri);
          } else {
            debugPrint("Link açılamadı: $url");
          }
        },
        child: Row(
          children: [
            Icon(icon, color: Colors.redAccent, size: 18),
            const SizedBox(width: 10),
            Text(
              text,
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  // Yardımcı Widget: Link Satırı
  Widget _linkItem(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () {
          // Sayfa içi yönlendirme yapılabilir (Navigator vs.)
          // Örneğin:
          // Navigator.pushNamed(context, '/ilgiliSayfa');
        },
        child: Text(
          title,
          style: const TextStyle(color: Colors.white70, fontSize: 14),
        ),
      ),
    );
  }

  // Yardımcı Widget: Sosyal Medya İkonu (Linkli)
  Widget _socialIcon(IconData icon, String url) {
    return IconButton(
      icon: FaIcon(icon, color: Colors.white60, size: 20),
      onPressed: () async {
        final Uri uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      },
    );
  }
}
