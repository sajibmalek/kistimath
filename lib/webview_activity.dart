import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewActivity extends StatefulWidget{
  const WebViewActivity({Key? key}) : super(key: key);

  @override
  _WebViewActivityState createState() => _WebViewActivityState();
}

class _WebViewActivityState extends State<WebViewActivity> {
  late WebViewController _controller;
  final _url = 'https://www.kistimath.com/';
  //final _url = 'https://dogspull.com/';
  bool _isLoading = true;

  Future<bool> _onWillPop() async {
    if (await _controller.canGoBack()) {
      _controller.goBack();
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              WebView(
                initialUrl: _url,
                javascriptMode: JavascriptMode.unrestricted,
                initialMediaPlaybackPolicy: AutoMediaPlaybackPolicy.always_allow,
                onWebViewCreated: (controller) => _controller = controller,
                onPageStarted: (url) => setState(() => _isLoading = true),
                onPageFinished: (url) => setState(() => _isLoading = false),
                navigationDelegate: (navigation) {
                  if (navigation.url == _url) {
                    return NavigationDecision.navigate;
                  }
                  return NavigationDecision.prevent;
                },
              ),
              if (_isLoading) Center(child: CircularProgressIndicator()),
            ],
          ),
        ),
      ),
    );

  }
}
