import 'package:flutter/material.dart';
import 'package:nkg_quanly/ui/profile_procedure_/profile_procedure_home/profiles_procedure_list_withstatistic.dart';
import '../document_out/search_controller.dart';


Widget listProfileProcSearchResultWidget(SearchController searchController, List list) {
  return ListView.builder(
      controller: searchController.controller,
      itemCount: list.length,
      itemBuilder: (context, index) {
        var item = list[index];
        return  InkWell(
            onTap: () {
              showModalBottomSheet<void>(
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                context: context,
                builder: (BuildContext context) {
                  var item = list[index];
                  return SizedBox(
                      height: 340,
                      child: DetailProfileProcBottomSheet(
                          index,
                          item));
                },
              );
            },
            child: ProfileProcItem(
                index,
                item));
      });
}
