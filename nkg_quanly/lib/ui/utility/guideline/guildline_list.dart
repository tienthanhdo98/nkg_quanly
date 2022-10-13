import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkg_quanly/const/style.dart';
import 'package:nkg_quanly/const/utils.dart';
import 'package:nkg_quanly/const/widget.dart';
import 'package:nkg_quanly/ui/theme/theme_data.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../const/const.dart';
import '../../../model/guildline_model/guildline_model.dart';
import '../../document_nonapproved/document_nonapproved_search.dart';
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
          headerWidgetSeatch(
              "Hướng dẫn sử dụng",
              DocumentnonapprovedSearch(
                header: 'Hướng dẫn sử dụng',
              ),
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
                    return GuideItem(
                        index,
                        guildlineViewModel
                            .rxGuideLineListItems[index],
                        guildlineViewModel);
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
          InkWell(
              onTap: ()async {
                  launchUrl(Uri.parse(await guildlineViewModel!.getLinkDowloadGuilde(docModel!.id!)));
                },
              child: Text(docModel!.fileName!,style: blueTextStyle)),
          const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 10)),
          const Divider(
            thickness: 1.5,
          )
        ],
      ),
    );
  }
}


