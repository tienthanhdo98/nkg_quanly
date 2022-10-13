import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../const/const.dart';
import '../../const/style.dart';
import '../theme/theme_data.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({Key? key}) : super(key: key);
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 80,
              color: Theme.of(context).cardColor,
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
            //user section
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                          child: Icon(Icons.verified_user),
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            color: kViolet,
                            borderRadius: BorderRadius.circular(20),
                          )),
                      const Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "dev",
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          const Text(
                            "dev@edu.gov.com.cv",
                            style: CustomTextStyle.secondTextStyle,
                          )
                        ],
                      ),
                      const Expanded(
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: Icon(Icons.more_horiz)))
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: SizedBox(
                      height: 420,
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: listMenu.length,
                          itemBuilder: (context, index) {
                            if (index == listMenu.length - 1) {
                              return Padding(
                                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: Row(
                                  children: [
                                    Icon(listMenu[index].icon),
                                    const Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 0, 0, 0)),
                                    Text(
                                      listMenu[index].title,
                                      style:
                                          Theme.of(context).textTheme.headline3,
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                        child: Consumer<ThemeProvider>(
                                          builder: (context,
                                              ThemeProvider themdeProvider,
                                              child) {
                                            return Align(
                                              alignment: Alignment.centerRight,
                                              child: SwitchListTile(
                                                  value:
                                                      themdeProvider.darkTheme!,
                                                  onChanged: (value) {
                                                    themdeProvider
                                                        .toggleTheme(value);
                                                  }),
                                            );
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            } else {
                              return InkWell(
                                onTap: () {},
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  child: Row(
                                    children: [
                                      Icon(listMenu[index].icon),
                                      const Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(10, 0, 0, 0)),
                                      Text(
                                        listMenu[index].title,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline3,
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }
                          }),
                    ),
                  )
                ],
              ),
            ),
            //menu section
          ],
        ),
      ),
    );
  }
}

class MenuItem {
  MenuItem({this.icon, this.title = ""});

  IconData? icon;
  String title;
}

List<MenuItem> listMenu = [
  MenuItem(icon: Icons.home, title: "Không giam làm việc số"),
  MenuItem(icon: Icons.pie_chart, title: "Hệ thống PERMIS"),
  MenuItem(icon: Icons.tag, title: "Tiện ích"),
  MenuItem(icon: Icons.receipt_long, title: "Báo cáo"),
  MenuItem(icon: Icons.flag_rounded, title: "Sự kiên"),
  MenuItem(icon: Icons.account_circle_outlined, title: "Tài khoản"),
  MenuItem(icon: Icons.message, title: "Tin nhắn"),
  MenuItem(icon: Icons.settings, title: "Cài đặt"),
  MenuItem(icon: Icons.nightlight_round, title: "Chế độ đêm"),
];
