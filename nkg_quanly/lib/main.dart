import 'package:flutter/material.dart';
import 'package:nkg_quanly/ui/home/home_page.dart';
import 'package:nkg_quanly/ui/login/login_screen.dart';
import 'package:nkg_quanly/ui/setup/setting_screen.dart';

import 'const.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: kBackGround,
      ),
      home: const LoginScreen(),
    );
  }
}



class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HomeScreenStage();
}

class HomeScreenStage extends State<HomeScreen> {
  int _selectedIndex = 0;

  static  final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    const SettingScreen(),
    const SettingScreen(),
    const SettingScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //body
      body: SafeArea(child: _widgetOptions.elementAt(_selectedIndex)),
      //bottom
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: kBlueButton,
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,
        onTap: _onItemTapped,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/ic_home.png',
              height: 20,
            ),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/ic_chart.png',
              height: 20,
            ),
            label: 'Biểu đồ',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/ic_bell.png',
              height: 20,
            ),
            label: 'Thông báo',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/ic_menu.png',
              height: 20,
            ),
            label: 'Cài đặt',
          ),
        ],
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
