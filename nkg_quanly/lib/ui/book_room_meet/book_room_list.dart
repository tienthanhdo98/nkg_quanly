
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkg_quanly/ui/book_room_meet/room_meeting_search.dart';
import 'package:nkg_quanly/ui/book_room_meet/room_meeting_viewmodel.dart';
import 'package:nkg_quanly/ui/menu/MenuController.dart';
import '../../const.dart';
import '../../const/ultils.dart';
import '../../model/meeting_room/meeting_room_model.dart';
import '../book_car/book_car_list.dart';
import 'meeting_room_detail.dart';

class BookRoomList extends GetView {
  String? header;
  DateTime dateNow = DateTime.now();
  final MenuController menuController = Get.put(MenuController());
  final roomMeetingViewModel = Get.put(RoomMeetingViewModel());
  int selectedButton = 0;

  BookRoomList({this.header});

  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            children: [
              //header
              headerWidgetSeatch(header!,RoomMeetingSearch(
                header: header,
              ),context),
              //date table
              Container(
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
                    Obx(() =>  TableCalendar(
                        locale: 'vi_VN',
                        headerVisible: false,
                        calendarFormat:  roomMeetingViewModel.rxCalendarFormat.value,
                        firstDay: DateTime.utc(2010, 10, 16),
                        lastDay: DateTime.utc(2030, 3, 14),
                        focusedDay: roomMeetingViewModel.rxSelectedDay.value,
                        selectedDayPredicate: (day) {
                          return isSameDay(
                              roomMeetingViewModel
                                  .rxSelectedDay.value,
                              day);
                        },
                        onDaySelected: (selectedDay, focusedDay) async {
                          if (!isSameDay(
                              roomMeetingViewModel
                                  .rxSelectedDay.value,
                              selectedDay)) {
                            roomMeetingViewModel.onSelectDay(selectedDay);
                          }
                        },
                        onFormatChanged: (format) {
                          if (roomMeetingViewModel.rxCalendarFormat.value != format) {
                            // Call `setState()` when updating calendar format
                            roomMeetingViewModel.rxCalendarFormat.value = format;
                          }
                        }
                    )),
                    Center(child: InkWell(
                      onTap: (){
                        if(roomMeetingViewModel.rxCalendarFormat.value != CalendarFormat.month)
                        {
                          roomMeetingViewModel.switchFormat(CalendarFormat.month);
                        }
                        else
                        {
                          roomMeetingViewModel.switchFormat(CalendarFormat.week);
                        }
                      },
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                          child: Image.asset("assets/icons/ic_showmore.png",height: 15,width: 80,)),
                    ))
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
                      'Tất cả phòng họp',
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
                                  child: Text("Danh sách phòng họp",
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
                          child: Obx(() => (roomMeetingViewModel.rxMeetingRoomItems.isNotEmpty) ?ListView.builder(
                              itemCount:roomMeetingViewModel.rxMeetingRoomItems.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                    onTap: () {
                                      Get.to(() => MeetingRoomDetail(
                                          id: roomMeetingViewModel.rxMeetingRoomItems[index].id!));
                                    },
                                    child: MeetingRoomItem(index, roomMeetingViewModel.rxMeetingRoomItems[index]));
                              }) : const Expanded(child: Text("Hôm nay không có lịch họp nào")))),
                      //bottom

                    ]),
                  )),
              Obx(() =>  Container(
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
                        onTap: () {
                          roomMeetingViewModel.rxSelectedDay.value = DateTime.now();
                          roomMeetingViewModel.onSelectDay(DateTime.now());
                          roomMeetingViewModel.swtichBottomButton(0);
                        },
                        child: Container(
                            decoration: (roomMeetingViewModel.selectedBottomButton.value == 0)
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
                                        color: (roomMeetingViewModel.selectedBottomButton.value  == 0)
                                            ? kBlueButton
                                            : Colors.black)))),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          DateTime datefrom =  DateTime.now();
                          DateTime dateTo =  datefrom.add(const Duration(days: 7));
                          String strdateFrom = formatDateToString(datefrom);
                          String strdateTo = formatDateToString(dateTo);
                          print(strdateFrom);
                          print(strdateTo);
                          roomMeetingViewModel.getMeetingRoomByWeek(strdateFrom,strdateTo);
                          roomMeetingViewModel.swtichBottomButton(1);
                        },
                        child: Container(
                            decoration: (roomMeetingViewModel.selectedBottomButton.value  == 1)
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
                                      color: (roomMeetingViewModel.selectedBottomButton.value  == 1)
                                          ? kBlueButton
                                          : Colors.black),
                                ))),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          roomMeetingViewModel.getMeetingRoomByMonth();
                          roomMeetingViewModel.swtichBottomButton(2);
                        },
                        child: Container(
                            decoration: (roomMeetingViewModel.selectedBottomButton.value  == 2)
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
                                        color: (roomMeetingViewModel.selectedBottomButton.value  == 2)
                                            ? kBlueButton
                                            : Colors.black)))),
                      ),
                    )
                  ],
                ),
              ))
            ],
          )),
    );
  }
}

class MeetingRoomItem extends StatelessWidget {
  MeetingRoomItem(this.index, this.docModel);

  int? index;
  MeetingRoomItems? docModel;

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
                     Text(docModel!.roomName!,
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
                    Text(docModel!.registerUser!)
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


Widget signWidget(MeetingRoomItems docModel) {
  if (docModel.registerUser!.isNotEmpty) {
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
