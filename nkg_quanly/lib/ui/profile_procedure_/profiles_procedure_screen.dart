import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkg_quanly/const/api.dart';
import 'package:nkg_quanly/ui/char3/collum_chart_doc_nonprocess.dart';
import 'package:nkg_quanly/ui/profile_procedure_/profiles_procedure_list.dart';
import 'package:nkg_quanly/ui/profile_procedure_/profiles_procedure_viewmodel.dart';

import '../../const.dart';
import '../../const/widget.dart';
import '../../model/document_unprocess/document_filter.dart';
import '../report/collum_chart_report.dart';
import '../report/pie_chart_report.dart';
import '../theme/theme_data.dart';

class ProfilesProcedureScreen extends GetView {
  String? header;
  String? icon;

  final profilesProcedureController = Get.put(ProfilesProcedureViewModel());

  ProfilesProcedureScreen({Key? key, this.header, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: FutureBuilder(
          future: profilesProcedureController.geProfileProcStatistic(),
          builder: (context, AsyncSnapshot<DocumentFilterModel> snapshot) {
            if (snapshot.hasData) {
              var itemStatistic = snapshot.data;
              return Column(children: [
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
                                      const Text('Tổng hồ sơ',style: CustomTextStyle.robotow400s12TextStyle),
                                      Text(
                                        itemStatistic!.totalRecords.toString(),
                                        style: const TextStyle(
                                            color: kBlueButton, fontSize: 40,fontFamily: 'Roboto'),
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
                                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                              SizedBox(
                                height: 50,
                                child: GridView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                  ),
                                  itemCount: itemStatistic.items!.length,
                                  itemBuilder: (context,index){
                                    var itemQuantity = itemStatistic.items![index];
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(itemQuantity.name!,style: CustomTextStyle.robotow400s12TextStyle),
                                        Text(itemQuantity.quantity.toString(),
                                            style: CustomTextStyle.robotow700s24TextStyle)
                                      ],
                                    );
                                  },
                                ),
                              ),

                            ]),
                          ),
                          context),
                    )
                  ],
                ),
                //button switch chart
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                  child: Row(
                    children: [
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                            child: Obx(() => ElevatedButton(
                              style: profilesProcedureController.selectedChartButton.value == 0
                                  ? activeButtonStyle
                                  : unActiveButtonStyle,
                              onPressed: () async {
                                await profilesProcedureController
                                    .getFilterForChart(apiGetProfileProcedureChart0);
                                profilesProcedureController.selectedChartButton(0);

                              },
                              child: const Text("Mức độ"),
                            )),
                          )),
                      Expanded(
                          child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                              child: Obx(
                                    () => ElevatedButton(
                                  style:
                                  profilesProcedureController.selectedChartButton.value == 1
                                      ? activeButtonStyle
                                      : unActiveButtonStyle,
                                  onPressed: ()  async {
                                    await profilesProcedureController
                                        .getFilterForChart(apiGetProfileProcedureChart1);
                                    profilesProcedureController.swtichChartButton(1);

                                  },
                                  child: const Text("Trạng thái"),
                                ),
                              )))
                    ],
                  ),
                ),
                Obx(() => (profilesProcedureController.selectedChartButton.value == 0)
                    ? Obx(() => CollumChartWidget(key: UniqueKey(),
                    documentFilterModel:
                    profilesProcedureController.rxDocumentFilterModel.value))
                    : Obx(() =>CollumChartWidget(key: UniqueKey(),
                  documentFilterModel:
                  profilesProcedureController.rxDocumentFilterModel.value,
                ))),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
                        child: ElevatedButton(
                          onPressed: () {
                            Get.to(() => ProfilesProcedureList(
                                  header: header,
                                ));
                          },
                          child:buttonShowListScreen("Xem danh sách thủ tục hành chính"),
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
