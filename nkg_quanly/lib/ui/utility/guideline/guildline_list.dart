import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkg_quanly/const/style.dart';
import 'package:nkg_quanly/const/utils.dart';
import 'package:nkg_quanly/const/widget.dart';
import 'package:nkg_quanly/ui/theme/theme_data.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../const/const.dart';
import '../../../model/guildline_model/guildline_model.dart';
import 'guideline_search.dart';
import 'guideline_viewmodel.dart';

class GuidelineList extends GetView {
  String? header;
  
  final guildlineViewModel = Get.put(GuildlineViewModel());

  GuidelineList({Key? key, this.header}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          //header
          headerWidgetSearch(
              "Hướng dẫn sử dụng",
              GuidelineSearch(
                  guildlineViewModel),
              context),

          const Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Divider(
                thickness: 1,
              )),
          Expanded(
              child: Obx(() => (guildlineViewModel.rxGuideLineListItems.isNotEmpty) ? ListView.builder(
                shrinkWrap: true,
                  controller: guildlineViewModel.controller,
                  itemCount:
                      guildlineViewModel.rxGuideLineListItems.length,
                  itemBuilder: (context, index) {
                  var item =  guildlineViewModel.rxGuideLineListItems[index];
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
                          item,
                          guildlineViewModel),
                    );
                  }) : loadingIcon())),
        ],
      )),
    );
  }
}

class GuideItem extends StatelessWidget {
  GuideItem(this.index, this.docModel, this.guildlineViewModel);

  final int? index;
  final GuidelineListItems? docModel;
  final GuildlineViewModel? guildlineViewModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${index! + 1}. ${docModel!.name!}",
            style: Theme.of(context).textTheme.headline3,
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
            child: Text("File đính kèm",style: CustomTextStyle.grayColorTextStyle),
          ),
          Text(docModel!.fileName!,style: blueTextStyle),
          const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 10)),
          const Divider(
            thickness: 1.5,
          )
        ],
      ),
    );
  }
}


