import 'package:flutter/material.dart';
import 'package:nkg_quanly/const/const.dart';
import 'package:nkg_quanly/const/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../model/MenuByUserModel.dart';
import '../book_room_meet/e_office/book_room_e_office_list.dart';
import '../booking_car/e_office/booking_car_e_office_list.dart';
import '../calendarwork/e_office/calendar_work_e_office_screen.dart';
import '../document_unprocess/e_office/document_in_e_office_list.dart';
import '../mission/e_office/mission__e_office_list.dart';
import '../profile/e_office/profile_e_office_list.dart';
import '../profile_work/e_office/profile_work_e_office_list.dart';
import 'home_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ListAllItemEOffice extends StatelessWidget {
  const ListAllItemEOffice({Key? key, required this.listChildren}) : super(key: key);
  final List<Childrens> listChildren;

  @override
  Widget build(BuildContext context) {
    listChildren.removeWhere(
        (element) => element.id == "37869c39-4d28-482c-53ff-08da9b7bdabe");
    listChildren.forEach((element) {
      print("http://123.31.31.237:8001/${element.iconPath ?? ""}");
    });

    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          headerWidget("Hệ thống E_Office", context),
          SizedBox(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 0.9,
              ),
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              // Generate 100 widgets that display their index in the List.
              itemCount: listChildren.length,
              itemBuilder: (BuildContext context, int index) {
                var item = listChildren[index];
                return InkWell(
                  onTap: () {
                    toEofficeScreenById(item.id!);
                  },
                  child: Column(
                    children: [
                      getIconEofficeWidget(item, index),
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
            ),
          ),
        ],
      )),
    );
  }
}

void toEofficeScreenById(String id) {
  var type =
      listEOffice.firstWhereOrNull((element) => element.id! == id)?.type!;
  var img = listEOffice.firstWhereOrNull((element) => element.id! == id)?.img!;
  var title =
      listEOffice.firstWhereOrNull((element) => element.id! == id)?.title!;
  toScreenEoffice(type!, title, img);
}

Widget getIconEofficeWidget(Childrens menuItem, int index) {
  if (listEOffice.firstWhereOrNull((element) => element.id! == menuItem.id!) != null) {
    return Image.asset(
      listEOffice.firstWhereOrNull((element) => element.id! == menuItem.id!)!.img!,
      width: 50,
      height: 50,
      fit: BoxFit.cover,
    );
  } else {
    String icon = "http://123.31.31.237:8001/${menuItem.iconPath ?? ""}";
    if (icon.contains(".svg")) {
      return SvgPicture.network(
        icon,
        width: 50,
        height: 50,
        fit: BoxFit.cover,
      );
    } else {
      return CachedNetworkImage(
        width: 50,
        height: 50,
        imageUrl: icon,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          ),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      );
    }
  }
}

List<MenuListItem> listEOffice = [
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

void toScreenEoffice(int type, String? header, String? icon) {
  switch (type) {
    case 6:
      Get.to(() => BookingEOfficeCarList());
      break;
    case 1:
      Get.to(() => CalendarWorkEOfficeScreen());
      break;
    case 2:
      Get.to(() => DocumentInEOfficeList(header: header));
      break;
    case 3:
      Get.to(() => ProfileEOfficeList());
      break;
    case 4:
      Get.to(() => ProfileWorkEOfficeList(
            header: header,
          ));
      break;
    case 5:
      Get.to(() => BookRoomEOfficeList());
      break;
    case 7:
      Get.to(() => MissionEOfficeList());
      break;
  }
}
