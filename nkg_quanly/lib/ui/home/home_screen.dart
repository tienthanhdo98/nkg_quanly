import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkg_quanly/ui/home/menu_screen.dart';
import '../../const.dart';
import 'list_all_item.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(children: [
              Image.asset("assets/bgtophome.png"),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
                child: Row(
                  children: [
                    Container(
                        child: const Icon(Icons.person),
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          color: kViolet,
                          borderRadius: BorderRadius.circular(30),
                        )),
                    const Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Xin chào",
                          style: TextStyle(color: kWhite),
                        ),
                        Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 0)),
                        Text(
                          "dev_dev",
                          style: TextStyle(color: kWhite, fontSize: 24),
                        )
                      ],
                    ),
                    Expanded(
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: kPink,
                                border: Border.all(
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: const Icon(
                                Icons.search,
                                color: kWhite,
                              ),
                            )))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 140, 20, 0),
                child: border(
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 15, 5, 15),
                                child: Text(
                                  'Thông báo khẩn',
                                  style: Theme.of(context).textTheme.headline2,
                                )),
                            Image.asset(
                              'assets/icons/ic_speaker.png',
                              width: 24,
                              height: 24,
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 40),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/anhdemo.png',
                                width: 150,
                                height: 100,
                              ),
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: Text(
                                    'Nam Định, Bình Dương nằm top 3 cao nhất điểm môn Toán tốt nghiệp THPT',
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    context),
              )
            ]),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Text('Không gian số',
                      style: Theme.of(context).textTheme.headline1),
                  Expanded(
                      child: Align(
                          alignment: Alignment.bottomRight,
                          child: InkWell(
                              onTap: () {
                                Get.to(ListAllItem());
                              },
                              child: Text(
                                'Xem tất cả',
                                style: TextStyle(color: kBlueButton),
                              ))))
                ],
              ),
            ),
            SizedBox(
              height: 180,
              child: GridView.count(
                physics: BouncingScrollPhysics(),
                // Create a grid with 2 columns. If you change the scrollDirection to
                // horizontal, this produces 2 rows.
                crossAxisCount: 4,
                childAspectRatio: 0.9,
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                // Generate 100 widgets that display their index in the List.
                children: List.generate(list.length, (index) {
                  MenuItem item = list[index];
                  return InkWell(
                    onTap: () {
                      Get.to(() => MenuScreen(header: item.title,icon: item.img,));
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
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
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
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 35, 10, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Thứ 5,ngày 2 tháng 6\nNăm Nhâm dần',
                          style: TextStyle(fontSize: 18, color: kWhite),
                        ),
                        Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                        Text("28/07/2022", style: TextStyle(color: kWhite))
                      ],
                    ),
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 35, 15, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text('Hôm nay\n25° / 30°',
                            style: TextStyle(color: kWhite)),
                        Image.asset(
                          'assets/icons/ic_rain.png',
                          fit: BoxFit.cover,
                          height: 80,
                          width: 80,
                        )
                      ],
                    ),
                  ))
                ]) /* add child content here */,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MenuItem {
  String? title;
  String? img;

  MenuItem(this.title, this.img);
}

List<MenuItem> list = [
  MenuItem('Lịch làm việc', 'assets/icons/ic_job.png'),
  MenuItem('Báo cáo', 'assets/icons/ic_report.png'),
  MenuItem('Văn bản chưa xử lý', 'assets/icons/ic_doc.png'),
  MenuItem('Văn bản đến chưa bút phê', 'assets/icons/ic_doc_sign.png'),
  MenuItem('Văn bản đi chờ phát hành', 'assets/icons/ic_doc_push.png'),
  MenuItem('Hồ sơ trình', 'assets/icons/ic_doc_doc.png'),
  MenuItem('Lịch họp', 'assets/icons/ic_meet.png'),
  MenuItem('Nhiệm vụ', 'assets/icons/ic_mission.png'),
];
