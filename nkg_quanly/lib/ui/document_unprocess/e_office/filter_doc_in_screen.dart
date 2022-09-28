import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../const.dart';
import '../../../const/style.dart';
import '../../../const/widget.dart';
import '../../theme/theme_data.dart';
import '../document_unprocess_viewmodel.dart';


class FilterDocInScreen extends GetView {
  FilterDocInScreen(this.documentUnprocessViewModel, {Key? key}) : super(key: key);
  final DocumentUnprocessViewModel? documentUnprocessViewModel;
  String? department ;
  String? level;
  String? status ;

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
                                  child: FilterDepartmentBottomSheet(documentUnprocessViewModel));
                            },
                          );
                        },
                        child: borderTextFilterEOffice("Chọn mức độ",context)),
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
                                  height: 400,
                                  child: FilterLevelmentBottomSheet(documentUnprocessViewModel));
                            },
                          );
                        },
                        child: borderTextFilterEOffice("Chọn mức độ",context)),
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
                                  height:500,
                                  child: FilterStatusBottomSheet(documentUnprocessViewModel));
                            },
                          );
                        },
                        child: borderTextFilterEOffice("Chọn trạng thái",context)),
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
                              var status = "";
                              var level = "";
                              var department = "";
                              if (documentUnprocessViewModel!.mapAllFilter.containsKey(0)) {
                                documentUnprocessViewModel!.getDocumentByFilter(
                                  status,
                                  level,
                                  department,);
                              } else {
                                if (documentUnprocessViewModel!.mapAllFilter
                                    .containsKey(1)) {
                                  department = "";
                                }
                                else
                                {
                                  documentUnprocessViewModel!.mapDepartmentFilter.forEach((key, value) {
                                    department += value;
                                  });
                                }
                                if (documentUnprocessViewModel!.mapAllFilter
                                    .containsKey(2)) {
                                  level = "";
                                }
                                else
                                {
                                  documentUnprocessViewModel!.mapLevelFilter.forEach((key, value) {
                                    level += value;
                                  });
                                }
                                if (documentUnprocessViewModel!.mapAllFilter
                                    .containsKey(3)) {
                                  status = "";
                                }
                                else
                                {
                                  documentUnprocessViewModel!.mapStatusFilter.forEach((key, value) {
                                    status += value;
                                  });
                                }
                              }
                              print(department);
                              print(level);
                              print(status);
                              documentUnprocessViewModel!.getDocumentByFilter(
                                  status,
                                  level,
                                  department);
                            },
                            child: buttonShowListScreen(
                                "Tìm kiếm"),
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
        ),));
  }
}
class FilterDepartmentBottomSheet extends StatelessWidget {
  const FilterDepartmentBottomSheet(this.documentUnprocessViewModel,
      {Key? key})
      : super(key: key);
  final DocumentUnprocessViewModel? documentUnprocessViewModel;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
          child: Column(children: [
            //tat ca don vi
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Tất cả đơn vị ban hành',
                      style: CustomTextStyle.roboto700TextStyle,
                    ),
                  ),
                  Obx(() => (documentUnprocessViewModel!.mapAllFilter.containsKey(1))
                      ? InkWell(
                      onTap: () {
                        documentUnprocessViewModel!.checkboxFilterAll(false, 1);
                      },
                      child: Image.asset(
                        'assets/icons/ic_checkbox_active.png',
                        width: 30,
                        height: 30,
                      ))
                      : InkWell(
                      onTap: () {
                        documentUnprocessViewModel!.checkboxFilterAll(true, 1);
                      },
                      child: Image.asset(
                        'assets/icons/ic_checkbox_unactive.png',
                        width: 30,
                        height: 30,
                      )))
                ],
              ),
            ),
            const Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Divider(
                  thickness: 1,
                  color: kgray,
                )),
            SizedBox(
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: documentUnprocessViewModel!.rxListDepartmentFilter.length,
                  itemBuilder: (context, index) {
                    var item = documentUnprocessViewModel!.rxListDepartmentFilter[index];
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  item,
                                  style: CustomTextStyle.roboto400s16TextStyle,
                                ),
                              ),
                              Obx(() => (documentUnprocessViewModel!.mapDepartmentFilter
                                  .containsKey(index))
                                  ? InkWell(
                                  onTap: () {
                                    documentUnprocessViewModel!.checkboxDepartment(
                                        false, index, "$item;");
                                  },
                                  child: Image.asset(
                                    'assets/icons/ic_checkbox_active.png',
                                    width: 30,
                                    height: 30,
                                  ))
                                  : InkWell(
                                  onTap: () {
                                    documentUnprocessViewModel!.checkboxDepartment(
                                        true, index, "$item;");
                                  },
                                  child: Image.asset(
                                    'assets/icons/ic_checkbox_unactive.png',
                                    width: 30,
                                    height: 30,
                                  )))
                            ],
                          ),
                        ),
                        const Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Divider(
                              thickness: 1,
                              color: kgray,
                            )),
                      ],
                    );
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
class FilterLevelmentBottomSheet extends StatelessWidget {
  const FilterLevelmentBottomSheet(this.documentUnprocessViewModel,
      {Key? key})
      : super(key: key);
  final DocumentUnprocessViewModel? documentUnprocessViewModel;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
          child: Column(children: [
            //tat ca don vi
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Tất cả mức độ',
                      style: CustomTextStyle.roboto700TextStyle,
                    ),
                  ),
                  Obx(() => (documentUnprocessViewModel!.mapAllFilter.containsKey(2))
                      ? InkWell(
                      onTap: () {
                        documentUnprocessViewModel!.checkboxFilterAll(false, 2);
                      },
                      child: Image.asset(
                        'assets/icons/ic_checkbox_active.png',
                        width: 30,
                        height: 30,
                      ))
                      : InkWell(
                      onTap: () {
                        documentUnprocessViewModel!.checkboxFilterAll(true, 2);
                      },
                      child: Image.asset(
                        'assets/icons/ic_checkbox_unactive.png',
                        width: 30,
                        height: 30,
                      )))
                ],
              ),
            ),
            const Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Divider(
                  thickness: 1,
                  color: kgray,
                )),
            //list van de trinh
            SizedBox(
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: listLevel.length,
                  itemBuilder: (context, index) {
                    var item = listLevel[index];
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  item,
                                  style: CustomTextStyle.roboto400s16TextStyle,
                                ),
                              ),
                              Obx(() => (documentUnprocessViewModel!.mapLevelFilter
                                  .containsKey(index))
                                  ? InkWell(
                                  onTap: () {
                                    documentUnprocessViewModel!
                                        .checkboxLevel(
                                        false, index, "$item;");
                                  },
                                  child: Image.asset(
                                    'assets/icons/ic_checkbox_active.png',
                                    width: 30,
                                    height: 30,
                                  ))
                                  : InkWell(
                                  onTap: () {
                                    documentUnprocessViewModel!
                                        .checkboxLevel(
                                        true, index, "$item;");
                                  },
                                  child: Image.asset(
                                    'assets/icons/ic_checkbox_unactive.png',
                                    width: 30,
                                    height: 30,
                                  )))
                            ],
                          ),
                        ),
                        const Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Divider(
                              thickness: 1,
                              color: kgray,
                            )),
                      ],
                    );
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
  const FilterStatusBottomSheet(this.documentUnprocessViewModel,
      {Key? key})
      : super(key: key);
  final DocumentUnprocessViewModel? documentUnprocessViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
          child: Column(children: [
            //tat ca don vi
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Tất cả trạng thái',
                      style: CustomTextStyle.roboto700TextStyle,
                    ),
                  ),
                  Obx(() => (documentUnprocessViewModel!.mapAllFilter.containsKey(3))
                      ? InkWell(
                      onTap: () {
                        documentUnprocessViewModel!.checkboxFilterAll(false, 3);
                      },
                      child: Image.asset(
                        'assets/icons/ic_checkbox_active.png',
                        width: 30,
                        height: 30,
                      ))
                      : InkWell(
                      onTap: () {
                        documentUnprocessViewModel!.checkboxFilterAll(true, 3);
                      },
                      child: Image.asset(
                        'assets/icons/ic_checkbox_unactive.png',
                        width: 30,
                        height: 30,
                      )))
                ],
              ),
            ),
            const Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Divider(
                  thickness: 1,
                  color: kgray,
                )),
            SizedBox(
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: listDocInStatus.length,
                  itemBuilder: (context, index) {
                    var item = listDocInStatus[index];
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  item,
                                  style: CustomTextStyle.roboto400s16TextStyle,
                                ),
                              ),
                              Obx(() => (documentUnprocessViewModel!.mapStatusFilter
                                  .containsKey(index))
                                  ? InkWell(
                                  onTap: () {
                                    documentUnprocessViewModel!
                                        .checkboxStatus(
                                        false, index, "$item;");
                                  },
                                  child: Image.asset(
                                    'assets/icons/ic_checkbox_active.png',
                                    width: 30,
                                    height: 30,
                                  ))
                                  : InkWell(
                                  onTap: () {
                                    documentUnprocessViewModel!
                                        .checkboxStatus(
                                        true, index, "$item;");
                                  },
                                  child: Image.asset(
                                    'assets/icons/ic_checkbox_unactive.png',
                                    width: 30,
                                    height: 30,
                                  )))
                            ],
                          ),
                        ),
                        const Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Divider(
                              thickness: 1,
                              color: kgray,
                            )),
                      ],
                    );
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


