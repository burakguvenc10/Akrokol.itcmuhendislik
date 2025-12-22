import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget {
  final Function(int)? onLinkTap;
  const Footer({Key? key, this.onLinkTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    bool isMobile = width < 800;

    return Container(
      width: double.infinity,
      color: Colors.grey[900],
      // Dikey padding'i 15'ten 8'e düşürdük (Çok daha ince olacak)
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Sadece içeriği kadar yer kapla
        children: [
          // ÜST KISIM
          isMobile
              ? Column(
            mainAxisSize: MainAxisSize.min,
            children: _buildFooterContents(context, isMobile),
          )
              : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildFooterContents(context, isMobile)[0],
              const SizedBox(width: 40),
              _buildFooterContents(context, isMobile)[1],
              const SizedBox(width: 40),
              _buildFooterContents(context, isMobile)[2],
            ],
          ),

          // Çizgi üzerindeki boşluğu 8'den 4'e, Divider'ı 10'dan 5'e çektik
          const SizedBox(height: 4),
          const Divider(color: Colors.white24, height: 5),

          // ALT KISIM (Copyright ve Sosyal Medya)
          // Mobilde yan yana getirerek yer kazandık
          isMobile
              ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "© ${DateTime.now().year} Akrokol",
                style: const TextStyle(color: Colors.white54, fontSize: 10),
              ),
              Row(
                children: [
                  _socialIcon(FontAwesomeIcons.facebook, "https://facebook.com"),
                  const SizedBox(width: 8),
                  _socialIcon(FontAwesomeIcons.instagram, "https://instagram.com"),
                  const SizedBox(width: 8),
                  _socialIcon(FontAwesomeIcons.linkedin, "https://linkedin.com"),
                ],
              )
            ],
          )
              : Column(
            children: [
              Text(
                "© ${DateTime.now().year} Akrokol - ITC Mühendislik",
                style: const TextStyle(color: Colors.white54, fontSize: 11),
              ),
              const SizedBox(height: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _socialIcon(FontAwesomeIcons.facebook, "https://facebook.com"),
                  const SizedBox(width: 15),
                  _socialIcon(FontAwesomeIcons.instagram, "https://instagram.com"),
                  const SizedBox(width: 15),
                  _socialIcon(FontAwesomeIcons.linkedin, "https://linkedin.com"),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _buildFooterContents(BuildContext context, bool isMobile) {
    return [
      // 1. SÜTUN: ŞİRKET BİLGİSİ
      SizedBox(
        width: isMobile ? double.infinity : 200,
        child: Column(
          crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: [
            const Text(
              "AKROKOL",
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            ),
            if (!isMobile) // Mobilde alt başlığı gizleyerek yer kazanalım
              const Text(
                "Mühendislik Çözümleri",
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
          ],
        ),
      ),

      // Mobilde dikey boşlukları 15'ten 5'e indirdik
      if (isMobile) const SizedBox(height: 5),

      // 2. SÜTUN: İLETİŞİM
      Column(
        crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          if (!isMobile) _footerHeader("İLETİŞİM"),
          _contactItem(Icons.phone, "0 212 671 70 97", "tel:+902126717097", isMobile),
          _contactItem(Icons.email, "itc@itcmuhendislik.com", "mailto:itc@itcmuhendislik.com", isMobile),
        ],
      ),

      if (isMobile) const SizedBox(height: 5),

      // 3. SÜTUN: HIZLI LİNKLER
      Column(
        crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          if (!isMobile) _footerHeader("HIZLI LİNKLER"),
          // Mobilde linkleri yan yana dizerek yer kazanabiliriz
          isMobile
              ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _linkItem("Anasayfa", context, 0),
              const SizedBox(width: 15),
              _linkItem("Fan Motoru", context, 1),
              const SizedBox(width: 15),
              _linkItem("Bilgi", context, 2),
            ],
          )
              : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _linkItem("Anasayfa", context, 0),
              _linkItem("Fan Motoru", context, 1),
              _linkItem("Bilgi", context, 2),
            ],
          ),
        ],
      ),
    ];
  }

  Widget _footerHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        title,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
      ),
    );
  }

  Widget _contactItem(IconData icon, String text, String url, bool isMobile) {
    return InkWell(
      onTap: () async {
        final Uri uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) await launchUrl(uri);
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 2),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.redAccent, size: 12),
            const SizedBox(width: 5),
            Text(text, style: const TextStyle(color: Colors.white70, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _linkItem(String title, BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: InkWell(
        onTap: () {
          if (onLinkTap != null) {
            onLinkTap!(index);
            Scrollable.ensureVisible(context, alignment: 0.0);
          }
        },
        child: Text(
          title,
          style: const TextStyle(color: Colors.white70, fontSize: 12, decoration: TextDecoration.underline),
        ),
      ),
    );
  }

  Widget _socialIcon(IconData icon, String url) {
    return IconButton(
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      icon: FaIcon(icon, color: Colors.white54, size: 14),
      onPressed: () async {
        final Uri uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) await launchUrl(uri, mode: LaunchMode.externalApplication);
      },
    );
  }
}
