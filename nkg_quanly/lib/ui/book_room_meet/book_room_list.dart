import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkg_quanly/ui/menu/MenuController.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../const.dart';
import '../../model/document/document_model.dart';
import '../../viewmodel/home_viewmodel.dart';
import '../document_nonapproved/document_nonapproved_detail.dart';
import '../document_nonapproved/document_nonapproved_search.dart';

class BookRoomList extends GetView {
  String? header;
  DateTime dateNow = DateTime.now();
  final MenuController menuController = Get.put(MenuController());
  final homeController = Get.put(HomeViewModel());
  int selectedButton = 0;

  BookRoomList({this.header});

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
                            Get.to(() => DocumentnonapprovedSearch(
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
                        calendarStyle: CalendarStyle(
                            todayTextStyle: TextStyle(color: kWhite),
                            todayDecoration: BoxDecoration(
                              color: kBlueButton,
                              borderRadius: BorderRadius.circular(20),
                            )),
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
                        'Tất cả danh sách ô tô',
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

                //
               const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 20)),
                Expanded(
                    child: Container(
                  height: double.infinity,
                  decoration: const BoxDecoration(
                      color: kLightGray,
                      border: Border(
                        top: BorderSide(
                          color: kgray,
                          width: 1,
                        ),
                      )),
                  child: Column(children: [
                    Column(children: [
                      SizedBox(
                        height: 40,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Cả ngày",
                                  style: Theme.of(context).textTheme.headline2,
                                ),
                              ),
                            ),
                            const VerticalDivider(width: 1, thickness: 1),
                            const Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 10, 0)),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Danh sách bố trí ô tô",
                                    style:
                                        Theme.of(context).textTheme.headline2),
                              ),
                            )
                          ],
                        ),
                      ),
                      const Divider(
                        thickness: 2,
                      ),
                    ]),
                    //list car
                    Expanded(
                        child: SizedBox(
                      height: double.infinity,
                      child: ListView.builder(
                          itemCount: listCar.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                                onTap: () {
                                  Get.to(() => DocumentnonapprovedDetail(
                                      id: snapshot.data!.items![index].id!));
                                },
                                child: BookCarItem(index, listCar[index]));
                          }),
                    )),
                    //bottom
                    Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          border: Border(
                              top: BorderSide(
                                  color: Theme.of(context).dividerColor))),
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
                                          borderRadius:
                                              BorderRadius.circular(50),
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
                                          borderRadius:
                                              BorderRadius.circular(50),
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
                                          borderRadius:
                                              BorderRadius.circular(50),
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
                  ]),
                )),
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

class BookCarItem extends StatelessWidget {
  BookCarItem(this.index, this.docModel);

  int? index;
  CarItem? docModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 25),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: SizedBox(
              width: 90,
              child: Column(
                children: const [
                  Align(alignment: Alignment.centerLeft, child: Text("08:00")),
                  Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "1h",
                        style: CustomTextStyle.secondTextStyle,
                      )),
                ],
              ),
            ),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${docModel!.name}",
                  style: Theme.of(context).textTheme.headline2,
                ),
                const Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                signWidget(docModel!),
                const Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                Row(
                  children: [
                    Image.asset(
                      "assets/icons/ic_camera.png",
                      height: 20,
                      width: 20,
                      fit: BoxFit.fill,
                    ),
                    const Padding(
                        padding: EdgeInsets.fromLTRB(
                            0, 0, 5, 0)),
                    const Text("Phòng họp lớn 01",
                        style: CustomTextStyle
                            .secondTextStyle)
                  ],
                ),
                const Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                Row(
                  children: [
                    Image.asset(
                      'assets/icons/ic_user.png',
                      width: 30,
                      height: 30,
                    ),
                    const Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
                    const Text('Nguyễn Văn A')
                  ],
                ),
              ],
            ),
          ),
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
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: Row(
              children: [
                const Text(
                  'Tất cả danh sách ô tô',
                  style: TextStyle(
                      color: kVioletButton, fontWeight: FontWeight.bold),
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
          ),
          const Divider(
            thickness: 1,
            color: kVioletButton,
          ),
          Expanded(
            child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                shrinkWrap: false,
                itemCount: listCarFilter.length,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: const EdgeInsets.all(10),
                      child: filterItem(index, context, menuController!));
                }),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: kWhite, //change background color of button
                        onPrimary: kBlueButton, //change text color of button
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                            side: const BorderSide(color: kVioletButton)),
                      ),
                      child: Text('Đóng')),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: ElevatedButton(
                      onPressed: () {
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
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ))),
                      child: Text('Áp dụng')),
                ),
              )
            ],
          )
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
            Text(listCarFilter[index]),
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


Widget signWidget(CarItem docModel) {
  if (docModel.status == 1) {
    return Row(
      children: [
        Image.asset(
          'assets/icons/ic_sign.png',
          height: 14,
          width: 14,
        ),
        const Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
        const Text(
          'Đã đặt lịch',
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
        const Text('Còn trống', style: TextStyle(color: kOrangeSign))
      ],
    );
  }
}

List<String> listCarFilter = [
  'Tất cả danh sách ô tô',
  'Đã đặt lịch',
  'Còn trống',
];

class CarItem {
  int? status;
  String? name;

  CarItem(this.status, this.name);
}

List<CarItem> listCar = [
  CarItem(1, "Hội thảo trực tuyến phòng ngừa thuốc lá cho học sinh"),
  CarItem(2, "Hội thảo trực tuyến phòng ngừa thuốc lá cho học sinh"),
  CarItem(2, "Hội thảo trực tuyến phòng ngừa thuốc lá cho học sinh"),
  CarItem(1, "Hội thảo trực tuyến phòng ngừa thuốc lá cho học sinh"),
  CarItem(1, "Hội thảo trực tuyến phòng ngừa thuốc lá cho học sinh"),
];
