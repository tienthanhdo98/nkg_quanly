import 'package:flutter/material.dart';

import '../../const/const.dart';
import '../../const/utils.dart';
import '../home/home_screen.dart';
import '../workbook/workbook_list.dart';
import 'group_contacts/group_contacts_list.dart';
import 'group_workbook/group_workbook_list.dart';
import 'guideline/guildline_list.dart';
import 'individual_contacts/individual_contacts_list.dart';
import 'lunar_calendar_screen.dart';

class UtilityScreen extends StatelessWidget {
  const UtilityScreen({Key? key}) : super(key: key);

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
              children: List.generate(listUtility.length, (index) {
                return InkWell(
                  onTap: () {
                    toUitilityScreen(listUtility[index].type!,
                        listUtility[index].title, listUtility[index].img);
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        listUtility[index].img!,
                        width: 50,
                        height: 50,
                      ),
                      Flexible(
                        child: Text(
                          listUtility[index].title!,
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

void toUitilityScreen(int type, String? header, String? icon) {
  switch (type) {
    case 1:
      Get.to(() => LunarCalendarScreen());
      break;
    case 2:
      Get.to(() => GuidelineList());
      break;
    case 3:
      Get.to(() => GroupContactsList());
      break;
    case 4:
      Get.to(() => IndividualContactsList());
      break;
    case 5:
      Get.to(() => WorkBookList());
      break;
    case 6:
      Get.to(() => GroupWorkBookList());
      break;
  }
}

List<MenuListItem> listUtility = [
  MenuListItem('Lịch âm', 'assets/icons/ic_lunar_cal.png', "", 1),
  MenuListItem('Hướng dẫn sử dụng', 'assets/icons/ic_hdsd.png', "", 2),
  MenuListItem(
      'Quản lý DBĐT tổ chức', 'assets/icons/ic_dbdt_tochuc.png', "", 3),
  MenuListItem(
      'Quản lý DBĐT cá nhân', 'assets/icons/ic_dbdt_canhan.png', "", 4),
  MenuListItem(
      'Quản lý sổ tay công việc', 'assets/icons/ic_ql_sotay.png', "", 5),
  MenuListItem(
      'Quản lý sổ tay nhóm CV', 'assets/icons/ic_ql_nhomcv.png', "", 6),
];
