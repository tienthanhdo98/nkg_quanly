import 'package:flutter/material.dart';
import 'package:nkg_quanly/const/const.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../const/utils.dart';
import '../chart/chart_viewmodel.dart';
import 'home_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ListAllItemKGS extends StatelessWidget {
  const ListAllItemKGS({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ChartViewModel chartViewModel = Get.find();
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          headerWidget("Không gian số", context),
          SizedBox(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 0.9,
              ),
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              // Create a grid with 2 columns. If you change the scrollDirection to
              // horizontal, this produces 2 rows.

              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              // Generate 100 widgets that display their index in the List.
              itemCount: chartViewModel.rxListWidgetItem.length,
              itemBuilder: (BuildContext context, int index) {
                var item = chartViewModel.rxListWidgetItem[index];
                return InkWell(
                  onTap: () {
                    // toScreen(
                    //     item.type!, item.title, item.img);
                    toScreenByName(item.name!);
                  },
                  child: Column(
                    children: [
                      getIconWidget(chartViewModel, index),
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

List<MenuListItem> list = [
  MenuListItem('Lịch làm việc', 'assets/icons/ic_job.png', "", 1, "41b72d4a-c3ff-4522-537b-08da949256b0"),
  MenuListItem('Báo cáo', 'assets/icons/ic_report.png', "", 2, "ddc1a609-99c6-47e1-0b81-08da99eba680"),
  MenuListItem('Văn bản đến chưa xử lý', 'assets/icons/ic_doc.png', "", 3, "d548eb3f-7139-4184-0b77-08da99eba680"),
  MenuListItem(
      'Văn bản đến chưa bút phê', 'assets/icons/ic_doc_sign.png', "", 4, "a0c524ad-fb03-4842-0b7b-08da99eba680"),
  MenuListItem(
      'Văn bản đi chờ phát hành', 'assets/icons/ic_doc_push.png', "", 5, "4a09555d-65fb-45b9-0b78-08da99eba680"),
  MenuListItem('Hồ sơ trình', 'assets/icons/ic_doc_doc.png', "", 6, "8c3c7c86-1553-466a-0b7a-08da99eba680"),
  MenuListItem('Phòng họp', 'assets/icons/ic_meet.png', "", 7, "de5a2a3c-c0d9-4517-0b79-08da99eba680"),
  MenuListItem('Nhiệm vụ', 'assets/icons/ic_mission.png', "", 8, "09ede2a1-e81e-4f9c-0b7c-08da99eba680"),
  MenuListItem('Sinh nhật', 'assets/icons/ic_birthday.png', "", 9, "beb9bd3b-cde3-43b8-0b7e-08da99eba680"),
  MenuListItem('Hồ sơ thủ tục hành chính',
      'assets/icons/ic_thutuc_hanhchinh.png', "", 10, "d845ea9d-cd97-4c02-0b7f-08da99eba680"),
  MenuListItem('Sổ tay công việc', 'assets/icons/ic_sotay.png', "", 11, ""),
];

void toScreenByName(String name) {
  var type = list.firstWhereOrNull((element) => element.title! == name)?.type!;
  var img = list.firstWhereOrNull((element) => element.title! == name)?.img!;
  toScreen(type!, name, img);
}

Widget getIconWidget(ChartViewModel chartViewModel, int index) {
  if (list.firstWhereOrNull((element) => element.id! == chartViewModel.rxListWidgetItem[index].id!) != null) {
    return Image.asset(
      list.firstWhereOrNull((element) => element.id! == chartViewModel.rxListWidgetItem[index].id!)!.img!,
      width: 50,
      height: 50,
      fit: BoxFit.cover,
    );
  } else {
    String icon = "http://123.31.31.237:8001/${chartViewModel.rxListWidgetItem[index].image ?? ""}";
    print(!icon.contains(".svg"));
    if (icon.contains(".svg")) {
      print("png");
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
