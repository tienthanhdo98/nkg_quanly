import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../const/const.dart';
import '../../const/utils.dart';
import '../../main.dart';


class InAppWebViewExampleScreen extends StatefulWidget {
  @override
  _InAppWebViewExampleScreenState createState() =>
      new _InAppWebViewExampleScreenState();
}

class _InAppWebViewExampleScreenState extends State<InAppWebViewExampleScreen> {
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;
  double progress = 0;

  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          progress < 1.0
              ? LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.white,
            valueColor:
            AlwaysStoppedAnimation<Color>(Colors.green[800]!),
          )
              : Center(), // this perform the loading on every page load
          Expanded(
            child:  InAppWebView(
              initialOptions: InAppWebViewGroupOptions(
                crossPlatform: InAppWebViewOptions(
                  javaScriptEnabled: true,
                  javaScriptCanOpenWindowsAutomatically: true,
                ),
              ),
              onProgressChanged: (_, load) {
                setState(() {
                  progress = load / 100;
                });
              },
              onWebViewCreated: (controller) async {
                webViewController = controller;
                await loginViewModel.getInfoLoginConfig();
                webViewController!.loadUrl(urlRequest: URLRequest(url: Uri.parse(loginViewModel.urlLogin)));
              },
              onUpdateVisitedHistory: (controller, url, isReload) async {
                  print("updadte $url");
                  if (url.toString().contains("?code=")) {
                    var re = RegExp(r'(?<=code=)(.*)(?=&)');
                    var authCode = re.firstMatch(url.toString());
                    if (authCode != null) {
                      print("code ${authCode.group(0)}");
                      await loginViewModel.geAccessToken(authCode.group(0)!);
                      await loginViewModel.getUserInfo(
                          loginViewModel.rxAccessToken.value);
                      await loginViewModel.getAccessTokenIoc(
                          loginViewModel.rxUserInfoModel.value.name!,
                          loginViewModel.rxUserInfoModel.value.email!);
                      loginViewModel.changeValueLoading(false);
                      Get.off(() => const MainScreen());
                    }
                  }
              },
            )),

        ],
      ),);
  }
}
