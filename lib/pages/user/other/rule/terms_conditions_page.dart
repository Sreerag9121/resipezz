import 'package:flutter/material.dart';
import 'package:recipizz/utils/app_theme.dart';
import 'package:webview_flutter/webview_flutter.dart';


class TermsCondition extends StatefulWidget {
  const TermsCondition({super.key});

  @override
  TermsConditionState createState() => TermsConditionState();
}


class TermsConditionState extends State<TermsCondition> {
  late WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(AppTheme.colors.appWhiteColor)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
           const CircularProgressIndicator();
          },
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {
            setState(() {
              _isLoading = false; 
            });
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(
          'https://www.freeprivacypolicy.com/live/0e2025c4-08c0-442b-857d-15ded7e182de'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:AppTheme.colors.shadecolor,
        foregroundColor: AppTheme.colors.appWhiteColor,
        centerTitle: true,
        title: const Text(
          'Terms And Condition',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if(_isLoading)
          const Center(child: CircularProgressIndicator(),)
        ],
      ),
    );
  }
}