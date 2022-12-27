import 'package:flutter/material.dart';
import 'package:nkg_quanly/ui/profile_procedure_/profile_procedure_home/profile_proc_report/profile_proc_report_screen.dart';
import 'package:nkg_quanly/ui/profile_procedure_/profile_procedure_home/profiles_procedure_list_withstatistic.dart';

import '../../../const/const.dart';
import '../../../const/utils.dart';
import '../../../const/widget.dart';
import '../../../model/MenuByUserModel.dart';
import '../../home/home_screen.dart';

class ProfileProcMenuScreen extends StatelessWidget {
  const ProfileProcMenuScreen({Key? key, required this.listChildren}) : super(key: key);
  final List<Childrens> listChildren;

  @override
  Widget build(BuildContext context) {
    listChildren.removeWhere((element) => element.id == "fb893cf2-df11-495a-e396-08da9d3dd945");
    return Scaffold(
      body: SafeArea(
          child: Column(
            children: [
              headerWidget("Dịch vụ công hành chính", context),
              SizedBox(
                child: GridView.count(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 4,
                  childAspectRatio: 0.9,
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  // Generate 100 widgets that display their index in the List.
                  children: List.generate(listChildren.length, (index) {
                    return InkWell(
                      onTap: () {
                        toUitilityScreen(listChildren[index].id!);
                      },
                      child: Column(
                        children: [
                          getIconScreenWidget(listUtility, listChildren[index], index),
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
          )
      ),
    );
  }
}

void toUitilityScreen(String id) {
  var type = listUtility.firstWhereOrNull((element) => element.id! == id)?.type!;
  switch (type) {
    case 1:
      Get.to(() => ProfilesProcedureListWithStatistic());
      break;
      case 2:
      Get.to(() => ProfileProcReportScreen());
      break;
  }
}

List<MenuListItem> listUtility = [
  MenuListItem('Hồ sơ hành chính', 'assets/icons/ic_lunar_cal.png', "", 1, "00628b59-be9a-4f0c-3bd5-08da9b727bd0"),
  MenuListItem('Thống kê hồ sơ', 'assets/icons/ic_hdsd.png', "", 2, "17e5dbb4-ef0d-497c-3bd6-08da9b727bd0"),
];
