import 'package:flutter/material.dart';
import '../../../const/const.dart';
import '../../../const/style.dart';
import '../../../const/utils.dart';
import '../../../const/widget.dart';
import '../../theme/theme_data.dart';
import '../document_unprocess_viewmodel.dart';

class FilterDocInScreen extends GetView {
  FilterDocInScreen(this.documentUnprocessViewModel, {Key? key})
      : super(key: key);
  final DocumentUnprocessViewModel? documentUnprocessViewModel;
  String? department;

  String? level;
  String? status;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            children: [
              //header
              Padding(
                padding: const EdgeInsets.all(15),
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/icons/ic_arrow_back.png',
                        width: 18,
                        height: 18,
                      ),
                      const Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
                      Text(
                        "Bộ lọc",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          // analysisReportViewModel!.clearSelectedFilter();
                        },
                        child: const Text(
                          "Xóa bộ lọc",
                          style: TextStyle(color: kBlueButton),
                        ),
                      )
                    ],
                  ),
                ),
              ),
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
                          "Đơn vị ban hành:",
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
                                        documentUnprocessViewModel));
                              },
                            );
                          },
                          child: borderTextFilterEOffice(
                              "Chọn đơn vị ban hành", context)),
                      //muc do
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                        child: Text(
                          "Mức độ:",
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
                                    height: 350,
                                    child: FilterLevelmentBottomSheet(
                                        documentUnprocessViewModel));
                              },
                            );
                          },
                          child:
                              borderTextFilterEOffice("Chọn mức độ", context)),
                      //nhom trang thai
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
                                    height: 430,
                                    child: FilterStatusBottomSheet(
                                        documentUnprocessViewModel));
                              },
                            );
                          },
                          child: borderTextFilterEOffice(
                              "Chọn trạng thái", context)),
                      // const Spacer(),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
                            child: ElevatedButton(
                              onPressed: () {
                                Get.back();
                                var status = "";
                                var level = "";
                                var department = "";
                                if (documentUnprocessViewModel!.mapAllFilter
                                    .containsKey(0)) {
                                  documentUnprocessViewModel!
                                      .getDocumentByFilter(
                                    status,
                                    level,
                                    department,
                                  );
                                } else {
                                  if (documentUnprocessViewModel!.mapAllFilter
                                      .containsKey(1)) {
                                    department = "";
                                  } else {
                                    documentUnprocessViewModel!
                                        .mapDepartmentFilter
                                        .forEach((key, value) {
                                      department += value;
                                    });
                                  }
                                  if (documentUnprocessViewModel!.mapAllFilter
                                      .containsKey(2)) {
                                    level = "";
                                  } else {
                                    documentUnprocessViewModel!.mapLevelFilter
                                        .forEach((key, value) {
                                      level += value;
                                    });
                                  }
                                  if (documentUnprocessViewModel!.mapAllFilter
                                      .containsKey(3)) {
                                    status = "";
                                  } else {
                                    documentUnprocessViewModel!.mapStatusFilter
                                        .forEach((key, value) {
                                      status += value;
                                    });
                                  }
                                }
                                documentUnprocessViewModel!.getDocumentByFilter(
                                    status, level, department);
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
  const FilterDepartmentBottomSheet(this.documentUnprocessViewModel, {Key? key})
      : super(key: key);
  final DocumentUnprocessViewModel? documentUnprocessViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
        child: Column(children: [
          //tat ca don vi
          FilterAllItem( "Tất cả đơn vị ban hành", 1,documentUnprocessViewModel!.mapAllFilter),
          const Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Divider(
                thickness: 1,
                color: kgray,
              )),
          SizedBox(
            height: 120,
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount:
                    documentUnprocessViewModel!.rxListDepartmentFilter.length,
                itemBuilder: (context, index) {
                  var item = documentUnprocessViewModel!
                      .rxListDepartmentFilter[index];
                  return
                    FilterItem(item,item,index,
                        documentUnprocessViewModel!.mapDepartmentFilter);
                }),
          ),
          //bottom button
          Spacer(),
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
                      },
                      style: buttonFilterBlue,
                      child: const Text('Áp dụng')),
                ),
              )
            ],
          )
        ]),
      ),
    );
  }
}

class FilterLevelmentBottomSheet extends StatelessWidget {
  const FilterLevelmentBottomSheet(this.documentUnprocessViewModel, {Key? key})
      : super(key: key);
  final DocumentUnprocessViewModel? documentUnprocessViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
        child: Column(children: [

          FilterAllItem( "Tất cả mức độ", 2,documentUnprocessViewModel!.mapAllFilter),

          const Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Divider(
                thickness: 1,
                color: kgray,
              )),
          //list van de trinh
          SizedBox(
            height: 160,
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: listLevel.length,
                itemBuilder: (context, index) {
                  var item = listLevel[index];
                  return
                    FilterItem(item,item,index,
                        documentUnprocessViewModel!.mapLevelFilter);
                }),
          ),
          //bottom button
          Spacer(),
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
                      },
                      style: buttonFilterBlue,
                      child: const Text('Áp dụng')),
                ),
              )
            ],
          )
        ]),
      ),
    );
  }
}

class FilterStatusBottomSheet extends StatelessWidget {
  const FilterStatusBottomSheet(this.documentUnprocessViewModel, {Key? key})
      : super(key: key);
  final DocumentUnprocessViewModel? documentUnprocessViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
        child: Column(children: [
          FilterAllItem( "Tất cả trạng thái", 3,documentUnprocessViewModel!.mapAllFilter),
          const Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Divider(
                thickness: 1,
                color: kgray,
              )),
          SizedBox(
            height: 250,
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: listDocInStatus.length,
                itemBuilder: (context, index) {
                  var item = listDocInStatus[index];
                  return
                    FilterItem(item,item,index,
                        documentUnprocessViewModel!.mapStatusFilter);
                }),
          ),
          //bottom button
          Spacer(),
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
                      },
                      style: buttonFilterBlue,
                      child: const Text('Áp dụng')),
                ),
              )
            ],
          )
        ]),
      ),
    );
  }
}
