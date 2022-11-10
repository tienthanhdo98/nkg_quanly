import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import '../../const/const.dart';
import '../../const/utils.dart';
import '../../main.dart';


class InAppWebViewExampleScreen extends StatefulWidget {
  const InAppWebViewExampleScreen({this.isLogout = false, Key? key}) : super(key: key);
  final bool isLogout ;

  @override
  _InAppWebViewExampleScreenState createState() =>
      _InAppWebViewExampleScreenState();
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
      body: SafeArea(
        child: Column(
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
                  if(widget.isLogout == false) {
                    webViewController!.loadUrl(urlRequest: URLRequest(
                        url: Uri.parse(loginViewModel.urlLogin)));
                  }else
                    {
                      webViewController!.loadUrl(urlRequest: URLRequest(
                          url: Uri.parse("https://dangnhap.moet.gov.vn/oidc/logout?id_token_hint=${loginViewModel
                          .rxIdAccessToken}&post_logout_redirect_uri=${loginViewModel
                          .rxInfoLoginConfig.value.redirectUri}")));
                    }
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
                    if (url.toString().contains(
                        loginViewModel.rxInfoLoginConfig.value.redirectUri!)) {
                      webViewController!.loadUrl(urlRequest: URLRequest(
                          url: Uri.parse(loginViewModel.urlLogin)));
                      loginViewModel.changeValueLoading(false);
                    }
                },
              )),

          ],
        ),
      ),);
  }
}
