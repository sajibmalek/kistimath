
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';

class NewWebviewActivity extends StatefulWidget {
  const NewWebviewActivity({Key? key}) : super(key: key);

  @override
  _WebViewActivityState createState() => _WebViewActivityState();
}

class _WebViewActivityState extends State<NewWebviewActivity> {
  late InAppWebViewController _controller;
  final _url = 'https://www.kistimath.com/';
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
              InAppWebView(
                initialUrlRequest: URLRequest(url: Uri.parse(_url)),
              initialData: InAppWebViewInitialData(mimeType: 'text/html',encoding: 'utf8', data: 'text/html',),
                initialOptions: InAppWebViewGroupOptions(

                  crossPlatform: InAppWebViewOptions(
                    javaScriptEnabled: true,
                    mediaPlaybackRequiresUserGesture: false,
                   // javaScriptCanOpenWindowsAutomatically: true,
                  //  useShouldInterceptAjaxRequest: true,
                    useShouldOverrideUrlLoading: true,
                  //  useShouldInterceptFetchRequest: true,
               //     allowUniversalAccessFromFileURLs: true,
                   // preferredContentMode: UserPreferredContentMode.MOBILE
                  ),


                  android: AndroidInAppWebViewOptions(
                      disableDefaultErrorPage: false,
                      // useHybridComposition: true,
                      supportMultipleWindows: false,
                      cacheMode: AndroidCacheMode.LOAD_DEFAULT,
                    mixedContentMode: AndroidMixedContentMode.MIXED_CONTENT_ALWAYS_ALLOW,
                  //  domStorageEnabled: true,
                  ),
                ),
                onWebViewCreated: (controller) => _controller = controller,
                onLoadStart: (controller, url) async {
                  setState(() => _isLoading = true);
                  if (url.toString().startsWith('https://api.whatsapp.com/send/')) {
                    if (await canLaunch(url.toString())) {
                      await launch(url.toString());
                      await _controller.goBack();
                    }
                  }
                },

                onLoadStop: (controller, url) => setState(() => _isLoading = false),
                  androidOnPermissionRequest: (InAppWebViewController controller, String origin, List<String> resources) async {
                    return PermissionRequestResponse(resources: resources, action: PermissionRequestResponseAction.GRANT);
                  }
              ),
              if (_isLoading) const Center(child: CircularProgressIndicator()),
            ],
          ),
        ),
      ),
    );
  }
}
