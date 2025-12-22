import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Webview_item extends StatefulWidget {
  @override
  State<Webview_item> createState() => _Webview_item();
}

class _Webview_item extends State<Webview_item> {
  bool isLoading = true;
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted) // JS'yi açar (butonlar vb. için temel)
      ..setBackgroundColor(const Color(0x00000000)) // Yüklenirken arka planı şeffaf yapar
      ..enableZoom(true) // Pinch-to-zoom (yakınlaştırma) özelliğini aktif eder
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              isLoading = false;
            });
          },
          // Sayfa içinde bir hata olursa konsola yazdırır, sorunu anlamayı kolaylaştırır.
          onWebResourceError: (WebResourceError error) {
            debugPrint('Web sayfası hatası: ${error.description}');
          },
        ),
      )
      ..loadRequest(Uri.parse('https://akrokol.itcmuhendislik.com/')); // URL'yi yükle
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // WebViewWidget, controller tarafından yönetilir
        WebViewWidget(controller: _controller),

        // Sayfa yüklenirken gösterilecek loading animasyonu
        if (isLoading)
          const Center(
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }
}
