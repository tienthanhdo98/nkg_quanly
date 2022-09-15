import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkg_quanly/ui/menu/MenuController.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../const.dart';
import '../../const/ultils.dart';
import '../../model/misstion/mission_model.dart';
import '../../viewmodel/home_viewmodel.dart';
import '../document_nonapproved/document_nonapproved_list.dart';
import 'misstion_search.dart';

class MissionList extends GetView {
  final String? header;
  final DateTime dateNow = DateTime.now();
  final MenuController menuController = Get.put(MenuController());
  final homeController = Get.put(HomeViewModel());
  final int selectedButton = 0;
  MissionList({this.header});

  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: FutureBuilder(
        future: homeController.getMissionModel(),
        builder: (context, AsyncSnapshot<MissionModel> snapshot) {
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
                            Get.to(() => MissionSearch(
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
                                // Get.to(() => DocumentnonapprovedDetail(
                                //     id: snapshot.data!.items![index].id!));
                              },
                              child:
                              MissionListItem(index, snapshot.data!.items![index]));
                        })),
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

class MissionListItem extends StatelessWidget {
  MissionListItem(this.index, this.docModel);

  final int? index;
  final MisstionItem? docModel;

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
            height: 70,
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
                    const Text('Người xử lý',style: CustomTextStyle.secondTextStyle),
                    Text(docModel!.organizationName!)
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Thời hạn',style: CustomTextStyle.secondTextStyle),
                    Text(formatDate(docModel!.deadline!))
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Ngày xử lý',style: CustomTextStyle.secondTextStyle),
                    Text(formatDate(docModel!.processingDate!))
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
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: Row(
              children: [
                const Text(
                  'Tất cả văn bản đến chưa bút phê',
                  style: TextStyle(color: kVioletButton,fontWeight: FontWeight.bold),
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
                itemCount: listFilter.length,
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
                        primary: kWhite,//change background color of button
                        onPrimary: kBlueButton,//change text color of button
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                            side: const BorderSide(
                                color: kVioletButton)
                        ),
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

Widget priorityWidget(MisstionItem docModel) {
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

Widget signWidget(MisstionItem docModel) {
  if (docModel.status == "Hoàn thành") {
    return Row(
      children: [
        Image.asset(
          'assets/icons/ic_sign.png',
          height: 14,
          width: 14,
        ),
        const Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
        Text(
          docModel.status!,
          style: TextStyle(color: kGreenSign),
        )
      ],
    );
  } else if (docModel.status == "Chưa hoàn thành") {
    return Row(
      children: [
        Image.asset(
          'assets/icons/ic_not_sign.png',
          height: 14,
          width: 14,
        ),
        const Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
        Text( docModel.status!, style: TextStyle(color: kOrangeSign))
      ],
    );
  }
  else if (docModel.status == "Quá hạn") {
    return Row(
      children: [
        Image.asset(
          'assets/icons/ic_cancel_red.png',
          height: 14,
          width: 14,
        ),
        const Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
         Text(docModel.status!, style: TextStyle(color: kRedPriority))
      ],
    );
  }
  else {
    return Row(
      children: [
        Image.asset(
          'assets/icons/ic_still.png',
          height: 14,
          width: 14,
        ),
        const Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
         Text(docModel.status!, style: TextStyle(color: Colors.black))
      ],
    );
  }

}


