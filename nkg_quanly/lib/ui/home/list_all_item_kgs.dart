import 'package:flutter/material.dart';
import 'package:nkg_quanly/const/const.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../const/utils.dart';
import '../chart/chart_viewmodel.dart';
import 'home_screen.dart';

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
              itemBuilder: (BuildContext context, int index){
                var item = chartViewModel.rxListWidgetItem[index];
                return  InkWell(
                  onTap: () {
                    // toScreen(
                    //     item.type!, item.title, item.img);
                    toScreenByName(item.name!);
                  },
                  child: Column(
                    children: [
                      getIconWidget(chartViewModel,index),
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
  MenuListItem('Lịch làm việc', 'assets/icons/ic_job.png', "", 1,""),
  MenuListItem('Báo cáo', 'assets/icons/ic_report.png', "", 2,""),
  MenuListItem('Văn bản đến chưa xử lý', 'assets/icons/ic_doc.png', "", 3,""),
  MenuListItem('Văn bản đến chưa bút phê', 'assets/icons/ic_doc_sign.png', "", 4,""),
  MenuListItem('Văn bản đi chờ phát hành', 'assets/icons/ic_doc_push.png', "", 5,""),
  MenuListItem('Hồ sơ trình', 'assets/icons/ic_doc_doc.png', "", 6,""),
  MenuListItem('Phòng họp', 'assets/icons/ic_meet.png', "", 7,""),
  MenuListItem('Nhiệm vụ', 'assets/icons/ic_mission.png', "", 8,""),
  MenuListItem('Sinh nhật', 'assets/icons/ic_birthday.png', "", 9,""),
  MenuListItem('Hồ sơ thủ tục hành chính', 'assets/icons/ic_thutuc_hanhchinh.png', "", 10,""),
  MenuListItem('Sổ tay công việc', 'assets/icons/ic_sotay.png', "", 11,""),
];
void toScreenByName(String name)
{
  var type = list.firstWhereOrNull((element) => element.title! == name)?.type!;
  var img =  list.firstWhereOrNull((element) => element.title! == name)?.img!;
   toScreen(
      type!, name, img);
}

Widget getIconWidget(ChartViewModel chartViewModel,int index)
{

 if (list.firstWhereOrNull((element) => element.title! == chartViewModel.rxListWidgetItem[index].name!) != null)
   {
     return Image.asset(
       list.firstWhereOrNull((element) => element.title! == chartViewModel.rxListWidgetItem[index].name!)!.img!,
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
       "http://123.31.31.237:8001/${chartViewModel.rxListWidgetItem[index].image ?? ""}",
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
