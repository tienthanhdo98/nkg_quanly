import 'package:flutter/material.dart';
import 'package:nkg_quanly/const/utils.dart';
import 'package:nkg_quanly/ui/calendarwork/calendar_work_screen.dart';
import 'package:nkg_quanly/ui/document_nonapproved/document_nonapproved_screen.dart';
import 'package:nkg_quanly/ui/profile/profile_screen.dart';
import 'package:nkg_quanly/ui/report/report_screen.dart';
import '../../const/const.dart';
import '../../const/widget.dart';
import '../../viewmodel/home_viewmodel.dart';
import '../PMis/PMis_screen.dart';
import '../birthday/birthday_screen.dart';
import '../book_room_meet/book_meeting_screen.dart';
import '../book_room_meet/e_office/book_room_e_office_list.dart';
import '../booking_car/e_office/booking_car_e_office_list.dart';
import '../calendarwork/e_office/calendar_work_e_office_screen.dart';
import '../document_out/document_out_list.dart';
import '../document_unprocess/document_unprocess _screen.dart';
import '../document_unprocess/e_office/document_in_e_office_list.dart';
import '../helpdesk/help_desk_screen.dart';
import '../mission/e_office/mission__e_office_list.dart';
import '../mission/mission_screen.dart';
import '../profile/e_office/profile_e_office_list.dart';
import '../profile_procedure_/profile_procedure_home/profile_procedure_menu_screen.dart';
import '../profile_procedure_/profiles_procedure_screen.dart';
import '../profile_work/e_office/profile_work_e_office_list.dart';
import '../profile_work/profile_work_screen.dart';
import '../report/report_in_menuhome/report_in_menuhome_list.dart';
import '../utility/utility_screen.dart';
import '../workbook/workbook_list.dart';
import 'list_all_item_e_office.dart';
import 'list_all_item_kgs.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeScreen extends GetView {
  final homeController = Get.put(HomeViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(children: [
              Image.asset("assets/bgtophome.png"),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
                child: Row(
                  children: [
                    Container(
                        child: const Icon(Icons.person),
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: kViolet,
                          borderRadius: BorderRadius.circular(25),
                        )),
                    const Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Xin chào",
                            style: TextStyle(color: kWhite),
                          ),
                          Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 0)),
                          Text(
                            "dev_dev",
                            style: TextStyle(color: kWhite, fontSize: 24),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: kPink,
                        border: Border.all(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Image.asset('assets/icons/ic_search_white.png',
                          width: 20, height: 20),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 140, 20, 0),
                child: border(
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 15, 5, 15),
                                child: Text(
                                  'Thông báo khẩn',
                                  style: Theme.of(context).textTheme.headline3,
                                )),
                            Image.asset(
                              'assets/icons/ic_speaker.png',
                              width: 24,
                              height: 24,
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 40),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/anhdemo.png',
                                width: 150,
                                height: 100,
                              ),
                              Flexible(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: Text(
                                    'Nam Định, Bình Dương nằm top 3 cao nhất điểm môn Toán tốt nghiệp THPT',
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    context),
              )
            ]),
            //

            //
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text('Menu chức năng',
                  style: Theme.of(context).textTheme.headline2),
            ),
            SizedBox(
              child: GridView.count(
                physics: const BouncingScrollPhysics(),
                // Create a grid with 2 columns. If you change the scrollDirection to
                // horizontal, this produces 2 rows.
                crossAxisCount: 4,
                shrinkWrap: true,
                mainAxisSpacing: 15,
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                // Generate 100 widgets that display their index in the List.
                children: List.generate(listMenuHome.length, (index) {
                  MenuItem item = listMenuHome[index];
                  return InkWell(
                    onTap: () {
                      menuToScreen(item.type!, item.title, item.img);
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          item.img!,
                          width: 50,
                          height: 50,
                        ),
                        Flexible(
                          child: Text(
                            item.title!,
                            style: const TextStyle(fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  );
                }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 20),
              child: Container(
                height: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                    image: AssetImage("assets/bg_weather.png"),
                    fit: BoxFit.cover,
                  ),
                ),

                child: Row(children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            convertDateToViDate(),
                            style: const TextStyle(
                                color: kWhite,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                          const Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                          Text(formatDateToStringtype2(dateNow),
                              style: const TextStyle(
                                  color: kWhite,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600))
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 35, 15, 0),
                    child: Obx(() => Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                                'Hôm nay\n${homeController.rxWeatherModel.value.temperature?.toStringAsFixed(1)}°',
                                style: const TextStyle(
                                    color: kWhite,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500)),
                            SizedBox(
                              height:80,
                              width: 80,
                              child: CachedNetworkImage(
                                  imageUrl: (homeController.rxWeatherModel.value.linkIcon != null) ? homeController.rxWeatherModel.value.linkIcon! : "",
                                  imageBuilder: (context, imageProvider) => Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.fill

                                      ),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) => Image.asset("assets/default.webp")
                              ),
                            ),


                          ],
                        )),
                  ),

                ]) /* add child content here */,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MenuItem {
  String? title;
  String? img;
  String? url;
  int? type;

  MenuItem(this.title, this.img, this.url, this.type);
}

class MenuHomeItem {
  String? title;
  String? img;
  String? url;
  int? type;

  MenuHomeItem(this.title, this.img, this.url, this.type);
}

List<MenuItem> listMenuHome = [
  MenuItem('Không gian số', 'assets/icons/ic_kgs.png', "", 1),
  MenuItem('Hệ thống E-Office', 'assets/icons/ic_eoffice.png', "", 2),
  MenuItem('Hệ thống PMis', 'assets/icons/ic_pmis.png', "", 3),
  MenuItem('Helpdesk', 'assets/icons/ic_helpdesk.png', "", 4),
  MenuItem('Dịch vụ công hành chính', 'assets/icons/ic_dichvucong.png', "", 5),
  MenuItem('Phân tích hiển thị số', 'assets/icons/ic_phantich.png', "", 6),
  MenuItem('Báo cáo bộ', 'assets/icons/ic_report_bo.png', "", 7),
  MenuItem('Tiện ích', 'assets/icons/ic_tienich.png', "", 8),
];

List<MenuItem> list = [
  MenuItem('Lịch làm việc', 'assets/icons/ic_job.png', "", 1),
  MenuItem('Báo cáo', 'assets/icons/ic_report.png', "", 2),
  MenuItem('Văn bản đến chưa xử lý', 'assets/icons/ic_doc.png', "", 3),
  MenuItem('Văn bản đến chưa bút phê', 'assets/icons/ic_doc_sign.png', "", 4),
  MenuItem('Văn bản đi chờ phát hành', 'assets/icons/ic_doc_push.png', "", 5),
  MenuItem('Hồ sơ trình', 'assets/icons/ic_doc_doc.png', "", 6),
  MenuItem('Lịch họp', 'assets/icons/ic_meet.png', "", 7),
  MenuItem('Nhiệm vụ', 'assets/icons/ic_mission.png', "", 8),
  MenuItem('Sinh nhật', 'assets/icons/ic_birthday.png', "", 9),
  MenuItem('Thủ tục hành chính', 'assets/icons/ic_thutuc_hanhchinh.png', "", 10),
  MenuItem('Sổ tay Công việc', 'assets/icons/ic_sotay.png', "", 11),
];
List<MenuItem> listEOffice = [
  MenuItem('Lịch làm việc', 'assets/icons/ic_job.png', "", 1),
  MenuItem('Văn bản đến', 'assets/icons/ic_doc_in.png', "", 2),
  MenuItem('Hồ sơ trình', 'assets/icons/ic_doc_doc.png', "", 3),
  MenuItem('Hồ sơ công việc', 'assets/icons/ic_hoso_cv.png', "", 4),
  MenuItem('Bố trí phòng họp', 'assets/icons/ic_meeting.png', "", 5),
  MenuItem('Bố trí và điều động xe ô tô', 'assets/icons/ic_booking_car.png', "", 6),
  MenuItem('Nhiệm vụ', 'assets/icons/ic_mission.png', "", 7),
];

// List<MenuItem> list2 = [
//   MenuItem('Sinh nhật', 'assets/icons/ic_birthday.png', "", 9),
//   MenuItem('Văn bản đến', 'assets/icons/ic_doc_in.png', "", 10),
//   MenuItem('Đặt lịch phòng họp', 'assets/icons/ic_meeting.png', "", 11),
//   MenuItem('Điều động bố trí ô tô', 'assets/icons/ic_car.png', "", 12),
//   MenuItem('Hồ sơ công việc', 'assets/icons/ic_hoso_cv.png', "", 13),
//   MenuItem('Thủ tục hành chính', 'assets/icons/ic_thutuc_hanhchinh.png', "", 14),
//   MenuItem('Sổ tay Công việc', 'assets/icons/ic_sotay.png', "", 15),
//   MenuItem('Báo cáo', 'assets/icons/ic_report2.png', "", 16),
// ];

void toScreen(int type, String? header, String? icon) {
  switch (type) {
    case 1:
      Get.to(() => CalendarWorkScreen());
      break;
    case 2:
      Get.to(() => ReportScreen(
            header: header,
            icon: icon,
          ));
      break;
    case 3:
      Get.to(() => DocumentUnProcessScreen(
            header: header,
            icon: icon,
          ));
      break;
    case 4:
      Get.to(() => DocumentNonApprovedScreen(
            header: header,
            icon: icon,
          ));
      break;
    case 5:
      Get.to(() => DocumentOutList(header: header));
      break;
    case 6:
      Get.to(() => ProfileScreen(
            header: header,
            icon: icon,
          ));
      break;
    case 7:
      Get.to(() => BookMeetingScreen(
            header: header,
            icon: icon,
          ));
      break;
    case 8:
      Get.to(() => MissionScreen(
            header: header,
            icon: icon,
          ));
      break;
    case 9:
      Get.to(() => BirthDayScreen(
            header: header,
            icon: icon,
          ));
      break;
      break;
    case 16:
      Get.to(() => BookMeetingScreen(
            header: header,
            icon: icon,
          ));
      break;
    case 13:
      Get.to(() => ProfileWorkScreen(
            header: header,
            icon: icon,
          ));
      break;
    case 10:
      Get.to(() => ProfilesProcedureScreen(
            header: header,
            icon: icon,
          ));
      break;
    case 11:
      Get.to(() => WorkBookList(header: header));
      break;
    // case 16:
    //   Get.to(() => ReportScreen(
    //         header: header,
    //         icon: icon,
    //       ));
    //   break;
  }
}

void menuToScreen(int type, String? header, String? icon) {
  switch (type) {
    case 1:
      Get.to(() => const ListAllItemKGS());
      break;
    case 2:
      Get.to(() => const ListAllItemEOffice());
      break;
      case 3:
      Get.to(() => PMisScreen(header: header));
      break;
      case 4:
      Get.to(() => HelpDeskScreen(header: header,icon : icon));
      break;
      case 5:
      Get.to(() => ProfileProcMenuScreen());
      break;
      case 7:
      Get.to(() =>  ReportInMenuHomeList(header: header));
      break;
      case 8:
      Get.to(() => const UtilityScreen());
      break;
  }
}

void toScreenEoffice(int type, String? header, String? icon) {
  switch (type) {
    case 6:
      Get.to(() => BookingEOfficeCarList(
            header: header,
          ));
      break;
    case 1:
      Get.to(() => CalendarWorkEOfficeScreen());
      break;
    case 2:
      Get.to(() => DocumentInEOfficeList(header: header));
      break;
    case 3:
      Get.to(() => ProfileEOfficeList(
            header: header,
          ));
      break;
    case 4:
      Get.to(() => ProfileWorkEOfficeList(
            header: header,
          ));
      break;
    case 5:
      Get.to(() => BookRoomEOfficeList(
            header: header,
          ));
      break;
    case 7:
      Get.to(() => MissionEOfficeList(
            header: header,
          ));
      break;
  }
}
