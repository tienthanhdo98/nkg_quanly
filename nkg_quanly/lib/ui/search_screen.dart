import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkg_quanly/const/widget.dart';
import 'package:nkg_quanly/ui/document_out/search_controller.dart';

import '../../const/const.dart';

class SearchScreen extends GetView {
  SearchScreen({this.hintText = "", this.typeScreen = "", Key? key})
      : super(key: key);
  final String hintText;
  final String typeScreen;

  final searchController = Get.put(SearchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          searchController.clearData();
          return true;
        },
        child: SafeArea(
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
                          searchController.clearData();
                          searchController.onDelete();
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
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: hintText,
                                    ),
                                    style: const TextStyle(color: Colors.black),
                                    onSubmitted: (value) {
                                      getDataSearchByType(
                                          value, searchController, typeScreen);
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
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                      child: SizedBox(
                          height: 200,
                          child: Obx(() => searchResultWidgetByType(
                              typeScreen, searchController)))),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget searchResultWidgetByType(
  String typeScreen,
  SearchController searchController,
) {
  Widget widget = SizedBox();
  switch (typeScreen) {
    case type_mission:
      {
        widget = searchResultWidget(
            searchController, searchController.listDataMission, typeScreen);
      }
      break;
    case type_cars:
      {
        widget = searchResultWidget(
            searchController, searchController.rxBookingCarItems, typeScreen);
      }
      break;
    case type_room_meeting:
      {
        widget = searchResultWidget(
            searchController, searchController.rxMeetingRoomItems, typeScreen);
      }
      break;
    case type_profile_work:
      {
        widget = searchResultWidget(
            searchController, searchController.rxProfileWorkList, typeScreen);
      }
      break;
    case type_profile:
      {
        widget = searchResultWidget(
            searchController, searchController.rxProfileItems, typeScreen);
      }
      break;
    case type_document_in:
      {
        widget = searchResultWidget(
            searchController, searchController.listData, typeScreen);
      }
      break;
    case type_calendar_work:
      {
        widget = searchResultWidget(searchController,
            searchController.listDataCalendarWork, typeScreen);
      }
      break;
    case type_profile_procedure:
      {
        widget = searchResultWidget(
            searchController, searchController.listDataProfileProc, typeScreen);
      }
      break;
    case type_report:
      {
        widget = searchResultWidget(
            searchController, searchController.listDataReport, typeScreen);
      }
      break;
    case type_document_out:
      {
        widget = searchResultWidget(
            searchController, searchController.listDataDocOut, typeScreen);
      }
      break;
    case type_birthDay:
      {
        widget = searchResultWidget(
            searchController, searchController.listDataBirthDay, typeScreen);
      }
      break;
    case type_guildline:
      {
        widget = searchResultWidget(
            searchController, searchController.rxListGuideline, typeScreen);
      }
      break;
  }
  return widget;
}

void getDataSearchByType(
    String value, SearchController searchController, String type) {
  if (type == type_mission) {
    searchController.searchDataMission(value);
    searchController.changeLoadingState(true);
  } else if (type == type_cars) {
    searchController.searchBookingCar(value);
    searchController.changeLoadingState(true);
  } else if (type == type_room_meeting) {
    searchController.searchRoomMeeting(value);
    searchController.changeLoadingState(true);
  } else if (type == type_profile_work) {
    searchController.searchProfileWork(value);
    searchController.changeLoadingState(true);
  } else if (type == type_profile) {
    searchController.searchProfile(value);
    searchController.changeLoadingState(true);
  } else if (type == type_document_in) {
    searchController.searchData(value);
    searchController.changeLoadingState(true);
  } else if (type == type_calendar_work) {
    searchController.searchDataCalendarWork(value);
    searchController.changeLoadingState(true);
  } else if (type == type_profile_procedure) {
    searchController.searchDataProfileProc(value);
    searchController.changeLoadingState(true);
  } else if (type == type_report) {
    searchController.searchDataReport(value);
    searchController.changeLoadingState(true);
  } else if (type == type_document_out) {
    searchController.searchDataDocOut(value);
    searchController.changeLoadingState(true);
  } else if (type == type_birthDay) {
    searchController.searchDataBirthDay(value);
    searchController.changeLoadingState(true);
  }
  else if (type == type_guildline) {
    searchController.searchGuideLine(value);
    searchController.changeLoadingState(true);
  }
}
