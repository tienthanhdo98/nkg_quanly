
import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class LoginScreen2 extends StatefulWidget {
  const LoginScreen2({Key? key}) : super(key: key);



  @override
  State<StatefulWidget> createState() =>LoginState();

}
class LoginState extends State<LoginScreen2>{
  InAppWebViewController? webViewController;
  late ContextMenu contextMenu;


  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
          useShouldOverrideUrlLoading: true,
          mediaPlaybackRequiresUserGesture: false),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  @override
  void initState() {
    contextMenu = ContextMenu(
        menuItems: [
          ContextMenuItem(
              androidId: 1,
              iosId: "1",
              title: "Special",
              action: () async {
                print("Menu item Special clicked!");
                print(await webViewController?.getSelectedText());
                await webViewController?.clearFocus();
              })
        ],
        options: ContextMenuOptions(hideDefaultSystemContextMenuItems: false),
        onCreateContextMenu: (hitTestResult) async {
          print("onCreateContextMenu");
          print(hitTestResult.extra);
          print(await webViewController?.getSelectedText());
        },
        onHideContextMenu: () {
          print("onHideContextMenu");
        },
        onContextMenuActionItemClicked: (contextMenuItemClicked) async {
          var id = (Platform.isAndroid)
              ? contextMenuItemClicked.androidId
              : contextMenuItemClicked.iosId;
          print("onContextMenuActionItemClicked: " +
              id.toString() +
              " " +
              contextMenuItemClicked.title);
        });


    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        children: [
          Container(
            height: 300,
            child: InAppWebView(
              initialUrlRequest: URLRequest(
                url: Uri.parse(
                    'https://dangnhap.moet.gov.vn/authenticationendpoint/login.do?client_id=DNoW4q482RZfMLfzbDfKwN_Nm1sa&commonAuthCallerPath=%2Foauth2%2Fauthorize&forceAuth=false&passiveAuth=false&redirect_uri=http%3A%2F%2F123.31.31.237%3A8000%2F&response_type=code&scope=openid&tenantDomain=carbon.super&sessionDataKey=159d5449-6f11-402f-b0d0-0f17dfd74d02&relyingParty=DNoW4q482RZfMLfzbDfKwN_Nm1sa&type=oidc&sp=Test-SSO&isSaaSApp=false&authenticators=BasicAuthenticator%3ALOCAL'),
              ),
              initialOptions: InAppWebViewGroupOptions(
                ios: IOSInAppWebViewOptions(),
                android: AndroidInAppWebViewOptions(
                  domStorageEnabled: true,
                  databaseEnabled: true,
                ),
              ),
              onWebViewCreated: (InAppWebViewController controller) {
                webViewController = controller;
              },
              onLoadStart: (controller, uri) {
                controller.android.clearHistory();
                controller.clearCache();
                print('uriStart $uri');
                var str = uri.toString();
                var part = str.split('ticket=');
                var suffixStr = part.sublist(1).join('').trim();
                print('suffixStr $suffixStr');
                if (suffixStr.isNotEmpty) {
                  // webViewController?.isLoginSSO.value = false;
                  // webViewController?.showLoadingLogin.value = true;
                  // webViewController?.loginTicket(suffixStr);
                }
              },
              onLoadStop: (controller, uri) async {
                print('onStop $uri');
              },
            ),
          ),
          ElevatedButton(onPressed: (){
            Clipboard.setData(const ClipboardData(text: "lcloi@moet.gov.vn"));
          }, child: Text("username")),
          ElevatedButton(onPressed: (){
            Clipboard.setData(const ClipboardData(text: "sdtech@123#"));
          }, child: Text("pass")),



        ],
      ),
    );
  }
}
