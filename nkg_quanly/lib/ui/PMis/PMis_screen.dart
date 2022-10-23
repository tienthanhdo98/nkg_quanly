import 'package:flutter/material.dart';
import 'package:nkg_quanly/const/style.dart';
import 'package:nkg_quanly/const/utils.dart';
import 'package:nkg_quanly/ui/PMis/pmis_chart.dart';
import 'package:nkg_quanly/ui/PMis/pmis_collum_chart.dart';
import 'package:nkg_quanly/ui/PMis/pmis_viewmodel.dart';

import '../../const/const.dart';
import '../../const/widget.dart';
import '../theme/theme_data.dart';

class PMisScreen extends GetView {
  final String? header;

  final pmisViewModel = Get.put(PmisViewModel());

  PMisScreen({Key? key, this.header}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              headerWidget(header!, context),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                child: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: buttonPmis("Tổng số", 0, 0),
                    ),
                    const Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
                    Expanded(
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            style: elevetedButtonWhite,
                            onPressed: () {
                              pmisViewModel.getUnitPmis();
                              showModalBottomSheet<void>(
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20),
                                  ),
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                context: context,
                                builder: (BuildContext context) {
                                  return SizedBox(
                                      height: 600,
                                      child: FilterPmisUnitBottomSheet(
                                          pmisViewModel));
                                },
                              );
                            },
                            child: const Text(
                              'Bộ lọc',
                              style: TextStyle(color: kVioletButton),
                            ),
                          )),
                    )
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
                  child: Text(
                    "Thống kê",
                    style: Theme.of(context).textTheme.headline1,
                  )),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Tổng số biên chế",
                          style: CustomTextStyle.grayColorTextStyle,
                        ),
                        Obx(() => Text(
                              pmisViewModel.rxTotalBienChe.value,
                              style: Theme.of(context).textTheme.headline1,
                            ))
                      ],
                    ),
                    const Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Tổng số công chức",
                            style: CustomTextStyle.grayColorTextStyle),
                        Obx(() => Text(
                              pmisViewModel.rxTotalCongChuc.value,
                              style: Theme.of(context).textTheme.headline1,
                            ))
                      ],
                    ),
                    const Spacer(),
                    InkWell(
                        onTap: () {
                          refreshChart(
                              pmisViewModel);
                        },
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                          child: Image.asset(
                              "assets/icons/ic_refresh.png",
                              width: 18,
                              height: 18),
                        )),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: kDarkGray,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                      child: Obx(() => Column(children: [
                            ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: pmisViewModel.rxMapListChart.length,
                                itemBuilder: (context, index) {
                                  var listChart = pmisViewModel.rxMapListChart
                                      .elementAt(index);
                                  var title = pmisViewModel.rxListTypeChart
                                      .elementAt(index);
                                  return Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 15),
                                    child: borderItem(
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              15, 15, 15, 15),
                                          child: Column(children: [
                                            Text(
                                              convertTypeToTitleChartPmis(
                                              title),
                                              style: Theme.of(context)
                                              .textTheme
                                              .headline1,
                                            ),
                                            PmisChartWidget(
                                              key: UniqueKey(),
                                              listPmisChartModel: listChart,
                                            )
                                          ]),
                                        ),
                                        context),
                                  );
                                }),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                              child: borderItem(
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        15, 15, 15, 15),
                                    child: Column(children: [
                                      Text(
                                        "SỐ LƯỢNG CÔNG CHỨC THEO ĐƠN VỊ",
                                        style: Theme.of(context)
                                        .textTheme
                                        .headline1,
                                      ),
                                      PmisCollumChartWidget(
                                        key: UniqueKey(),
                                        listPmisChartModel:
                                            pmisViewModel.rxListPmisChartbUnit,
                                      )
                                    ]),
                                  ),
                                  context),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                              child: borderItem(
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        15, 15, 15, 15),
                                    child: Column(children: [
                                      Text(
                                        "SỐ LƯỢNG CÔNG CHỨC THEO NĂM",
                                        style: Theme.of(context)
                                        .textTheme
                                        .headline1,
                                      ),
                                      PmisCollumChartWidget(
                                        key: UniqueKey(),
                                        listPmisChartModel:
                                            pmisViewModel.rxListPmisChartbYear,
                                      )
                                    ]),
                                  ),
                                  context),
                            ),
                          ])),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

void refreshChart(PmisViewModel pmisViewModel) {
  pmisViewModel.getPmisPieChartByUnit();
  pmisViewModel.getPmisPieChartByYear();
  if (pmisViewModel.rxMapUnitId.isNotEmpty) {
    String listUnitId = "";
    pmisViewModel.rxMapUnitId.forEach((key, value) {
      listUnitId += value;
    });
    pmisViewModel.getPmisPieChart(listUnitId);
  } else {
    pmisViewModel.getPmisPieChart("");
  }
}

class FilterPmisUnitBottomSheet extends StatelessWidget {
  const FilterPmisUnitBottomSheet(this.pmisViewModel, {Key? key})
      : super(key: key);
  final PmisViewModel? pmisViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(children: [
            buttonLineInBottonSheet(),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
              child: Container(
                decoration: BoxDecoration(
                    color: kgray, borderRadius: BorderRadius.circular(10)),
                height: 50,
                width: double.infinity,
                child: Row(
                  children: [
                    const Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Icon(Icons.search)),
                    SizedBox(
                      width: 200,
                      child: TextField(
                        maxLines: 1,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: kDarkGray, fontSize: 14),
                          hintText: 'Tìm kiếm đơn vị...',
                        ),
                        style:
                            const TextStyle(color: Colors.black, fontSize: 14),
                        onSubmitted: (value) {
                          pmisViewModel!.searchInnUnitList(value);
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            // Tất cả do vi
            FilterAllItem( "Tất cả đơn vị", 1,pmisViewModel!.mapAllFilter),
            const Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Divider(
                  thickness: 1,
                  color: kgray,
                )),
            //list van de trinh
            SizedBox(
              child: Obx(() => ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: pmisViewModel!.rxListPmisUnitModel.length,
                  itemBuilder: (context, index) {
                    var item = pmisViewModel!.rxListPmisUnitModel[index];
                    return
                      FilterItem(item.ten!,item.id!,index,
                          pmisViewModel!.rxMapUnitId);
                  })),
            ),
            //bottom butto
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        style: buttonFilterWhite,
                        child: const Text('Đóng')),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                        onPressed: () {
                          Get.back();
                          var listUnitId = "";

                          if (pmisViewModel!.mapAllFilter.containsKey(1)) {
                            listUnitId = "";
                          } else {
                            pmisViewModel!.rxMapUnitId.forEach((key, value) {
                              listUnitId += value;
                            });
                          }

                          print(listUnitId);
                          pmisViewModel!.getStatisticTotal(listUnitId);
                          pmisViewModel!.getPmisPieChart(listUnitId);
                        },
                        style: buttonFilterBlue,
                        child: const Text('Áp dụng')),
                  ),
                )
              ],
            )
          ]),
        ),
      ),
    );
  }
}
