import 'package:flutter/material.dart';

import '../../const/const.dart';
import '../../const/utils.dart';
import '../../model/MenuByUserModel.dart';
import '../home/home_screen.dart';
import '../workbook/workbook_list.dart';
import 'group_contacts/group_contacts_list.dart';
import 'group_workbook/group_workbook_list.dart';
import 'guideline/guildline_list.dart';
import 'individual_contacts/individual_contacts_list.dart';
import 'lunar_calendar_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UtilityScreen extends StatelessWidget {
  const UtilityScreen({Key? key, required this.listChildren}) : super(key: key);
  final List<Childrens> listChildren;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          headerWidget("Tiện ích", context),
          SizedBox(
            child: GridView.count(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              // Create a grid with 2 columns. If you change the scrollDirection to
              // horizontal, this produces 2 rows.
              crossAxisCount: 4,
              childAspectRatio: 0.9,
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              // Generate 100 widgets that display their index in the List.
              children: List.generate(listChildren.length, (index) {
                return InkWell(
                  onTap: () {
                    toUitilityScreenById(listChildren[index].id!, listChildren[index].menuPermissions!);
                  },
                  child: Column(
                    children: [
                      getIconUitilityScreenWidget(listChildren[index], index),
                      Flexible(
                        child: Text(
                          listChildren[index].title!,
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
        ],
      )),
    );
  }
}


void toUitilityScreenById(String id,  List<MenuPermissions> listMenuPermissions) {
  var type = listUtility.firstWhereOrNull((element) => element.id! == id)?.type!;
  var img = listUtility.firstWhereOrNull((element) => element.id! == id)?.img!;
  var title = listUtility.firstWhereOrNull((element) => element.id! == id)?.title!;
  toUitilityScreen(type!, title, img, listMenuPermissions);
}

Widget getIconUitilityScreenWidget(Childrens menuItem, int index) {
  if (listUtility.firstWhereOrNull((element) => element.id! == menuItem.id!) !=
      null) {
    return Image.asset(
      listUtility
          .firstWhereOrNull((element) => element.id! == menuItem.id!)!
          .img!,
      width: 50,
      height: 50,
      fit: BoxFit.cover,
    );
  } else {
    String icon = "http://123.31.31.237:8001/${menuItem.iconPath ?? ""}";
    if (icon.contains(".svg")) {
      return CachedNetworkImage(
        width: 50,
        height: 50,
        imageUrl: "http://123.31.31.237:8001/${menuItem.icon ?? ""}",
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          ),
        ),
        // placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      );
    } else {
      return SvgPicture.network(
        icon,
        width: 50,
        height: 50,
        fit: BoxFit.cover,
      );
    }
  }
}

void toUitilityScreen(int type, String? header, String? icon, List<MenuPermissions> listMenuPermissions) {
  switch (type) {
    case 1:
      Get.to(() => LunarCalendarScreen());
      break;
    case 2:
      Get.to(() => GuidelineList());
      break;
    case 3:
      Get.to(() => GroupContactsList(listMenuPermissions: listMenuPermissions));
      break;
    case 4:
      Get.to(() => IndividualContactsList());
      break;
    case 5:
      Get.to(() => WorkBookList(listMenuPermissions: listMenuPermissions));
      break;
    case 6:
      Get.to(() => GroupWorkBookList());
      break;
  }
}

List<MenuListItem> listUtility = [
  MenuListItem('Lịch âm', 'assets/icons/ic_lunar_cal.png', "", 1, "1bd2d42f-f1d0-4251-6677-08da9bacfaac"),
  MenuListItem('Hướng dẫn sử dụng', 'assets/icons/ic_hdsd.png', "", 2,"12eb578a-d004-455a-540f-08da9b7bdabe"),
  MenuListItem(
      'Quản lý DBĐT tổ chức', 'assets/icons/ic_dbdt_tochuc.png', "", 3,"71362e11-9614-4276-ac11-08da9bb8bee8"),
  MenuListItem(
      'Quản lý DBĐT cá nhân', 'assets/icons/ic_dbdt_canhan.png', "", 4,
      "cb90574e-3568-468f-84ab-08da9f9ff797"),
  MenuListItem(
      'Quản lý sổ tay công việc', 'assets/icons/ic_ql_sotay.png', "", 5,"b2a7b093-b233-458f-ac14-08da9bb8bee8"),
  MenuListItem(
      'Quản lý nhóm sổ tay CV', 'assets/icons/ic_ql_nhomcv.png', "", 6,"bad3efae-1cc6-40ca-8655-08da9d04724c"),
];
