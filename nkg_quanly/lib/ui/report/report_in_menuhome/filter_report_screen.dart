import 'package:flutter/material.dart';
import 'package:nkg_quanly/const/utils.dart';

import '../../../const/const.dart';
import '../../../const/style.dart';
import '../../../const/widget.dart';
import '../../theme/theme_data.dart';
import '../report_viewmodel.dart';

// TextEditingController()..text = formatDateToStringtype2(menuController.rxSelectedDay.value)
class FilterReportScreen extends GetView {
  FilterReportScreen(this.reportViewModel, {Key? key}) : super(key: key);
  final ReportViewModel? reportViewModel;
  var state = "";
  var department = "";
  var endDate = "";
  final endDateTextController = TextEditingController(
      text: formatDateToStringtype2(menuController.rxSelectedDay.value));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            children: [
              //header
              headerWidget("Bộ lọc", context),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //nhom đơn vị ban hành
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                        child: Text(
                          "Đơn vị xử lý:",
                          style: CustomTextStyle.grayColorTextStyle,
                        ),
                      ),
                      InkWell(
                          onTap: () {
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
                                    height: 300,
                                    child: FilterDepartmentBottomSheet(
                                        reportViewModel));
                              },
                            );
                          },
                          child: Obx(() => borderTextFilterEOffice(
                              (reportViewModel!.rxSelectedDeparment.value != "")
                                  ? reportViewModel!.rxSelectedDeparment.value
                                  : "Chọn đơn vị",
                              context))),

                      //trang thai
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                        child: Text(
                          "Trạng thái:",
                          style: CustomTextStyle.grayColorTextStyle,
                        ),
                      ),
                      InkWell(
                          onTap: () {
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
                                    height: 450,
                                    child: FilterStatusBottomSheet(
                                        reportViewModel));
                              },
                            );
                          },
                          child: Obx(() => borderTextFilterEOffice(
                              (reportViewModel!.rxSelectedStatus.value != "")
                                  ? reportViewModel!.rxSelectedStatus.value
                                  : "Chọn trạng thái",
                              context))),
                      //han xu ly
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                        child: Text(
                          "Chọn hạn xử lý:",
                          style: CustomTextStyle.grayColorTextStyle,
                        ),
                      ),
                      InkWell(
                        onTap: (){
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
                                  height: 300,
                                  child: DayPickerBottomSheet(
                                      reportViewModel, DATE_PICKER));
                            },
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: kDarkGray,
                              ),
                              borderRadius: BorderRadius.circular(
                                  5) // use instead of BorderRadius.all(Radius.circular(20))
                              ),
                          child: Row(children: [
                            Expanded(
                                child: Obx(
                              () => Text( menuController.rxFromDateWithoutWeekDay.value,),
                            )),
                            Image.asset(
                              "assets/icons/ic_date.png",
                              width: 25,
                              height: 25,
                            ),
                          ]),
                        ),
                      ),
                      const Spacer(),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
                            child: ElevatedButton(
                              onPressed: () {
                                Get.back();
                                if (reportViewModel!.rxSelectedDeparment
                                    .contains("Tất cả")) {
                                  department = "";
                                } else {
                                  department = reportViewModel!
                                      .rxSelectedDeparment.value;
                                }
                                if (reportViewModel!.rxSelectedStatus
                                    .contains("Tất cả")) {
                                  state = "";
                                } else {
                                  state =
                                      reportViewModel!.rxSelectedStatus.value;
                                }

                                endDate = formatDateToString(
                                    menuController.rxSelectedDay.value);

                                print(endDate);
                                print(state);
                                print(department);
                                reportViewModel!.postReportInMenuByFilter(
                                    state, department, endDate);
                              },
                              child: buttonShowListScreen("Tìm kiếm"),
                              style: bottomButtonStyle,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

class FilterDepartmentBottomSheet extends StatelessWidget {
  const FilterDepartmentBottomSheet(this.reportViewModel, {Key? key})
      : super(key: key);
  final ReportViewModel? reportViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
          child: Column(children: [
            //tat ca don vi
            FilterAllItem( "Tất cả đơn vị", 1,reportViewModel!.mapAllFilter),
            const Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Divider(
                  thickness: 1,
                  color: kgray,
                )),
            SizedBox(
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: reportViewModel!.rxListDepartmentFilter.length,
                  itemBuilder: (context, index) {
                    var item = reportViewModel!.rxListDepartmentFilter[index];
                    return
                      FilterItem(item,item,index,
                          reportViewModel!.mapDepartmentFilter);
                  }),
            ),
            //bottom button
            Align(
              child: Row(
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
                            if (reportViewModel!.mapAllFilter.containsKey(1)) {
                              reportViewModel!.changeValueSelectedDepartment(
                                  "Tất cả đơn vị xử lý");
                            } else {
                              var department = "";
                              reportViewModel!.mapDepartmentFilter
                                  .forEach((key, value) {
                                department += value;
                              });
                              reportViewModel!
                                  .changeValueSelectedDepartment(department);
                            }
                            Get.back();
                          },
                          style: buttonFilterBlue,
                          child: const Text('Áp dụng')),
                    ),
                  )
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}

class FilterStatusBottomSheet extends StatelessWidget {
  const FilterStatusBottomSheet(this.reportViewModel, {Key? key})
      : super(key: key);
  final ReportViewModel? reportViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
          child: Column(children: [
            //tat ca don vi
            FilterAllItem( "Tất cả trạng thái", 2,reportViewModel!.mapAllFilter),
            const Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Divider(
                  thickness: 1,
                  color: kgray,
                )),
            SizedBox(
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: listReportState.length,
                  itemBuilder: (context, index) {
                    var item = listReportState[index];
                    return
                      FilterItem(item,item,index,
                          reportViewModel!.mapStatusFilter);
                  }),
            ),
            //bottom button
            Align(
              child: Row(
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
                            if (reportViewModel!.mapAllFilter.containsKey(2)) {
                              reportViewModel!.changeValueSelectedStatus(
                                  "Tất cả trạng thái");
                            } else {
                              var status = "";
                              reportViewModel!.mapStatusFilter
                                  .forEach((key, value) {
                                status += value;
                              });
                              reportViewModel!
                                  .changeValueSelectedStatus(status);
                            }
                            Get.back();
                          },
                          style: buttonFilterBlue,
                          child: const Text('Áp dụng')),
                    ),
                  )
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
