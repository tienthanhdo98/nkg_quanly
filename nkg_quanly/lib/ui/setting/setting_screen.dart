import 'package:flutter/material.dart';
import 'package:nkg_quanly/const/utils.dart';
import 'package:provider/provider.dart';

import '../../const/const.dart';
import '../../const/style.dart';
import '../login/login.dart';
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
                          child: const Icon(Icons.verified_user),
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
                            checkingStringNull(loginViewModel.rxUserInfoModel.value.name),
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          Text(
                           checkingStringNull(loginViewModel.rxUserInfoModel.value.email),
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
                            if (index != listMenu.length - 1) {
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
                                onTap: () async {
                                  loginViewModel.saveToShareFrefs("");
                                  print("rxAccessToken ${loginViewModel.rxAccessTokenSSO.value}");
                                  print("rxAccessTokenIoc ${loginViewModel.rxAccessTokenIoc.value}");
                                 await loginViewModel.revokeAccessToken(loginViewModel.rxAccessTokenSSO.value);
                                  await loginViewModel.revokeAccessTokenIoc(loginViewModel.rxAccessTokenIoc.value);
                                  print("clear");
                                  print("rxAccessToken ${loginViewModel.rxAccessTokenSSO.value}");
                                  print("rxAccessTokenIoc ${loginViewModel.rxAccessTokenIoc.value}");
                                  loginViewModel.changeValueLoading(true);
                                  Get.off(() => LoginScreen(isLogout: true,));
                                },
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
  MenuItem(icon: Icons.logout, title: "????ng xu???t"),
  // MenuItem(icon: Icons.home, title: "Kh??ng giam l??m vi???c s???"),
  // MenuItem(icon: Icons.pie_chart, title: "H??? th???ng PERMIS"),
  // MenuItem(icon: Icons.tag, title: "Ti???n ??ch"),
  // MenuItem(icon: Icons.receipt_long, title: "B??o c??o"),
  // MenuItem(icon: Icons.flag_rounded, title: "S??? ki??n"),
  // MenuItem(icon: Icons.account_circle_outlined, title: "T??i kho???n"),
  // MenuItem(icon: Icons.message, title: "Tin nh???n"),
  // MenuItem(icon: Icons.settings, title: "C??i ?????t"),
  // MenuItem(icon: Icons.nightlight_round, title: "Ch??? ????? ????m"),

];
