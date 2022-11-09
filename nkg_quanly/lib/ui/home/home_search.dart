import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkg_quanly/ui/report/report_detail.dart';
import 'package:nkg_quanly/ui/report/report_list.dart';
import 'package:nkg_quanly/ui/theme/theme_data.dart';
import '../../const/const.dart';
import '../document_out/search_controller.dart';
import 'home_screen.dart';

class HomeSearch extends GetView {
  final searchController = Get.put(SearchController());

  @override
  Widget build(BuildContext context) {
    searchController.rxListSearchHome.value = listMenuHome;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  border: Border(
                      bottom: BorderSide(
                    width: 1,
                    color: Theme.of(context).dividerColor,
                  ))),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Image.asset(
                        'assets/icons/ic_arrow_back.png',
                        width: 18,
                        height: 18,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
                    Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                              color: kgray,
                              borderRadius: BorderRadius.circular(10)),
                          height: 50,
                          width: double.infinity,
                          child: Row(
                            children: [
                              const Padding(
                                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: Icon(Icons.search)),
                              SizedBox(
                                width: 200,
                                child: TextField(
                                  maxLines: 1,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Nhập tên chức năng',
                                  ),
                                  style: const TextStyle(color: Colors.black),
                                  onSubmitted: (value) {
                                    searchController.searchDataReport(value);
                                  },
                                  onChanged: (value) {
                                    //print(value);
                                    searchByKeywork(value, searchController);
                                  },
                                ),
                              )
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                height: double.infinity,
                child: SizedBox(
                  height: 200,
                  child: Obx(() => ListView.builder(
                      itemCount: searchController.rxListSearchHome.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Text(listMenuHome[index].title!,
                                style: const TextStyle(
                                    color: kBlueButton,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Roboto')),
                          ),
                        );
                      })),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

void searchByKeywork(String keywork, SearchController searchController) {
  List<MenuListItem> listResult = [];
  listMenuHome.forEach((element) {
    if (element.title!.toLowerCase().contains(keywork.toLowerCase())) {
      listResult.add(element);
    }
  });
  searchController.rxListSearchHome.value = listResult;
}

List<MenuListItem> listMenuHome = [
  MenuListItem('Không gian số', 'assets/icons/ic_kgs.png', "", 1),
  MenuListItem('Hệ thống E-Office', 'assets/icons/ic_eoffice.png', "", 2),
  MenuListItem('Dịch vụ công', 'assets/icons/ic_dichvucong.png', "", 3),
  MenuListItem('Báo cáo bộ', 'assets/icons/ic_report_bo.png', "", 4),
  MenuListItem('Thông tin nhân sự', 'assets/icons/ic_pmis.png', "", 5),
  MenuListItem(
      'Phân tích hiển thị chỉ số', 'assets/icons/ic_phantich.png', "", 6),
  MenuListItem('Tiện ích', 'assets/icons/ic_tienich.png', "", 7),
  MenuListItem('Helpdesk', 'assets/icons/ic_helpdesk.png', "", 8),
  //
  MenuListItem('Báo cáo', 'assets/icons/ic_report.png', "", 9),
  MenuListItem(
      'Văn bản đi chờ phát hành', 'assets/icons/ic_doc_push.png', "", 10),
  MenuListItem('Hồ sơ trình', 'assets/icons/ic_doc_doc.png', "", 11),
  MenuListItem('Nhiệm vụ', 'assets/icons/ic_mission.png', "", 12),
  MenuListItem('Sinh nhật', 'assets/icons/ic_birthday.png', "", 13),
  MenuListItem(
      'Thủ tục hành chính', 'assets/icons/ic_thutuc_hanhchinh.png', "", 14),
  MenuListItem('Sổ tay công việc', 'assets/icons/ic_sotay.png', "", 15),
  //
  MenuListItem('Lịch làm việc', 'assets/icons/ic_job.png', "", 16),
  MenuListItem('Văn bản đến', 'assets/icons/ic_doc_in.png', "", 17),
  MenuListItem('Hồ sơ công việc', 'assets/icons/ic_hoso_cv.png', "", 18),
  MenuListItem('Bố trí phòng họp', 'assets/icons/ic_meeting.png', "", 19),
  MenuListItem(
      'Bố trí và điều động xe ô tô', 'assets/icons/ic_booking_car.png', "", 20),
];
