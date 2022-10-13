import 'package:flutter/material.dart';
import 'package:nkg_quanly/ui/profile_procedure_/profile_procedure_home/profile_proc_report/profile_proc_report_screen.dart';
import 'package:nkg_quanly/ui/profile_procedure_/profile_procedure_home/profiles_procedure_list_withstatistic.dart';


import '../../../const/const.dart';
import '../../../const/utils.dart';


class ProfileProcMenuScreen extends StatelessWidget {
  const ProfileProcMenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    border: Border(
                      bottom: BorderSide(
                        //                    <--- top side
                        color: Theme.of(context).dividerColor,
                        width: 1,
                      ),
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.arrow_back_ios_outlined),
                      ),
                      const Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
                      Text(
                        "Dịch vụ công hành chính",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                        const Expanded(
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: Text('Chỉnh sửa',
                                  style: TextStyle(color: kBlueButton))))
                    ],
                  ),
                ),
              ),
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
                        toUitilityScreen(
                            listUtility[index].type!, listUtility[index].title, listUtility[index].img);
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
      Get.to(() => ProfilesProcedureListWithStatistic());
      break;
      case 2:
      Get.to(() => ProfileProcReportScreen());
      break;
  }
}
class MenuItem {
  String? title;
  String? img;
  String? url;
  int? type;

  MenuItem(this.title, this.img, this.url, this.type);
}
List<MenuItem> listUtility = [
  MenuItem('Hồ sơ hành chính', 'assets/icons/ic_lunar_cal.png', "", 1),
  MenuItem('Thống kê hồ sơ', 'assets/icons/ic_hdsd.png', "", 2),
];
