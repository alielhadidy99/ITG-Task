import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:itg_marvel_task/constants/assets.dart';
import 'package:itg_marvel_task/constants/colors.dart';
import 'package:itg_marvel_task/constants/constants.dart';
import 'package:itg_marvel_task/utils/dimens.dart';
import 'package:itg_marvel_task/widgets/loading_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io' show Platform;

class WebViewScreen extends StatefulWidget {
  final String? pageUrl;

  const WebViewScreen(this.pageUrl, {Key? key}) : super(key: key);

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios,color: kWhiteColor,),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: kBlackColor,
          centerTitle: true,
          title: Image.asset(
            kMarvelImage,
            width: setWidth(context, 0.17),
          ),
        ),
        body: Stack(
          children: [
            WebView(
              zoomEnabled: true,
              allowsInlineMediaPlayback: true,
              debuggingEnabled: true,
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl: widget.pageUrl,
              navigationDelegate: (NavigationRequest request) {
                if (request.url.startsWith(kMarvelUrl)) {
                  debugPrint('blocking navigation to $request}');
                  return NavigationDecision.navigate;
                }
                debugPrint('allowing navigation to $request');
                return NavigationDecision.navigate;
              },
              gestureNavigationEnabled: true,
              onPageFinished: (finish) {
                setState(() {
                  isLoading = false;
                });
              },
            ),
            isLoading ? const LoadingWidget() : Stack(),
          ],
        ));
  }
}
