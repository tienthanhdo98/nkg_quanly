import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nkg_quanly/const/utils.dart';
import 'package:nkg_quanly/ui/document_nonapproved/document_nonapproved_screen.dart';
import 'package:nkg_quanly/ui/profile/profile_screen.dart';
import 'package:nkg_quanly/ui/report/report_screen.dart';

import '../../const/const.dart';
import '../../model/MenuByUserModel.dart';
import '../../viewmodel/home_viewmodel.dart';
import '../PMis/PMis_screen.dart';
import '../analysis_report/analysis_report_menu.dart';
import '../birthday/birthday_screen.dart';
import '../book_room_meet/book_meeting_screen.dart';
import '../calendarwork/e_office/calendar_work_e_office_screen.dart';
import '../document_out/document_out_list.dart';
import '../document_unprocess/document_unprocess _screen.dart';
import '../helpdesk/help_desk_screen.dart';
import '../mission/mission_screen.dart';
import '../profile_procedure_/profile_procedure_home/profile_procedure_menu_screen.dart';
import '../profile_procedure_/profiles_procedure_screen.dart';
import '../report/report_in_menuhome/report_in_menuhome_list.dart';
import '../utility/utility_screen.dart';
import '../workbook/workbook_list.dart';
import 'list_all_item_e_office.dart';
import 'list_all_item_kgs.dart';

class HomeScreen extends GetView {
  //HomeViewModel homeController = Get.find();
  final homeController = Get.put(HomeViewModel());
  @override
  Widget build(BuildContext context) {
    homeController.getInitDataHomeScreen();
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
            child: Text('Menu chức năng',
                style: Theme.of(context).textTheme.headline2),
          ),
          SizedBox(
            child: Obx(() => GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 0.9,
              ),
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              // Generate 100 widgets that display their index in the List.
              itemCount: homeController.rxListMenuByUserRole.length,
              itemBuilder: (BuildContext context, int index){
                var item = homeController.rxListMenuByUserRole[index];
                return  InkWell(
                  onTap: () {
                    print(item.childrens!.length);
                    toMenuScreenById(item.id!,item.childrens!);
                  },
                  child: Column(
                    children: [
                      getIconMenuWidget(item,index),
                      Flexible(
                        child: Text(
                          item.name!,
                          style: const TextStyle(fontSize: 12),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                );
              },
            )),
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
                              'Hôm nay\n${homeController.rxWeatherModel.value.temperature?.toStringAsFixed(1)}°',
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
                            ) : const SizedBox.shrink()),
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

void toMenuScreenById(String id,List<Childrens> listChildren)
{
  var type = listMenuHome.firstWhereOrNull((element) => element.id! == id)?.type!;
  var img =  listMenuHome.firstWhereOrNull((element) => element.id! == id)?.img!;
  var title =  listMenuHome.firstWhereOrNull((element) => element.id! == id)?.title!;
  menuToScreen(
      type!, title, img,listChildren);
}

Widget getIconMenuWidget(MenuByUserModel menuItem,int index)
{
  if (listMenuHome.firstWhereOrNull((element) => element.id! == menuItem.id!) != null)
  {
    return Image.asset(
      listMenuHome.firstWhereOrNull((element) => element.id! == menuItem.id!)!.img!,
      width: 50,
      height: 50,
      fit: BoxFit
          .cover,
    );
  }
  else
  {
    return CachedNetworkImage(
      width: 50,
      height: 50,
      imageUrl:
      "http://123.31.31.237:8001/${menuItem.icon ?? ""}",
      imageBuilder:
          (context,
          imageProvider) =>
          Container(
            decoration:
            BoxDecoration(
              image: DecorationImage(
                  image:
                  imageProvider,
                  fit: BoxFit
                      .cover),
            ),
          ),
      // placeholder: (context, url) => const CircularProgressIndicator(),
      errorWidget: (context,
          url,
          error) =>
      const Icon(
          Icons
              .error),
    );
  }
}

class MenuListItem {
  String? title;
  String? img;
  String? url;
  int? type;
  String? id;

  MenuListItem(this.title, this.img, this.url, this.type,this.id);
}

List<MenuListItem> listMenuHome = [
  MenuListItem('Không gian số', 'assets/icons/ic_kgs.png', "", 1,"4dc309c9-4091-4032-c2a9-08da96fb114d"),
  MenuListItem('Hệ thống E-office', 'assets/icons/ic_eoffice.png', "", 2,"097cf497-b374-47ee-957f-08da97870319"),
  MenuListItem('Dịch vụ công', 'assets/icons/ic_dichvucong.png', "", 5,"c7101788-690f-43df-d4dd-08da9ad94c09"),
  MenuListItem('Báo cáo bộ', 'assets/icons/ic_report_bo.png', "", 7,"faabab32-2a15-490c-6aaf-08da9ad96ea2"),
  MenuListItem('Thông tin nhân sự', 'assets/icons/ic_pmis.png', "", 3,"258fda3e-669a-4134-540c-08da9b7bdabe"),
  MenuListItem('Phân tích hiển thị chỉ số', 'assets/icons/ic_phantich.png', "", 6,"f277e743-cd4b-408b-5400-08da9b7bdabe"),
  MenuListItem('Tiện ích', 'assets/icons/ic_tienich.png', "", 8,"84849e1f-e7fa-4654-540e-08da9b7bdabe"),
  MenuListItem('Helpdesk', 'assets/icons/ic_helpdesk.png', "", 4,"a12b42dd-b971-4e31-ac13-08da9bb8bee8"),

  MenuListItem('Lịch làm việc', 'assets/icons/ic_job.png', "", 1,
      "e001e3de-0cdf-4e9a-9580-08da97870319"),
  MenuListItem('Văn bản đến', 'assets/icons/ic_doc_in.png', "", 2,
      "c58d8dd8-74d2-4abe-9581-08da97870319"),
  MenuListItem('Hồ sơ trình', 'assets/icons/ic_doc_doc.png', "", 3,
      "d49797df-e9b1-42ba-9582-08da97870319"),
  MenuListItem('Hồ sơ công việc', 'assets/icons/ic_hoso_cv.png', "", 4,
      "a0166eea-e9ed-468c-9583-08da97870319"),
  MenuListItem('Bố trí phòng họp', 'assets/icons/ic_meeting.png', "", 5,
      "908e233d-013d-4351-9584-08da97870319"),
  MenuListItem('Bố trí và điều động xe ô tô', 'assets/icons/ic_booking_car.png',
      "", 6, "90e22b1b-a263-441b-9585-08da97870319"),
  MenuListItem('Nhiệm vụ', 'assets/icons/ic_mission.png', "", 7,
      "2451f554-c887-4874-9586-08da97870319"),
];

void toScreen(int type, String? header, String? icon) {
  switch (type) {
    case 1:
      Get.to(() => CalendarWorkEOfficeScreen());
      break;
    case 2:
      Get.to(() => ReportScreen(

          ));
      break;
    case 3:
      Get.to(() => DocumentUnProcessScreen(

          ));
      break;
    case 4:
      Get.to(() => DocumentNonApprovedScreen(

          ));
      break;
    case 5:
      Get.to(() => DocumentOutList());
      break;
    case 6:
      Get.to(() => ProfileScreen(
          ));
      break;
    case 7:
      Get.to(() => BookMeetingScreen(
          ));
      break;
    case 8:
      Get.to(() => MissionScreen(
          ));
      break;
    case 9:
      Get.to(() => BirthDayScreen(
          ));
      break;

    case 10:
      Get.to(() => ProfilesProcedureScreen(
          ));
      break;
    case 11:
      Get.to(() => WorkBookList());
      break;

  }
}

void menuToScreen(int type, String? header, String? icon, List<Childrens> listChildren) {
  switch (type) {
    case 1:
      Get.to(() => const ListAllItemKGS());
      break;
    case 2:
      Get.to(() => ListAllItemEOffice(listChildren: listChildren,));
      break;
      case 3:
      Get.to(() => PMisScreen());
      break;
      case 4:
      Get.to(() => HelpDeskScreen(header: header,icon : icon));
      break;
      case 5:
      Get.to(() => ProfileProcMenuScreen(listChildren: listChildren));
      break;
      case 6:
      Get.to(() => AnalysisReportMenu(listChildren: listChildren));
      break;
      case 7:
      Get.to(() =>  ReportInMenuHomeList());
      break;
      case 8:
      Get.to(() => UtilityScreen(listChildren: listChildren));
      break;
  }
}


