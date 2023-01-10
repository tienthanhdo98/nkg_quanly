import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../const/const.dart';
import '../../const/utils.dart';
import '../../main.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({this.isLogout = false, Key? key}) : super(key: key);
  final bool isLogout ;

  @override
  LoginScreenState createState() =>
      LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;
  double progress = 0;
  String? prefToken = "";



  @override
  void initState() {
    getPrefToken();
    super.initState();

  }
  void getPrefToken() async
  {
   var token = await loginViewModel.loadFromShareFrefs(keyTokebSSO);
   prefToken = token;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark, child :  SafeArea(
        child: Column(
          children: [
            progress < 1.0
                ? LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.white,
              valueColor:
              AlwaysStoppedAnimation<Color>(Colors.green[800]!),
            )
                : const Center(), // this perform the loading on every page load
            Expanded(
              child:  InAppWebView(
                initialOptions: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(
                    javaScriptEnabled: true,
                    useShouldOverrideUrlLoading: true,
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
                    if(prefToken == "") {
                      webViewController!.loadUrl(urlRequest: URLRequest(
                          url: Uri.parse(loginViewModel.urlLogin)));
                      print("AAA: login null");
                    }
                    else
                      {
                        loginViewModel.changeValueLoading(true);
                          await loginViewModel.getUserInfo(
                              prefToken!);
                          if(loginViewModel.rxUserInfoModel.value.name !=null) {
                            await loginViewModel.getAccessTokenIoc(
                                loginViewModel.rxUserInfoModel.value.name!,
                                loginViewModel.rxUserInfoModel.value.email!);
                            loginViewModel.changeValueLoading(false);
                            print("AAA: login with token");
                            Get.off(() => const MainScreen());
                          }
                          else
                            {
                              print("AAA: login toekExpire");
                              webViewController!.loadUrl(urlRequest: URLRequest(
                                  url: Uri.parse(loginViewModel.urlLogin)));
                            }


                      }
                  }else
                    {
                      webViewController!.loadUrl(urlRequest: URLRequest(
                          url: Uri.parse("https://dangnhap.moet.gov.vn/oidc/logout?id_token_hint=${loginViewModel
                          .rxIdAccessToken}&post_logout_redirect_uri=${loginViewModel
                          .rxInfoLoginConfig.value.redirectUri}")));
                    }
                },
                  shouldOverrideUrlLoading: (controller, navigationAction) async {
                    final url = navigationAction.request.url!.toString();
                    if (url.toString().contains('?code=')) {
                      print('blocking navigation to $url}');
                      if (url.toString().contains("?code=")) {
                        var re = RegExp(r'(?<=code=)(.*)(?=&)');
                        var authCode = re.firstMatch(url.toString());
                        if (authCode != null) {
                          print("code ${authCode.group(0)}");
                          await loginViewModel.geAccessTokenSSO(authCode.group(0)!);
                          await loginViewModel.getUserInfo(
                              loginViewModel.rxAccessTokenSSO.value);
                          await loginViewModel.getAccessTokenIoc(
                              loginViewModel.rxUserInfoModel.value.name!,
                              loginViewModel.rxUserInfoModel.value.email!);
                          loginViewModel.changeValueLoading(false);
                          Get.off(() => const MainScreen());
                        }
                      }
                      return NavigationActionPolicy.CANCEL;
                    }
                    else if (url.contains("http://localhost:9090/?sp=Test-SSO&tenantDomain=carbon.super")) {
                      print('blocking navigation to $url}');
                      webViewController!.loadUrl(urlRequest: URLRequest(
                          url: Uri.parse(loginViewModel.urlLogin)));
                      loginViewModel.changeValueLoading(false);
                      return NavigationActionPolicy.CANCEL;
                    }
                    else if (url.contains("https://dangnhap.moet.gov.vn:9443/authenticationendpoint/oauth2_logout.do?tenantDomain=carbon.super")) {
                      print('blocking navigation to $url}');
                      webViewController!.loadUrl(urlRequest: URLRequest(
                          url: Uri.parse(loginViewModel.urlLogin)));
                      loginViewModel.changeValueLoading(false);
                      return NavigationActionPolicy.CANCEL;
                    }
                    return NavigationActionPolicy.ALLOW;
                  }
              )),

          ],
        ),
      ),));
  }
}

