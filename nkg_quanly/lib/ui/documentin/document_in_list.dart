import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkg_quanly/ui/documentin/document_in_search.dart';
import 'package:nkg_quanly/ui/menu/MenuController.dart';

import '../../const.dart';
import '../../const/ultils.dart';
import '../../model/document/document_model.dart';
import '../../viewmodel/home_viewmodel.dart';
import '../documentin/document_in_detail.dart';
import 'package:table_calendar/table_calendar.dart';

class DocumentInList extends GetView {
  String? header;
  DateTime dateNow = DateTime.now();
  List<String> listDay = ["CN", "T2", "T3", "T4", "T5", "T6", "T7"];
  List<int> listDate = [7, 8, 9, 10, 11, 12, 13];
  final MenuController menuController = Get.put(MenuController());
  final homeController = Get.put(HomeViewModel());

  DocumentInList({this.header});

  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: FutureBuilder(
        future: homeController.getDocument(),
        builder: (context, AsyncSnapshot<DocumentModel> snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                //header
                Container(
                  color: Theme.of(context).cardColor,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: const Icon(Icons.arrow_back_ios_outlined),
                        ),
                        const Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
                        Text(
                          header!,
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        Expanded(
                            child: InkWell(
                          onTap: () {
                            Get.to(() => DocumentInSearch(
                                  header: header,
                                ));
                          },
                          child: const Align(
                              alignment: Alignment.centerRight,
                              child: Icon(Icons.search)),
                        ))
                      ],
                    ),
                  ),
                ),
                //date table
                Container(
                  width: double.infinity,
                  height: 155,
                  color: kgray,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text(
                          "${dateNow.year} Tháng ${dateNow.month}",
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ),
                      //date header
                      TableCalendar(
                        calendarStyle:  CalendarStyle(
                          todayTextStyle: TextStyle(color: kWhite),
                          todayDecoration: BoxDecoration(color: kBlueButton,
                            borderRadius: BorderRadius.circular(20),)
                        ),
                        calendarBuilders: CalendarBuilders(
                            selectedBuilder: (context, day, focusday) {
                          return Container(
                            decoration: BoxDecoration(color: kBlueButton),
                          );
                        }),
                        locale: 'vi_VN',
                        headerVisible: false,
                        calendarFormat: CalendarFormat.week,
                        firstDay: DateTime.utc(2010, 10, 16),
                        lastDay: DateTime.utc(2030, 3, 14),
                        focusedDay: DateTime.now(),
                      ),
                      //list work
                    ],
                  ),
                ),
                //list
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Row(
                    children: [
                      Text(
                        'Tất cả VB',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      Expanded(
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                      if (states
                                          .contains(MaterialState.pressed)) {
                                        return kVioletBg;
                                      } else {
                                        return kWhite;
                                      } // Use the component's default.
                                    },
                                  ),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          side: const BorderSide(
                                              color: kVioletButton)))),
                              onPressed: () {
                                showModalBottomSheet<void>(
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20),
                                    ),
                                  ),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return filterBottomSheet(menuController);
                                  },
                                );
                              },
                              child: const Text(
                                'Bộ lọc',
                                style: TextStyle(color: kVioletButton),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
                const Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Divider(
                      thickness: 1,
                    )),
                Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data!.items!.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                              onTap: () {
                                Get.to(() => DocumentInDetail(
                                    id: snapshot.data!.items![index].id!));
                              },
                              child:
                                  DocItem(index, snapshot.data!.items![index]));
                        }))
              ],
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return const Center(child: CircularProgressIndicator());
        },
      )),
    );
  }
}

class DocItem extends StatelessWidget {
  DocItem(this.index, this.docModel);

  int? index;
  Items? docModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "${index! + 1}.${docModel!.name}",
                style: Theme.of(context).textTheme.headline2,
              ),
              Expanded(
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: priorityWidget(docModel!))),
            ],
          ),
          signWidget(docModel!),
          SizedBox(
            height: 100,
            child: GridView.count(
              physics: NeverScrollableScrollPhysics(),
              primary: false,
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              crossAxisSpacing: 10,
              mainAxisSpacing: 0,
              crossAxisCount: 3,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Đơn vị ban hành'),
                    Text(docModel!.departmentPublic!)
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Ngày đến'),
                    Text(formatDate(docModel!.toDate!))
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Thời hạn'),
                    Text(formatDate(docModel!.endDate!))
                  ],
                ),
              ],
            ),
          ),
          const Divider(
            thickness: 1.5,
          )
        ],
      ),
    );
  }
}

class filterBottomSheet extends StatelessWidget {
  filterBottomSheet(this.menuController, {Key? key}) : super(key: key);
  MenuController? menuController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
        child: Column(children: [
          Row(
            children: [
              const Text(
                'Tất cả văn bản đến chưa bút phê',
                style: TextStyle(color: kVioletButton),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Checkbox(
                    checkColor: Colors.white,
                    value: false,
                    shape: const CircleBorder(),
                    onChanged: (bool? value) {
                      // setState(() {
                      //   isChecked = value!;
                      // });
                    },
                  ),
                ),
              )
            ],
          ),
          const Divider(
            thickness: 1,
            color: kVioletButton,
          ),
          Expanded(
            child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                shrinkWrap: false,
                itemCount: listFilter.length,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: const EdgeInsets.all(10),
                      child: filterItem(index, context, menuController!));
                }),
          ),
          ElevatedButton(
              onPressed: () {
                // if (menuController!.listStatePriority.contains(0) &&
                //     menuController!.listStatePriority.contains(4)) {
                //   // menuController!.initData();
                // }
                // // else if(menuController!.listStatePriority.contains(1))
                // //   {
                // //     menuController!.listDemo.value = listDocDemo.where((element) => element.priority == 3).toList();
                // //   }
                // else if (menuController!.listStatePriority.contains(2) ||
                //     menuController!.listStatePriority.contains(1)) {
                //   menuController!.listDemo.value = listDocDemo
                //       .where((element) =>
                //           element.priority == 2 || element.priority == 3)
                //       .toList();
                // }
                // Get.back();
              },
              child: Text('click'))
        ]),
      ),
    );
  }
}

Widget filterItem(
    int index, BuildContext context, MenuController menuController) {
  if (index == 0 || index == 4) {
    return Row(
      children: [
        Text(
          'Tất cả mức độ',
          style: Theme.of(context).textTheme.headline2,
        ),
        Obx(() => Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Checkbox(
                  checkColor: Colors.white,
                  value: menuController.listStatePriority.contains(index),
                  shape: const CircleBorder(),
                  onChanged: (bool? value) {
                    menuController.checkboxAllPriorityState(value!, index);
                  },
                ),
              ),
            ))
      ],
    );
  } else {
    return Column(
      children: [
        const Divider(
          thickness: 1,
        ),
        Row(
          children: [
            Text(listFilter[index]),
            Obx(() => Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Checkbox(
                      checkColor: Colors.white,
                      value: menuController.listStatePriority.contains(index),
                      shape: const CircleBorder(),
                      onChanged: (bool? value) {
                        menuController.checkboxPriorityState(value!, index);
                      },
                    ),
                  ),
                ))
          ],
        ),
      ],
    );
  }
}

Widget priorityWidget(Items docModel) {
  if (docModel.level == "Thấp") {
    return Container(
        decoration: BoxDecoration(
          color: kGrayPriority,
          borderRadius: BorderRadius.circular(5),
        ),
        child: const Padding(
            padding: EdgeInsets.all(5),
            child: Text('Thấp', style: TextStyle(color: kWhite))));
  } else if (docModel.level == 'Trung bình') {
    return Container(
        decoration: BoxDecoration(
          color: kBluePriority,
          borderRadius: BorderRadius.circular(5),
        ),
        child: const Padding(
            padding: EdgeInsets.all(5),
            child: Text(
              'Trung bình',
              style: TextStyle(color: kWhite),
            )));
  } else {
    return Container(
        decoration: BoxDecoration(
          color: kRedPriority,
          borderRadius: BorderRadius.circular(5),
        ),
        child: const Padding(
            padding: EdgeInsets.all(5),
            child: Text('Cao', style: TextStyle(color: kWhite))));
  }
}

Widget signWidget(Items docModel) {
  if (docModel.approved == true) {
    return Row(
      children: [
        Image.asset(
          'assets/icons/ic_sign.png',
          height: 14,
          width: 14,
        ),
        const Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
        const Text(
          'Đã bút phê',
          style: TextStyle(color: kGreenSign),
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
        const Text('Chưa bút phê', style: TextStyle(color: kOrangeSign))
      ],
    );
  }
}

class DocModel {
  String? title;
  int? priority;
  bool? isSign;

  DocModel(this.title, this.priority, this.isSign);
}

class DocChildMode {
  String? title;
  String? value;

  DocChildMode(this.title, this.value);
}

List<String> listFilter = [
  'Tất cả mức độ',
  'Cao',
  'Trung bình',
  'Thấp',
  'Tất cả trạng thái',
  'Đã bút phê',
  'Chưa bút phê'
];

List<DocChildMode> listDocChild = [
  DocChildMode('Đơn vị phát hành', 'Bộ giáo dục'),
  DocChildMode('Ngày đến', '20/02/2022'),
  DocChildMode('Thời hạn', '22/02/2022'),
  DocChildMode('Người xử lý', 'Trần Văn An'),
  DocChildMode('Ngày xử lý', '20/02/2022'),
];
