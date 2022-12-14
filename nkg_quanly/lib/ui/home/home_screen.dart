import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nkg_quanly/const/utils.dart';
import 'package:nkg_quanly/ui/calendarwork/calendar_work_screen.dart';
import 'package:nkg_quanly/ui/document_nonapproved/document_nonapproved_screen.dart';
import 'package:nkg_quanly/ui/profile/profile_screen.dart';
import 'package:nkg_quanly/ui/report/report_screen.dart';

import '../../const/const.dart';
import '../../viewmodel/home_viewmodel.dart';
import '../PMis/PMis_screen.dart';
import '../analysis_report/analysis_report_menu.dart';
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
import '../report/report_in_menuhome/report_in_menuhome_list.dart';
import '../utility/utility_screen.dart';
import '../workbook/workbook_list.dart';
import 'list_all_item_e_office.dart';
import 'list_all_item_kgs.dart';

class HomeScreen extends GetView {
  final homeController = Get.put(HomeViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                border: Border(
                    bottom: BorderSide(
                      width: 1,
                      color: Theme.of(context).dividerColor,
                    ))),
            width: double.infinity,
            height: 80,

            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Image.asset(
                  "assets/logo.png",
                  width: 200,
                  height: 150,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text('Menu ch???c n??ng',
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
                var item = listMenuHome[index];
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
          const Spacer(),
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
                              'H??m nay\n${homeController.rxWeatherModel.value.temperature?.toStringAsFixed(1)}??',
                              style: const TextStyle(
                                  color: kWhite,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500)),
                          SizedBox(
                            height:80,
                            width: 80,
                            child:Obx(() => (homeController.rxWeatherModel.value.linkIcon != null) ? CachedNetworkImage(
                                imageUrl:  homeController.rxWeatherModel.value.linkIcon!,
                                imageBuilder: (context, imageProvider) => Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.fill

                                    ),
                                  ),
                                ),
                            ) : SizedBox.shrink()),
                          ),


                        ],
                      )),
                ),

              ]) /* add child content here */,
            ),
          )
        ],
      ),
    );
  }
}



class MenuListItem {
  String? title;
  String? img;
  String? url;
  int? type;

  MenuListItem(this.title, this.img, this.url, this.type);
}

List<MenuListItem> listMenuHome = [
  MenuListItem('Kh??ng gian s???', 'assets/icons/ic_kgs.png', "", 1),
  MenuListItem('H??? th???ng E-Office', 'assets/icons/ic_eoffice.png', "", 2),
  MenuListItem('D???ch v??? c??ng', 'assets/icons/ic_dichvucong.png', "", 5),
  MenuListItem('B??o c??o b???', 'assets/icons/ic_report_bo.png', "", 7),
  MenuListItem('Th??ng tin nh??n s???', 'assets/icons/ic_pmis.png', "", 3),
  MenuListItem('Ph??n t??ch hi???n th??? ch??? s???', 'assets/icons/ic_phantich.png', "", 6),
  MenuListItem('Ti???n ??ch', 'assets/icons/ic_tienich.png', "", 8),
  MenuListItem('Helpdesk', 'assets/icons/ic_helpdesk.png', "", 4),
];

List<MenuListItem> list = [
  MenuListItem('L???ch l??m vi???c', 'assets/icons/ic_job.png', "", 1),
  MenuListItem('B??o c??o', 'assets/icons/ic_report.png', "", 2),
  MenuListItem('V??n b???n ?????n ch??a x??? l??', 'assets/icons/ic_doc.png', "", 3),
  MenuListItem('V??n b???n ?????n ch??a b??t ph??', 'assets/icons/ic_doc_sign.png', "", 4),
  MenuListItem('V??n b???n ??i ch??? ph??t h??nh', 'assets/icons/ic_doc_push.png', "", 5),
  MenuListItem('H??? s?? tr??nh', 'assets/icons/ic_doc_doc.png', "", 6),
  MenuListItem('L???ch h???p', 'assets/icons/ic_meet.png', "", 7),
  MenuListItem('Nhi???m v???', 'assets/icons/ic_mission.png', "", 8),
  MenuListItem('Sinh nh???t', 'assets/icons/ic_birthday.png', "", 9),
  MenuListItem('Th??? t???c h??nh ch??nh', 'assets/icons/ic_thutuc_hanhchinh.png', "", 10),
  MenuListItem('S??? tay c??ng vi???c', 'assets/icons/ic_sotay.png', "", 11),
];
List<MenuListItem> listEOffice = [
  MenuListItem('L???ch l??m vi???c', 'assets/icons/ic_job.png', "", 1),
  MenuListItem('V??n b???n ?????n', 'assets/icons/ic_doc_in.png', "", 2),
  MenuListItem('H??? s?? tr??nh', 'assets/icons/ic_doc_doc.png', "", 3),
  MenuListItem('H??? s?? c??ng vi???c', 'assets/icons/ic_hoso_cv.png', "", 4),
  MenuListItem('B??? tr?? ph??ng h???p', 'assets/icons/ic_meeting.png', "", 5),
  MenuListItem('B??? tr?? v?? ??i???u ?????ng xe ?? t??', 'assets/icons/ic_booking_car.png', "", 6),
  MenuListItem('Nhi???m v???', 'assets/icons/ic_mission.png', "", 7),
];

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
      Get.to(() => DocumentOutList());
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
          ));
      break;
    case 16:
      Get.to(() => BookMeetingScreen(
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
      Get.to(() => WorkBookList());
      break;

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
      Get.to(() => PMisScreen());
      break;
      case 4:
      Get.to(() => HelpDeskScreen(header: header,icon : icon));
      break;
      case 5:
      Get.to(() => ProfileProcMenuScreen());
      break;
      case 6:
      Get.to(() => AnalysisReportMenu());
      break;
      case 7:
      Get.to(() =>  ReportInMenuHomeList());
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

          ));
      break;
    case 4:
      Get.to(() => ProfileWorkEOfficeList(
            header: header,
          ));
      break;
    case 5:
      Get.to(() => BookRoomEOfficeList(
          ));
      break;
    case 7:
      Get.to(() => MissionEOfficeList(
          ));
      break;
  }
}
