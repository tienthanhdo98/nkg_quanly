import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkg_quanly/ui/menu/MenuController.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../const.dart';
import '../../model/document/document_model.dart';
import '../../viewmodel/home_viewmodel.dart';
import '../book_car/book_car_list.dart';
import '../document_nonapproved/document_nonapproved_detail.dart';
import '../document_nonapproved/document_nonapproved_search.dart';


class AdminFormaList extends GetView {
  String? header;
  DateTime dateNow = DateTime.now();
  final MenuController menuController = Get.put(MenuController());
  final homeController = Get.put(HomeViewModel());
  int selectedButton = 0;

  AdminFormaList({this.header});

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
                      color: Theme
                          .of(context)
                          .cardColor,
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
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .headline1,
                            ),
                            Expanded(
                                child: InkWell(
                                  onTap: () {
                                    Get.to(() =>
                                        DocumentnonapprovedSearch(
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
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .headline1,
                            ),
                          ),
                          //date header
                          TableCalendar(
                            calendarStyle: CalendarStyle(
                                todayTextStyle: TextStyle(color: kWhite),
                                todayDecoration: BoxDecoration(
                                  color: kBlueButton,
                                  borderRadius: BorderRadius.circular(20),
                                )),
                            calendarBuilders: CalendarBuilders(
                                selectedBuilder: (context, day, focusday) {
                                  return Container(
                                    decoration: BoxDecoration(
                                        color: kBlueButton),
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
                            style: Theme
                                .of(context)
                                .textTheme
                                .headline2,
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
                                              .contains(
                                              MaterialState.pressed)) {
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
                                        return filterBottomSheet(
                                            menuController);
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
                            itemCount: listAd.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                  onTap: () {
                                    Get.to(() =>
                                        DocumentnonapprovedDetail(
                                            id: snapshot.data!.items![index]
                                                .id!));
                                  },
                                  child:
                                  AdminFormaItem(index, listAd[index]));
                            })),
                    //bottom
                    Container(
                      decoration: BoxDecoration(
                          color: Theme
                              .of(context)
                              .cardColor,
                          border: Border(
                              top: BorderSide(
                                  color: Theme
                                      .of(context)
                                      .dividerColor))),
                      height: 50,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {},
                              child: Container(
                                  decoration: (selectedButton == 0)
                                      ? BoxDecoration(
                                    color: kLightBlue,
                                    borderRadius: BorderRadius.circular(50),
                                  )
                                      : const BoxDecoration(),
                                  height: 40,
                                  width: 40,
                                  child: Center(
                                      child: Text("Ngày",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: (selectedButton == 0)
                                                  ? kBlueButton
                                                  : Colors.black)))),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {},
                              child: Container(
                                  decoration: (selectedButton == 1)
                                      ? BoxDecoration(
                                    color: kLightBlue,
                                    borderRadius: BorderRadius.circular(50),
                                  )
                                      : const BoxDecoration(),
                                  height: 40,
                                  width: 40,
                                  child: Center(
                                      child: Text(
                                        "Tuần",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: (selectedButton == 1)
                                                ? kBlueButton
                                                : Colors.black),
                                      ))),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {},
                              child: Container(
                                  decoration: (selectedButton == 2)
                                      ? BoxDecoration(
                                    color: kLightBlue,
                                    borderRadius: BorderRadius.circular(50),
                                  )
                                      : const BoxDecoration(),
                                  height: 40,
                                  width: 40,
                                  child: Center(
                                      child: Text("Tháng",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: (selectedButton == 2)
                                                  ? kBlueButton
                                                  : Colors.black)))),
                            ),
                          )
                        ],
                      ),
                    )
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

List<AdminFor> listAd = [
  AdminFor(type: 1,level: 1),
  AdminFor(type: 2,level: 2),
  AdminFor(type: 3,level: 1),
  AdminFor(type: 4,level: 2),
  AdminFor(type: 5,level: 3),
  AdminFor(type: 6,level: 1),
];

class AdminFor {
  int? type;
  int? level;

  AdminFor({this.type,this.level});
}

class AdminFormaItem extends StatelessWidget {
  AdminFormaItem(this.index, this.docModel);

  int? index;
  AdminFor? docModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "${index! + 1}.HS01-Hồ sơ duyệt ngân sách ${index! + 1}",
                style: Theme
                    .of(context)
                    .textTheme
                    .headline2,
              ),
              Expanded(
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: priorityWidget(docModel!))),
            ],
          ),
          signWidget(docModel!),
          SizedBox(
              height: 80,
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
                  const Text('Người xử lý',style: CustomTextStyle.secondTextStyle),
                  Text('Nguyễn Tuấn Anh')
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Thời hạn',style: CustomTextStyle.secondTextStyle),
                  Text('20/02/2022')
                ],
              ),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  const Text('Ngày xử lý',style: CustomTextStyle.secondTextStyle),
              Text('20/02/2022')
        ],
      ),
      ],
    ),
    ),
    const Divider(
    thickness: 1.5,
    )
    ]
    ,
    )
    ,
    );
  }
}


Widget priorityWidget(AdminFor docModel) {
  if (docModel.type == "Thấp") {
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

Widget signWidget(AdminFor docModel) {
  print(docModel.level);
  if (docModel.level == 1) {
    return Row(
      children: [
        Image.asset(
          'assets/icons/ic_sign.png',
          height: 14,
          width: 14,
        ),
        const Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
        const Text(
          'Hoàn thành',
          style: TextStyle(color: kGreenSign),
        )
      ],
    );
  } else if (docModel.level == 2) {
    return Row(
      children: [
        Image.asset(
          'assets/icons/ic_not_sign.png',
          height: 14,
          width: 14,
        ),
        const Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
        const Text('Đang xử lý', style: TextStyle(color: kOrangeSign))
      ],
    );
  }
  else if (docModel.level == 3) {
    return Row(
      children: [
        Image.asset(
          'assets/icons/ic_cancel_red.png',
          height: 14,
          width: 14,
        ),
        const Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
        const Text('Quá hạn xử lý', style: TextStyle(color: kRedPriority))
      ],
    );
  }
  else if (docModel.level == 4) {
    return Row(
      children: [
        Image.asset(
          'assets/icons/ic_still.png',
          height: 14,
          width: 14,
        ),
        const Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
        const Text('Trong hạn xử lý', style: TextStyle(color: Colors.black))
      ],
    );
  }
  else if (docModel.level == 5) {
    return Row(
      children: [
        Image.asset(
          'assets/icons/ic_outdate.png',
          height: 14,
          width: 14,
        ),
        const Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
        const Text('Đã thu hồi', style: TextStyle(color: Colors.black))
      ],
    );
  }
  else {
    return Row(
      children: [
        Image.asset(
          'assets/icons/ic_add.png',
          height: 14,
          width: 14,
        ),
        const Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
        const Text('Được tạo mới', style: TextStyle(color: kGreenSign))
      ],
    );
  }
}

