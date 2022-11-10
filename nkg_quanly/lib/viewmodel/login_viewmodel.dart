import 'dart:convert';
import 'dart:async';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nkg_quanly/const/api.dart';
import 'package:nkg_quanly/const/utils.dart';
import 'package:nkg_quanly/model/login/user_info_model.dart';
import '../model/login/access_token_model.dart';
import '../model/login/info_login_config.dart';
import '../model/login/sign_up_model.dart';

class LoginViewModel extends GetxController {
  Rx<String> rxAccessToken = "".obs;
  Rx<String> rxIdAccessToken = "".obs;
  Rx<String> rxAccessTokenIoc = "".obs;
  Rx<bool> isLoginLoading = false.obs;
  Rx<UserInfoModel> rxUserInfoModel = UserInfoModel().obs;
  Rx<SignUpModel> rxSignUpModel = SignUpModel().obs;
  Rx<InfoLoginConfig> rxInfoLoginConfig = InfoLoginConfig().obs;
  Rx<String>  urlLogin = "".obs;
  Map<String, String> headers = {
    "Content-type": "application/x-www-form-urlencoded"
  };
  @override
  void onInit() {
    getInfoLoginConfig();
    super.onInit();
  }
  void changeValueLoading(bool value)
  {
    isLoginLoading.value = value;
  }

  Future<void> geAccessToken(String authCode) async {
    Map<String, dynamic> formMap = {
      "grant_type": "authorization_code",
      "code": authCode,
      "redirect_uri": "${rxInfoLoginConfig.value.redirectUri}",
      "client_id": "${rxInfoLoginConfig.value.clientID}",
      "client_secret": "${rxInfoLoginConfig.value.clientSecret}",
    };
    http.Response response = await http.post(Uri.parse(apiGetAccessToken),
        headers: headers, body: formMap);
    print(response.body);
    AccessTokenModel accessTokenModel =
        AccessTokenModel.fromJson(jsonDecode(response.body));
    print(response.body);
    rxAccessToken.value = accessTokenModel.accessToken!;
    rxIdAccessToken.value = accessTokenModel.idToken!;
    print("access token : ${ rxAccessToken.value}");
    print("ex : ${ accessTokenModel.expiresIn}");
    Timer.periodic(Duration(seconds: accessTokenModel.expiresIn! ), (_) {

      print("het han");
    });
  }

  Future<void> revokeAccessToken(String token) async {
    Map<String, dynamic> formMap = {
      "token": token,
      "token_type_hint ": "access_token",
      "client_id": "${rxInfoLoginConfig.value.clientID}",
      "client_secret": "${rxInfoLoginConfig.value.clientSecret}",
    };
    http.Response response = await http.post(Uri.parse(apiRevokeAccessToken),
        headers: headers, body: formMap);
    print(response.body);
    if(response.statusCode == 200)
      {
        rxAccessToken.value = "";
      }
  }
  Future<void> revokeAccessTokenIoc(String token) async {
    http.Response response = await http.post(Uri.parse(apiRevokeAccessTokenIoc),headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    print(response.body);
    if(response.statusCode == 200)
    {
      rxAccessTokenIoc.value = "";
    }
  }

  Future<void> getUserInfo(String accessToken) async {
    http.Response response = await http.get(Uri.parse(apiGetUserInfo),headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $accessToken',
    });
    print(response.body);
    UserInfoModel userInfoModel =
    UserInfoModel.fromJson(jsonDecode(response.body));
    print(response.body);
    rxUserInfoModel.value = userInfoModel;
  }
  Future<void> getAccessTokenIoc(String username,String email) async {
    var json = '{"email" : "$email","userName":"$username"}';
    Map<String, String> headers = {"Content-type": "application/json"};
    http.Response response = await http.post(Uri.parse(apiGetSignup),headers: headers,body:json);
    print(response.body);
    SignUpModel signUpModel =
    SignUpModel.fromJson(jsonDecode(response.body));
    print(response.body);
    rxSignUpModel.value = signUpModel;
    rxAccessTokenIoc.value = signUpModel.accessToken!;
    print("AccessTokenIoc ${rxAccessTokenIoc.value}");
    Timer.periodic(Duration(seconds: signUpModel.expires! ), (_) {

      print("het han");
    });
  }
  Future<void> getInfoLoginConfig() async {
    http.Response response = await http.get(Uri.parse(apiLoginConfig));
    print(response.body);
    InfoLoginConfig infoLoginConfig = await
    InfoLoginConfig.fromJson(jsonDecode(response.body));
    print(response.body);
    rxInfoLoginConfig.value = infoLoginConfig;
    urlLogin.value = "${infoLoginConfig.baseUrl}/oauth2/authorize?response_type=${infoLoginConfig.responseType}&client_id=${infoLoginConfig.clientID}&redirect_uri=${infoLoginConfig.redirectUri}&scope=${infoLoginConfig.scope}";
  }


}
