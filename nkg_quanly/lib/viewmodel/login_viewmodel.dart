import 'dart:convert';
import 'dart:async';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nkg_quanly/const/api.dart';
import 'package:nkg_quanly/const/utils.dart';
import 'package:nkg_quanly/model/login/user_info_model.dart';
import '../const/const.dart';
import '../model/login/access_token_model.dart';
import '../model/login/info_login_config.dart';
import '../model/login/sign_up_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel extends GetxController {
  Rx<String> rxAccessTokenSSO = "".obs;
  Rx<String> rxIdAccessToken = "".obs;
  Rx<String> rxAccessTokenIoc = "".obs;
  Rx<bool> isLoginLoading = false.obs;
  Rx<UserInfoModel> rxUserInfoModel = UserInfoModel().obs;
  Rx<SignUpModel> rxSignUpModel = SignUpModel().obs;
  Rx<InfoLoginConfig> rxInfoLoginConfig = InfoLoginConfig().obs;
  String urlLogin = "";
  SharedPreferences? pref;

  Map<String, String> headers = {
    "Content-type": "application/x-www-form-urlencoded"
  };

  @override
  void onInit() {
    getInfoLoginConfig();
    super.onInit();
  }
  initPrefs() async {
    pref ??= await SharedPreferences.getInstance();
  }
  loadFromShareFrefs(String key) async {
    print("key: ${key}");
    await initPrefs();
    String res =  pref?.getString(key) ?? "";
    print("res: $res");
    return  res;
  }

  saveToShareFrefs(String value, String key) async {
    await initPrefs();
    await pref?.setString(key, value);
  }

  void changeValueLoading(bool value) {
    isLoginLoading.value = value;
  }

  Rx<AccessTokenModel> rxAccessTokenModel = AccessTokenModel().obs;
  Future<void> geAccessTokenSSO(String authCode) async {
    Map<String, dynamic> formMap = {
      "grant_type": "authorization_code",
      "code": authCode,
      "redirect_uri": "${rxInfoLoginConfig.value.redirectUri}",
      "client_id": "${rxInfoLoginConfig.value.clientID}",
      "client_secret": "${rxInfoLoginConfig.value.clientSecret}",
    };
    http.Response response = await http.post(Uri.parse(apiGetAccessToken),
        headers: headers, body: formMap);
    
    AccessTokenModel accessTokenModel =
        AccessTokenModel.fromJson(jsonDecode(response.body));
    
    rxAccessTokenSSO.value = accessTokenModel.accessToken!;
    rxIdAccessToken.value = accessTokenModel.idToken!;
    rxAccessTokenModel.value = accessTokenModel;
    saveToShareFrefs(rxAccessTokenSSO.value,keyTokebSSO);
    print("access token sso : ${rxAccessTokenSSO.value}");
    print("ex : ${accessTokenModel.expiresIn}");
    Timer(Duration(seconds: accessTokenModel.expiresIn! - 60), () {
      getRefreshAccessToken(accessTokenModel.refreshToken!);
      print("het han token sso ");
    });
  }

  Future<void> getRefreshAccessToken(String refreshToken) async {
    Map<String, dynamic> json = {
      "grant_type": "refresh_token",
      "refresh_token": refreshToken,
      "client_id": "${rxInfoLoginConfig.value.clientID}",
      "client_secret": "${rxInfoLoginConfig.value.clientSecret}",
    };

    http.Response response = await http.post(Uri.parse(apiGetAccessToken),
        headers: headers, body: json);
    AccessTokenModel signUpModel =
        AccessTokenModel.fromJson(jsonDecode(response.body));
    
    rxAccessTokenSSO.value = signUpModel.accessToken!;
    rxIdAccessToken.value = signUpModel.idToken!;
    print("New AccessToken sso ${rxAccessTokenSSO.value}");
    Timer(Duration(seconds: signUpModel.expiresIn! - 60), () {
      getRefreshAccessToken(signUpModel.refreshToken!);
      saveToShareFrefs(rxAccessTokenSSO.value,keyTokebSSO);
      print("het han token sso ");
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
    
    if (response.statusCode == 200) {
      rxAccessTokenSSO.value = "";
    }
  }

  Future<void> revokeAccessTokenIoc(String token) async {
    http.Response response =
        await http.post(Uri.parse(apiRevokeAccessTokenIoc), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    
    if (response.statusCode == 200) {
      rxAccessTokenIoc.value = "";
    }
  }

  Future<void> getUserInfo(String accessToken) async {
    http.Response response =
        await http.get(Uri.parse(apiGetUserInfo), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    });
    
    UserInfoModel userInfoModel =
        UserInfoModel.fromJson(jsonDecode(response.body));
    
    rxUserInfoModel.value = userInfoModel;
  }

  Future<void> getAccessTokenIoc(String username, String email) async {
    var json = '{"email" : "$email","userName":"$username"}';
    print(email);
    print(username);
    Map<String, String> headers = {"Content-type": "application/json"};
    http.Response response =
        await http.post(Uri.parse(apiGetSignup), headers: headers, body: json);
    
    SignUpModel signUpModel = SignUpModel.fromJson(jsonDecode(response.body));
    
    rxSignUpModel.value = signUpModel;
    rxAccessTokenIoc.value = signUpModel.accessToken!;
    saveToShareFrefs(rxAccessTokenIoc.value,keyTokenIOC);
    print("AccessTokenIoc ${rxAccessTokenIoc.value}");

    Timer(Duration(seconds: signUpModel.expires! - 60), () {
      getRefreshAccessTokenIoc(rxSignUpModel.value.refreshToken!);
      print("refresh token ioc");
    });
  }

  Future<void> getRefreshAccessTokenIoc(String refreshToken) async {
    var json = '{"token" : "$refreshToken"}';
    Map<String, String> headers = {"Content-type": "application/json"};
    http.Response response = await http.post(Uri.parse(apiRefreshIocToken),
        headers: headers, body: json);
    SignUpModel signUpModel = SignUpModel.fromJson(jsonDecode(response.body));
    
    rxSignUpModel.value = signUpModel;
    rxAccessTokenIoc.value = signUpModel.accessToken!;
    saveToShareFrefs(rxAccessTokenIoc.value,keyTokenIOC);
    print("New AccessTokenIoc ${rxAccessTokenIoc.value}");
    Timer.periodic(Duration(seconds: signUpModel.expires! - 60), (_) {
      getRefreshAccessTokenIoc(signUpModel.refreshToken!);
      print("refresh token ioc");
    });
  }

  Future<void> getInfoLoginConfig() async {
    http.Response response = await http.get(Uri.parse(apiLoginConfig));
    
    InfoLoginConfig infoLoginConfig =
        InfoLoginConfig.fromJson(jsonDecode(response.body));
    
    rxInfoLoginConfig.value = infoLoginConfig;
    urlLogin =
        "${infoLoginConfig.baseUrl}/oauth2/authorize?response_type=${infoLoginConfig.responseType}&client_id=${infoLoginConfig.clientID}&redirect_uri=${infoLoginConfig.redirectUri}&scope=${infoLoginConfig.scope}";
  }
}
