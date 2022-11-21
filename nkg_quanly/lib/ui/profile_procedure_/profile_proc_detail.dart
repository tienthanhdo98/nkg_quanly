import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkg_quanly/ui/profile_procedure_/profiles_procedure_viewmodel.dart';
import '../../const/const.dart';
import '../../const/style.dart';
import '../../const/utils.dart';
import '../../const/widget.dart';
import '../../model/profile_procedure_model/profile_procedure_model.dart';

class ProfileProcDetail extends GetView {
  final String? id;

  final profilesProcedureController = Get.put(ProfilesProcedureViewModel());

  ProfileProcDetail({Key? key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: profilesProcedureController.getProfileProcDetail(id!),
          builder:
              (context, AsyncSnapshot<ProfileProcedureListItems> snapshot) {
            // if(snapshot.hasData)
            //   {
            //     var item = snapshot.data;
            //     return  Column(children: [
            //       headerWidget('Chi tiết ${item!.name!}',context),
            //       Text(item.name!)
            //     ]);
            //   }
            // else if (snapshot.hasError) {
            //   return Text(snapshot.error.toString());
            // }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

