// import 'dart:io' show Platform;
//
// import 'package:flutter/foundation.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'dart:io';
//
// import 'package:webview_flutter/webview_flutter.dart';
//
// import '../../const/const.dart';
// import '../../const/utils.dart';
// import '../../main.dart';
//
//
// class LoginScreen2 extends StatefulWidget {
//   const LoginScreen2({this.isLogout = false, Key? key}) : super(key: key);
//   final bool isLogout;
//
//   // @override
//   // State<StatefulWidget> createState() => LoginState();
// }
//
// class LoginState extends State<LoginScreen2> {
//   WebViewController? wvController;
//
//   @override
//   void initState() {
//     super.initState();
//
//     if (Platform.isAndroid) WebView.platform = AndroidWebView();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: AnnotatedRegion<SystemUiOverlayStyle>(
//         value: SystemUiOverlayStyle.dark,
//         child: SafeArea(
//           child: Stack(
//             children: [
//               WebView(
//                 onWebViewCreated: (WebViewController controller) async {
//                   wvController = controller;
//                   //wvController!.clearCache();
//                   await loginViewModel.getInfoLoginConfig();
//                   if (widget.isLogout == false) {
//                     wvController!.loadUrl(loginViewModel.urlLogin);
//                   }
//                   else {
//                     wvController!.loadUrl(
//                         "https://dangnhap.moet.gov.vn/oidc/logout?id_token_hint=${loginViewModel
//                             .rxIdAccessToken}&post_logout_redirect_uri=${loginViewModel
//                             .rxInfoLoginConfig.value.redirectUri}");
//                   }
//                 },
//                 gestureRecognizers: {}
//                   ..add(Factory<LongPressGestureRecognizer>(
//                           () => LongPressGestureRecognizer())),
//                 javascriptMode: JavascriptMode.unrestricted,
//                 navigationDelegate: (NavigationRequest request) {
//                   if (request.url.contains('?code=')) {
//                     print('blocking navigation to $request}');
//                     return NavigationDecision.prevent;
//                   }
//                   if (request.url.contains(loginViewModel.rxInfoLoginConfig.value.redirectUri!)) {
//                     print('blocking navigation to $request}');
//                     return NavigationDecision.prevent;
//                   }
//                   return NavigationDecision.navigate;
//                 },
//                 onWebResourceError : (value)
//                 {
//                   wvController!.currentUrl().then((value) =>
//                       print("error : ${ value}"));
//
//
//
//                   print("error : ${value.description}");
//                   print("error : ${value.domain}");
//                   print("error : ${value.errorCode}");
//                 },
//                 onPageStarted: (String url){
//                   print("start $url");
//                 },
//                 onProgress: (int pro){
//                   print("start $pro");
//                 },
//                 onPageFinished: (String url) async {
//                   print("ok ok ");
//                   if (url.contains("?code=")) {
//                     var re = RegExp(r'(?<=code=)(.*)(?=&)');
//                     var authCode = re.firstMatch(url);
//                     if (authCode != null) {
//                       print("code ${authCode.group(0)}");
//                       await loginViewModel.geAccessToken(authCode.group(0)!);
//                       await loginViewModel.getUserInfo(
//                           loginViewModel.rxAccessToken.value);
//                       await loginViewModel.getAccessTokenIoc(
//                           loginViewModel.rxUserInfoModel.value.name!,
//                           loginViewModel.rxUserInfoModel.value.email!);
//                       loginViewModel.changeValueLoading(false);
//                       Get.off(() => const MainScreen());
//                     }
//                   }
//                   if (url.contains(
//                       loginViewModel.rxInfoLoginConfig.value.redirectUri!)) {
//                     wvController!.loadUrl(loginViewModel.urlLogin);
//                     loginViewModel.changeValueLoading(false);
//                   }
//                 },
//               ),
//               Obx(() =>
//               (loginViewModel.isLoginLoading.value == true)
//                   ? const Center(child: CircularProgressIndicator())
//                   : const SizedBox.shrink()),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
// }
//
