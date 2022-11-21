import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkg_quanly/ui/document_out/search_controller.dart';
import 'package:url_launcher/url_launcher.dart';


import 'guildline_list.dart';


Widget listGuideLineResultWidget(
    SearchController searchController, List list) {
  return ListView.builder(
      controller: searchController.controller,
      itemCount: list.length,
      itemBuilder: (context, index) {
        var item =  list[index];
        return InkWell(
          onTap: ()async {
            var urlFile = "http://123.31.31.237:6002/api/guidelines/download-file/${item.id}";
            print(urlFile);
            if(await canLaunchUrl(Uri.parse(urlFile))) {
              launchUrl(
                Uri.parse(urlFile),
                webViewConfiguration: const WebViewConfiguration(
                    enableJavaScript: true,
                    enableDomStorage: true
                ),
                mode: LaunchMode.externalApplication,
              );
            }
          },
          child: GuideItem(
              index,
              item),
        );
      });
}


