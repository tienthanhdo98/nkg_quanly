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
    print("pref token: ${prefToken}");
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
                            //webViewController!.stopLoading();
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
                          //webViewController!.stopLoading();
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
                    return NavigationActionPolicy.ALLOW;
                  }
              )),

          ],
        ),
      ),));
  }
}
String getHtmlString() {
  var fontSize = 20;
  return '''
       <!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
        integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/lightgallery@1.8.3/dist/css/lightgallery.min.css">
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Barlow+Semi+Condensed:wght@400;600;700&family=Merriweather&family=Roboto+Slab:wght@700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://hanoionline.vn:4433/css/detail.css/news-option.css?v=20221121024112">
    <link href="https://fonts.google.com/specimen/Playfair+Display?query=Playfair+Display" rel="stylesheet">
    <style>
    
     .entry-body {
            font-size: 16px !important;
            text-align: justify;
            font-family: Barlow;
        }
         h3 {
            font-size: 16px !important;
        }
        
        .VCSortableInPreviewMode div {
            position: relative;
            margin-left: -10px;
            margin-right: -10px
        }
        p {
            font-size: 16px !important;
            text-align: justify;
        }
        .name-n-quote p {
            padding-left: 10px;
            padding-right: 10px
        }
        td p {
            padding-left: 10px;
            padding-right: 10px
        }
        img{
            width: 100% !important;
        }
        figure {
            margin-top: 10px;
            margin-bottom: 10px;
            padding: 0px;
            text-align: center;
            font-size: 16px;
            width: 100%;
        }
        #body {
            font-family: 'Merriweather';
            font-size: 20px;
        }
        #body >p {
            font-family: Barlow !important;
            font-size: 20px;
        }
  
         figure > img{
            margin: 0px; 
            padding: 0px; 
            width: 100% !important;
            border-style: none; 
            font-size: 0px; 
            line-height: 0;
        }
         #body figcaption{
            background-color: #F0F0F0;
            font-family: var(--merri-font);
            color: var(--category-color);
            font-size: ${fontSize}px !important;
            padding: 8px 16px;
            text-align: center;
            width:100%;
            height:fit-content;
           
    </style>
    <title>Nội dung</title>
</head>
<body>
   <div id="body"><div class=\"tiny-pageembed\">&nbsp;</div>\n<div class=\"tiny-pageembed\"><iframe src=\"https://hncms.tek4tv.vn/videoplayer?src=https://hnstorage.tek4tv.vn/MAM/DAI_PTTH_HA_NOI/BAN_THONG_TIN_DIEN_TU/THOI_SU/CHINH_TRI/15122022/TONGBITHUNGUYENPHUTR/100507_TongbithuNguyenPhuTrong.mp3&amp;thumb=https://hnstorage.tek4tv.vn/Mam/attach/upload/15122022090929/ef8bd340-1825-4b4d-a086-c785e2ab7a93-544.jpg\" width=\"100%\" height=\"auto\"></iframe></div>\n<p>&nbsp;</p>\n<p>Tham dự Đại hội c&oacute; c&aacute;c đại biểu l&agrave; l&atilde;nh đạo v&agrave; nguy&ecirc;n l&atilde;nh đạo Đảng, Nh&agrave; nước, Mặt trận Tổ quốc Việt Nam; l&atilde;nh đạo c&aacute;c ban, bộ, ng&agrave;nh, đo&agrave;n thể ở Trung ương v&agrave; c&aacute;c địa phương; Mẹ Việt Nam Anh h&ugrave;ng, Anh h&ugrave;ng lực lượng vũ trang, Anh h&ugrave;ng Lao động, l&atilde;nh đạo Trung ương Đo&agrave;n TNCS Hồ Ch&iacute; Minh c&aacute;c thời kỳ, nh&acirc;n sỹ, tr&iacute; thức ti&ecirc;u biểu; đại diện thanh thiếu nhi ti&ecirc;u biểu trong c&aacute;c lĩnh vực.&nbsp;</p>\n<p>Đại hội c&oacute; sự tham dự của 981 đại biểu đại diện cho hơn 22 triệu đo&agrave;n vi&ecirc;n, thanh ni&ecirc;n Việt Nam trong v&agrave; ngo&agrave;i nước. Đ&acirc;y l&agrave; những c&aacute;n bộ, đo&agrave;n vi&ecirc;n ưu t&uacute; tr&ecirc;n c&aacute;c lĩnh vực hội tụ về Thủ đ&ocirc; H&agrave; Nội ph&aacute;t huy tinh thần nhiệt huyết, tr&aacute;ch nhiệm, tr&iacute; tuệ để l&agrave;m n&ecirc;n một Đại hội th&agrave;nh c&ocirc;ng.&nbsp;</p>\n<p>Với khẩu hiệu \"Kh&aacute;t vọng - Ti&ecirc;n phong - Đo&agrave;n kết - Bản lĩnh - S&aacute;ng tạo\", đại hội biểu thị quyết t&acirc;m ch&iacute;nh trị của tuổi trẻ Việt Nam trong thời kỳ mới kh&aacute;t vọng vươn l&ecirc;n, ra sức phấn đấu vượt qua mọi kh&oacute; khăn, th&aacute;ch thức, vững t&acirc;m thế đảm nhận vai tr&ograve; quan trọng trong sự nghiệp x&acirc;y dựng v&agrave; bảo vệ Tổ quốc Việt Nam x&atilde; hội chủ nghĩa.</p>\n<p>Phi&ecirc;n trọng thể Đại hội đại biểu to&agrave;n quốc Đo&agrave;n TNCS Hồ Ch&iacute; Minh lần thứ XII, nhiệm kỳ 2022 - 2027 sẽ thảo luận về B&aacute;o c&aacute;o ch&iacute;nh trị của Ban Chấp h&agrave;nh Trung ương Đo&agrave;n kh&oacute;a XI tr&igrave;nh đại hội. Tổng B&iacute; thư Nguyễn Ph&uacute; Trọng sẽ ph&aacute;t biểu chỉ đạo đại hội.</p></div>
   <script>
      var imgs = document.getElementsByTagName('img');
for (var i = 0; i < imgs.length; i++) {
                var currentSrc = imgs[i].getAttribute('src');
                if (currentSrc.startsWith("http://")) {
                    currentSrc = currentSrc.replace("http://", "https://");
                }
                imgs[i].setAttribute('data-src', currentSrc);
                imgs[i].setAttribute('src', currentSrc);
                imgs[i].classList.add("gallery");
            }
            lightGallery(document.getElementById('body'), {
                selector: '.gallery',
            })
   </script>
</body>
  
</html>
''';
}
