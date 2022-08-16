import 'package:flutter/material.dart';
import 'package:nkg_quanly/ui/theme/theme_data.dart';
import 'package:nkg_quanly/ui/chart/chart_screen.dart';
import 'package:nkg_quanly/ui/home/home_page.dart';
import 'package:nkg_quanly/ui/login/login_screen.dart';
import 'package:nkg_quanly/ui/setup/setting_screen.dart';
import 'package:provider/provider.dart';

import 'const.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(builder: (context, ThemeProvider themeProvider ,child){
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: themeProvider.darkTheme! ? ThemeClass.darkTheme :ThemeClass.lightTheme,
          home: const LoginScreen(),
        );
      },),

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
    const ChartScreen(),
     SettingScreen(),
     SettingScreen()
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
        backgroundColor: Theme.of(context).primaryColor,
        currentIndex: _selectedIndex,

        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Biểu đồ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Thông báo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Cài đặt',
          ),
        ],
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
