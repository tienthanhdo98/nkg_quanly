import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:nkg_quanly/const/const.dart';
import 'package:nkg_quanly/ui/PMis/PMis_screen.dart';
import 'package:nkg_quanly/ui/analysis_report/analysis_report_education_screen.dart';
import 'package:nkg_quanly/ui/analysis_report/report_Infrastructure/report_infrastructure_screen.dart';
import 'package:nkg_quanly/ui/analysis_report/report_beneficiary/report_beneficiary_screen.dart';
import 'package:nkg_quanly/ui/analysis_report/report_continuingEducation/report_continuing_ducation_screen.dart';
import 'package:nkg_quanly/ui/analysis_report/report_disability_education/report_disability_education_screen.dart';
import 'package:nkg_quanly/ui/analysis_report/report_education_quality/report_education_quality_screen.dart';
import 'package:nkg_quanly/ui/analysis_report/report_highschool/report_high_school_screen.dart';
import 'package:nkg_quanly/ui/analysis_report/report_preschool/report_pre_school_screen.dart';
import 'package:nkg_quanly/ui/analysis_report/report_primaryschool/report_primary_school_screen.dart';
import 'package:nkg_quanly/ui/analysis_report/report_secondaryschool/report_secondary_school_screen.dart';
import 'package:nkg_quanly/ui/birthday/birthday_screen.dart';
import 'package:nkg_quanly/ui/book_room_meet/e_office/book_room_e_office_list.dart';
import 'package:nkg_quanly/ui/booking_car/e_office/booking_car_e_office_list.dart';
import 'package:nkg_quanly/ui/calendarwork/calendar_work_screen.dart';
import 'package:nkg_quanly/ui/calendarwork/e_office/calendar_work_e_office_screen.dart';
import 'package:nkg_quanly/ui/chart/chart_screen.dart';
import 'package:nkg_quanly/ui/document_out/document_out_list.dart';
import 'package:nkg_quanly/ui/document_unprocess/e_office/document_in_e_office_list.dart';
import 'package:nkg_quanly/ui/helpdesk/help_desk_list.dart';
import 'package:nkg_quanly/ui/home/home_screen.dart';
import 'package:nkg_quanly/ui/login/login.dart';
import 'package:nkg_quanly/ui/mission/e_office/mission__e_office_list.dart';
import 'package:nkg_quanly/ui/notification/notification_screen.dart';
import 'package:nkg_quanly/ui/notification/notification_viewmodel.dart';
import 'package:nkg_quanly/ui/profile/e_office/profile_e_office_list.dart';
import 'package:nkg_quanly/ui/profile_procedure_/profile_procedure_home/profile_proc_report/profile_proc_report_screen.dart';
import 'package:nkg_quanly/ui/profile_procedure_/profile_procedure_home/profiles_procedure_list_withstatistic.dart';
import 'package:nkg_quanly/ui/profile_work/e_office/profile_work_e_office_list.dart';
import 'package:nkg_quanly/ui/report/report_in_menuhome/report_in_menuhome_list.dart';
import 'package:nkg_quanly/ui/setting/setting_screen.dart';
import 'package:nkg_quanly/ui/theme/theme_data.dart';
import 'package:nkg_quanly/ui/utility/group_contacts/group_contacts_list.dart';
import 'package:nkg_quanly/ui/utility/group_workbook/group_workbook_list.dart';
import 'package:nkg_quanly/ui/utility/guideline/guildline_list.dart';
import 'package:nkg_quanly/ui/utility/individual_contacts/individual_contacts_list.dart';
import 'package:nkg_quanly/ui/utility/lunar_calendar_screen.dart';
import 'package:nkg_quanly/ui/workbook/workbook_list.dart';
import 'package:provider/provider.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(const MyApp()));
  // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, ThemeProvider themeProvider, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeClass.lightTheme,
            home: const LoginScreen(),
            initialRoute: '/',
            routes: {
              '/PMisScreen': (context) => PMisScreen(),
              '/HelpDeskScreen': (context) => HelpDeskList(),
              '/ReportScreen': (context) => ReportInMenuHomeList(),
              '/DocumentOutList': (context) => DocumentOutList(),
              '/ProfileEOfficeList': (context) => ProfileEOfficeList(),
              '/MissionEOfficeList': (context) => MissionEOfficeList(),
              '/BirthDayScreen': (context) => BirthDayScreen(),
              '/ProfilesProcedureListWithStatistic': (context) => ProfilesProcedureListWithStatistic(),
              '/ProfileProcReportScreen': (context) => ProfileProcReportScreen(),
              '/WorkBookList': (context) => WorkBookList(),
              '/CalendarWorkScreen': (context) => CalendarWorkEOfficeScreen(),
              '/DocumentInEOfficeList': (context) => DocumentInEOfficeList(),
              '/ProfileWorkEOfficeList': (context) => ProfileWorkEOfficeList(),
              '/BookRoomEOfficeList': (context) => BookRoomEOfficeList(),
              '/BookingEOfficeCarList': (context) => BookingEOfficeCarList(),
              '/AnalysisReportEducationScreen': (context) => AnalysisReportEducationScreen(),
              '/ReportPreSchoolScreen': (context) => ReportPreSchoolScreen(),
              '/ReportPrimarySchoolScreen': (context) => ReportPrimarySchoolScreen(),
              '/ReportSecondarySchoolScreen': (context) => ReportSecondarySchoolScreen(),
              '/ReportHighSchoolScreen': (context) => ReportHighSchoolScreen(),
              '/ReportDisabilityEducationScreen': (context) => ReportDisabilityEducationScreen(),
              '/ReportBeneficiaryScreen': (context) => ReportBeneficiaryScreen(),
              '/ReportEducationQualityScreen': (context) => ReportEducationQualityScreen(),
              '/ReportContinuingEducationScreen': (context) => ReportContinuingEducationScreen(),
              '/ReportInfrastructureChatScreen': (context) => ReportInfrastructureChatScreen(),
              '/LunarCalendarScreen': (context) => LunarCalendarScreen(),
              '/GuidelineList': (context) => GuidelineList(),
              '/GroupContactsList': (context) => GroupContactsList(),
              '/IndividualContactsList': (context) => IndividualContactsList(),
              '/GroupWorkBookList': (context) => GroupWorkBookList(),
              '/HomeScreen': (context) => HomeScreen(),


            },
          );
        },
      ),
    );
  }
}

//LoginScreen
class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MainScreenStage();
}

class MainScreenStage extends State<MainScreen> {
  int _selectedIndex = 0;
  final notificationViewModel = Get.put(NotificationViewModel());
  static final List<Widget> _widgetOptions = <Widget>[
    ChartScreen(),
    HomeScreen(),
    NotificationScreen(),
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
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: SafeArea(
            child: _widgetOptions.elementAt(_selectedIndex)),
      ),
      //bottom
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items:  <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Trang chủ',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Chức năng',
          ),
          BottomNavigationBarItem(
            icon: Stack(children: <Widget>[
                 const Icon(Icons.notifications),
                 Obx(
                     () => (notificationViewModel.isNewNotification.value == true) ? const Positioned(
                      top: -1.0,
                      right: -1.0,
                      child: Icon(
                       Icons.brightness_1,
                       size: 10.0,
                       color: kRedChart,
                          )) : const SizedBox.shrink(),
                 )
              ]),
            label: 'Thông báo',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Cài đặt',
          ),
        ],
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
