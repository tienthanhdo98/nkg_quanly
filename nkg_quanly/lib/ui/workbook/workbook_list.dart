import 'package:flutter/material.dart';
import 'package:nkg_quanly/ui/workbook/update_work_screen.dart';
import 'package:nkg_quanly/ui/workbook/workbook_detail.dart';
import 'package:nkg_quanly/ui/workbook/workbook_search.dart';
import 'package:nkg_quanly/ui/workbook/workbook_viewmodel.dart';

import '../../const/const.dart';
import '../../const/style.dart';
import '../../const/utils.dart';
import '../../const/widget.dart';
import '../../model/workbook/workbook_model.dart';
import '../theme/theme_data.dart';
import 'add_new_work_screen.dart';

class WorkBookList extends GetView {

  final workBookViewModel = Get.put(WorkBookViewModel());

  WorkBookList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          //header
          headerWidgetSearch(
              "Sổ tay công việc",
              WorkbookSearch(
                  workBookViewModel
              ),
              context),
          //date table
          headerTableDatePicker(context, workBookViewModel),
          //list
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
            child: Row(
              children: [
                Align(
                  alignment: FractionalOffset.centerLeft,
                  child: Text(
                    'Tất cả công việc',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                Expanded(
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    ElevatedButton(
                      style: elevetedButtonWhite,
                      onPressed: () {
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
                                child: FilterWorkbookFilterBottomSheet(
                                    workBookViewModel));
                          },
                        );
                      },
                      child: const Text(
                        'Bộ lọc',
                        style: TextStyle(color: kVioletButton),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
                    ElevatedButton(
                      onPressed: () {
                        Get.to(() => AddNewWorkScreen());
                      },
                      style: elevetedButtonBlue,
                      child: Row(
                        children: const <Widget>[
                          Icon(
                            Icons.add,
                            color: kWhite,
                            size: 24.0,
                          ),
                          Text("Thêm mới", style: TextStyle(fontSize: 14)),
                        ],
                      ),
                    ),
                  ]),
                )
              ],
            ),
          ),
          const Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Divider(
                thickness: 1,
              )),
          Expanded(
              child: Obx(() => (workBookViewModel.rxWorkBookListItems.isNotEmpty) ? ListView.builder(
                controller: workBookViewModel.controller,
                  itemCount: workBookViewModel.rxWorkBookListItems.length,
                  itemBuilder: (context, index) {
                    return WorkBookItem(
                        index,
                        workBookViewModel.rxWorkBookListItems[index],
                        workBookViewModel);
                  }) : loadingIcon())),
        ],
      )),
    );
  }
}

class WorkBookItem extends StatelessWidget {
  WorkBookItem(this.index, this.docModel, this.workBookViewModel);

  final int? index;
  final WorkBookListItems? docModel;
  final WorkBookViewModel? workBookViewModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${index! + 1}. ${docModel!.workName!}",
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
              InkWell(
                onTap: () {
                  showModalBottomSheet<void>(
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
                          child: MenuItemWorkBookSheetBottomSheet(
                            docModel: docModel,
                            workBookViewModel: workBookViewModel,
                          ));
                    },
                  );
                },
                child: const Align(
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.more_vert)),
              ),
            ],
          ),
          signWidget(docModel!),
          SizedBox(
            height: 80,
            child: GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              primary: false,
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              crossAxisSpacing: 10,
              mainAxisSpacing: 0,
              crossAxisCount: 3,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Nhóm công việc',
                        style: CustomTextStyle.grayColorTextStyle),
                    Text(docModel!.groupWorkName!,
                        style: Theme.of(context).textTheme.headline4)
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Người thực hiện',
                        style: CustomTextStyle.grayColorTextStyle),
                    (docModel!.worker?.isNotEmpty == true)
                        ? Text(docModel!.worker!,
                            style: Theme.of(context).textTheme.headline4)
                        : const Text("")
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Quan trọng',
                        style: CustomTextStyle.grayColorTextStyle),
                    (docModel!.important == true)
                        ? Text("Có",
                            style: Theme.of(context).textTheme.headline4)
                        : Text('Không',
                            style: Theme.of(context).textTheme.headline4)
                  ],
                ),
              ],
            ),
          ),
          const Text('Mô tả', style: CustomTextStyle.grayColorTextStyle),
          Text(docModel!.description!,
              style: Theme.of(context).textTheme.headline4),
          const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 10)),
          const Divider(
            thickness: 1.5,
          )
        ],
      ),
    );
  }
}

Widget signWidget(WorkBookListItems docModel) {
  if (docModel.status == "Đã xử lý") {
    return Row(
      children: [
        Image.asset(
          'assets/icons/ic_sign.png',
          height: 14,
          width: 14,
        ),
        const Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
        Text(
          checkingStringNull(docModel.status),
          style: const TextStyle(color: kGreenSign),
        )
      ],
    );
  } else {
    return Row(
      children: [
        Image.asset(
          'assets/icons/ic_not_sign.png',
          height: 14,
          width: 14,
        ),
        const Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
        Text(checkingStringNull(docModel.status), style: const TextStyle(color: kOrangeSign))
      ],
    );
  }
}

class MenuItemWorkBookSheetBottomSheet extends StatelessWidget {
  const MenuItemWorkBookSheetBottomSheet(
      {Key? key, this.docModel, this.workBookViewModel})
      : super(key: key);
  final WorkBookListItems? docModel;
  final WorkBookViewModel? workBookViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Get.back();
                  Get.to(() => WorkBookDetail(
                        id: docModel!.id!,
                      ));
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 20),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/icons/ic_info.png",
                        height: 20,
                        width: 20,
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      ),
                      Text(
                        "Xem chi tiết công việc",
                        style: Theme.of(context).textTheme.headline3,
                      )
                    ],
                  ),
                ),
              ),
              const Divider(
                thickness: 1,
              ),
              InkWell(
                onTap: () {
                  Get.back();
                  Get.to(() => UpdateWorkBookScreen(docModel!));
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/icons/ic_modify.png",
                        height: 20,
                        width: 20,
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      ),
                      Text("Chỉnh sửa công việc",
                          style: Theme.of(context).textTheme.headline3)
                    ],
                  ),
                ),
              ),
              const Divider(
                thickness: 1,
              ),
              InkWell(
                onTap: () {
                  Get.back();
                  showModalBottomSheet<void>(
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
                          child: DeleteItemWorkBookSheetBottomSheet(
                            docModel: docModel,
                            workBookViewModel: workBookViewModel,
                          ));
                    },
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/icons/ic_trash_del.png",
                        height: 20,
                        width: 20,
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      ),
                      Text("Xóa công việc",
                          style: Theme.of(context).textTheme.headline3)
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}

class DeleteItemWorkBookSheetBottomSheet extends StatelessWidget {
  final WorkBookListItems? docModel;
  final WorkBookViewModel? workBookViewModel;

  const DeleteItemWorkBookSheetBottomSheet(
      {Key? key, this.docModel, this.workBookViewModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Text(
            "Thông báo",
            style: Theme.of(context).textTheme.headline1,
          ),
          const Padding(
              padding: EdgeInsets.fromLTRB(40, 15, 40, 0),
              child: Text(
                'Bạn chắc chắn muốn xóa bản ghi?',
                style: CustomTextStyle.roboto400s16TextStyle,
              )),
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
              child: Image.asset(
                'assets/ic_trash.png',
                width: 110,
                height: 100,
              )),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            height: 50,
            child: Align(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: ElevatedButton(
                          onPressed: () {
                            Get.back();
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: kBlueButton,
                            backgroundColor: kWhite,
                            //change text color of button
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                                side: const BorderSide(color: kVioletButton)),
                          ),
                          child: const Text('Đóng')),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: ElevatedButton(
                          onPressed: () {
                            workBookViewModel!
                                .deleteWorkBookItem(docModel!.id!);
                            Get.back();
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed)) {
                                    return kBlueButton;
                                  } else {
                                    return kBlueButton;
                                  } // Use the component's default.
                                },
                              ),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ))),
                          child: const Text('Xác nhận')),
                    ),
                  )
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}

class FilterWorkbookFilterBottomSheet extends StatelessWidget {
  const FilterWorkbookFilterBottomSheet(this.workBookViewModel, {Key? key})
      : super(key: key);
  final WorkBookViewModel? workBookViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
          child: Column(children: [
            //tatca
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Obx(() => (workBookViewModel!.mapAllFilter.containsKey(0))
                  ? InkWell(
                      onTap: () {
                      checkboxFilterValue(
                            false, 0, "", workBookViewModel!.mapAllFilter);
                      },
                      child: Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'Tất cả công việc',
                              style: TextStyle(
                                  color: kBlueButton,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Roboto',
                                  fontSize: 16),
                            ),
                          ),
                          Image.asset(
                            'assets/icons/ic_checkbox_active.png',
                            width: 30,
                            height: 30,
                          )
                        ],
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        checkboxFilterValue(
                            true, 0, "", workBookViewModel!.mapAllFilter);
                      },
                      child: Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'Tất cả công việc',
                              style: TextStyle(
                                  color: kBlueButton,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Roboto',
                                  fontSize: 16),
                            ),
                          ),
                          Image.asset(
                            'assets/icons/ic_checkbox_unactive.png',
                            width: 30,
                            height: 30,
                          )
                        ],
                      ),
                    )),
            ),
            // tat ca muc do
            const Divider(
              thickness: 1,
              color: kBlueButton,
            ),
            // Tất cả van de trinh
            FilterAllItem("Tất cả độ quan trọng", 1,workBookViewModel!.mapAllFilter),
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
                  physics: const BouncingScrollPhysics(),
                  itemCount: listImportant.length,
                  itemBuilder: (context, index) {
                    var item = listImportant[index];
                    return FilterItem(item,item,index,
                        workBookViewModel!.mapImportantFilter);
                  }),
            ),
            // Tất cả loai phieu trinh
            FilterAllItem( "Tất cả trạng thái", 2,workBookViewModel!.mapAllFilter),
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
                  itemCount: lisStatus.length,
                  itemBuilder: (context, index) {
                    var item = lisStatus[index];
                    return FilterItem(item,item,index,
                        workBookViewModel!.mapStatusFilter);
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
                            var status = "";
                            var important = "";
                            if (workBookViewModel!.mapAllFilter
                                .containsKey(0)) {
                              workBookViewModel!.postWorkBookByFilter(
                                important,
                                status,
                              );
                            } else {
                              if (workBookViewModel!.mapAllFilter
                                  .containsKey(2)) {
                                important = "";
                              } else {
                                workBookViewModel!.mapImportantFilter
                                    .forEach((key, value) {
                                  important += value;
                                });
                              }
                              if (workBookViewModel!.mapAllFilter
                                  .containsKey(3)) {
                                status = "";
                              } else {
                                workBookViewModel!.mapStatusFilter
                                    .forEach((key, value) {
                                  status += value;
                                });
                              }
                            }
                            print(important);
                            print(status);
                            workBookViewModel!.postWorkBookByFilter(
                              important,
                              status,
                            );
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


var listImportant = ["Không quan trọng", "Quan trọng"];
var lisStatus = ["Đang xử lý", "Hoàn thành"];
final List<String> dropdownStatus = ["Đang xử lý", "Hoàn thành"];
