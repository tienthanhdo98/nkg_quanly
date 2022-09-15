import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkg_quanly/ui/document_out/search_controller.dart';

import '../../const.dart';
import 'birthday_screen.dart';


class BirthDaySearch extends GetView {
  final searchController = Get.put(SearchController());

  BirthDaySearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    const Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
                    Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                              color: kgray,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          height: 50,
                          width: double.infinity,
                          child: Row(
                            children: [
                              const Padding(padding: EdgeInsets.fromLTRB(10, 0, 10, 0),child: Icon(Icons.search)),
                              SizedBox(
                                width: 200,
                                child: TextField(
                                  maxLines: 1,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Tìm kiếm...',
                                  ),
                                  style: const TextStyle(
                                      color: Colors.black),
                                  onSubmitted: (value){
                                    print(value);
                                    searchController.searchDataBirthDay(value);
                                  },
                                  onChanged: (value) {
                                    //print(value);
                                   // searchController.searchData(value);
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
                  padding: const EdgeInsets.fromLTRB(15, 15, 0, 0),
                  child: SizedBox(
                    height: 200,
                    child: Obx(() => ListView.builder(
                        itemCount: searchController.listDataBirthDay.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                              onTap: () {
                              },
                              child:
                              BirthDayItem(index, searchController.listDataBirthDay[index]));
                        })),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
