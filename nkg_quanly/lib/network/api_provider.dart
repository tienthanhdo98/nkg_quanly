// import 'dart:convert';
//
// import 'package:http/http.dart';
//
// class ApiProvider {
//   Client client = Client();
//
//   Future<Playlist> getPlayList(String url) async {
//     print("Enter");
//     final respon = await client.get(Uri.parse(url));
//     print(respon.body.toString());
//     if (respon.statusCode == 200) {
//       return Playlist.fromJson(json.decode(respon.body));
//     }
//     else {
//       print("err");
//       throw Exception('Failed to load post ');
//     }
//   }
//
//   Future<List<EPGModel>> getEPG(String url) async {
//     print("Enter");
//     final respon = await client.get(Uri.parse(url));
//     print("epg:" + respon.body.toString());
//     if (respon.statusCode == 200) {
//       var listEpg = <EPGModel>[];
//       List a = json.decode(respon.body) as List;
//       listEpg = a.map((e) => EPGModel.fromJson(e)).toList();
//       return listEpg;
//     }
//     else {
//       print("err");
//       throw Exception('Failed to load post');
//     }
//   }
//   Future<ArticleDetail> getDetail(String url) async {
//     //print("Enter");
//     final respon = await client.get(Uri.parse(url));
//     //print("detail:" + respon.body.toString());
//     if (respon.statusCode == 200) {
//       return ArticleDetail.fromJson(json.decode(respon.body));
//     }
//     else {
//       print("err");
//       throw Exception('Failed to load post');
//     }
//   }
//
// }
