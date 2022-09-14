import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkg_quanly/ui/profile/profile_chart.dart';
import 'package:nkg_quanly/ui/profile/profile_list.dart';
import 'package:nkg_quanly/viewmodel/home_viewmodel.dart';

import '../../const.dart';
import '../../const/api.dart';
import '../../model/document/document_statistic_model.dart';
import '../../model/document_unprocess/document_filter.dart';
import '../../model/proflie_model/profile_statistic.dart';
import '../chart/column_chart2.dart';
import '../document_nonapproved/document_nonapproved_list.dart';
import '../theme/theme_data.dart';


class ProfileScreen extends GetView {
  String? header;
  String? icon;

  final homeController = Get.put(HomeViewModel());

  ProfileScreen({Key? key, this.header, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: FutureBuilder(
          future: homeController.getQuantityDocumentBuUrl(apiGetProfileFilter1),
          builder: (context, AsyncSnapshot<List<DocumentFilterModel>> snapshot) {
            if (snapshot.hasData) {
              return Column(
                  children: [
                Stack(
                  children: [
                    Image.asset("assets/bgtophome.png",
                        height: 220, width: double.infinity, fit: BoxFit.cover),
                    headerWidget(header!, context),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 100, 20, 0),
                      child: border(
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(children: [
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('Tổng văn bản'),
                                      Text(
                                        snapshot.data!.first.quantity.toString(),
                                        style: const TextStyle(
                                            color: kBlueButton, fontSize: 40),
                                      )
                                    ],
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Image.asset(
                                        icon!,
                                        width: 50,
                                        height: 50,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 20),
                                child: Divider(
                                  thickness: 1,
                                ),
                              ),
                              SizedBox(
                                height: 60,
                                child: GridView.builder(
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                  ),
                                  itemCount: snapshot.data!.length -1 ,
                                  itemBuilder: (context,index)
                                  {
                                    return  Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(snapshot.data![index].name!),
                                        Text(
                                            snapshot.data![index].quantity.toString(),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20))
                                      ],
                                    );
                                  },
                                ),
                              )
                            ]),
                          ),
                          context),
                    )
                  ],
                ),
                    Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: ProfileChart(homeViewModel: homeController,listBaseChart: snapshot.data!,)),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
                        child: ElevatedButton(
                          onPressed: () {
                            Get.to(() => ProfileList(
                                  header: header,
                                ));
                          },
                          child: const Text('Xem danh sách VB đến chưa bút phê'),
                          style: bottomButtonStyle,
                        ),
                      ),
                    ),
                  ),
                )
              ]);
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}