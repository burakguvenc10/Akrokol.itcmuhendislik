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
      // WEB'de (20), MOBİL'de (8) dikey padding
      padding: EdgeInsets.symmetric(vertical: isMobile ? 8 : 20, horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
              const SizedBox(width: 60),
              _buildFooterContents(context, isMobile)[1],
              const SizedBox(width: 60),
              _buildFooterContents(context, isMobile)[2],
            ],
          ),

          // Çizgi ve boşluk ayarı
          SizedBox(height: isMobile ? 4 : 15),
          const Divider(color: Colors.white24, height: 1),
          SizedBox(height: isMobile ? 4 : 10),

          // ALT KISIM (Copyright ve Sosyal Medya)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "© ${DateTime.now().year} Akrokol",
                style: TextStyle(color: Colors.white54, fontSize: isMobile ? 10 : 12),
              ),
              Row(
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
        width: isMobile ? double.infinity : 250,
        child: Column(
          crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: [
            Text(
              "AKROKOL",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: isMobile ? 16 : 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2),
            ),
            if (!isMobile) ...[
              const SizedBox(height: 8),
              const Text(
                "Endüstriyel havalandırma ve mühendislik çözümleri.",
                style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.4),
              ),
            ]
          ],
        ),
      ),

      if (isMobile) const SizedBox(height: 6),

      // 2. SÜTUN: İLETİŞİM
      Column(
        crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          if (!isMobile) ...[
            const Text("İLETİŞİM", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 10),
          ],
          _contactItem(Icons.phone, "0 212 671 70 97", "tel:+902126717097", isMobile),
          _contactItem(Icons.email, "itc@itcmuhendislik.com", "mailto:itc@itcmuhendislik.com", isMobile),
        ],
      ),

      if (isMobile) const SizedBox(height: 6),

      // 3. SÜTUN: HIZLI LİNKLER
      Column(
        crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          if (!isMobile) ...[
            const Text("HIZLI LİNKLER", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 10),
          ],
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              _linkItem("Anasayfa", context, 0, isMobile),
              const SizedBox(width: 15),
              _linkItem("Fan Motoru", context, 1, isMobile),
              const SizedBox(width: 15),
              _linkItem("Bilgi", context, 2, isMobile),
            ],
          )
        ],
      ),
    ];
  }

  Widget _contactItem(IconData icon, String text, String url, bool isMobile) {
    return InkWell(
      onTap: () async {
        final Uri uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) await launchUrl(uri);
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: isMobile ? 2 : 6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.redAccent, size: isMobile ? 12 : 16),
            const SizedBox(width: 8),
            Text(text, style: TextStyle(color: Colors.white70, fontSize: isMobile ? 11 : 13)),
          ],
        ),
      ),
    );
  }

  Widget _linkItem(String title, BuildContext context, int index, bool isMobile) {
    return InkWell(
      onTap: () {
        if (onLinkTap != null) {
          onLinkTap!(index);
          Scrollable.ensureVisible(context, alignment: 0.0);
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: isMobile ? 2 : 4),
        child: Text(
          title,
          style: TextStyle(
              color: Colors.white70,
              fontSize: isMobile ? 11 : 13,
              decoration: TextDecoration.underline
          ),
        ),
      ),
    );
  }

  Widget _socialIcon(IconData icon, String url) {
    return IconButton(
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      icon: FaIcon(icon, color: Colors.white54, size: 16),
      onPressed: () async {
        final Uri uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) await launchUrl(uri, mode: LaunchMode.externalApplication);
      },
    );
  }
}
