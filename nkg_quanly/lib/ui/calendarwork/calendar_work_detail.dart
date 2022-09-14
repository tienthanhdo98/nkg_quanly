import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nkg_quanly/const.dart';
import 'package:nkg_quanly/model/calendarwork_model/calendarwork_model.dart';
import 'package:url_launcher/url_launcher.dart';

class CarlendarWorkDetail extends StatelessWidget {
  CarlendarWorkDetail(this.item, {Key? key}) : super(key: key);
  CalendarWorkListItems item;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: Align(
                        alignment: Alignment.topRight,
                        child: Image.asset(
                          "assets/icons/ic_close.png",
                          width: 40,
                          height: 40,
                        )),
                  ),
                ),
                Text(item.name!,style: Theme.of(context).textTheme.headline1,),
                const Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 5)),
                Text(item.location!,style: Theme.of(context).textTheme.headline3),
                const Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 5)),
                InkWell(
                    onTap: () {
                      launch("https://meet.google.com/xxa-kjeh-kjc");
                    },
                    child: Text(item.linkMeet!,style: TextStyle(color: kBlueButton)
                      ,)),
                const  Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 5)),
                const Divider(thickness: 1,),
                const  Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 5)),
                Row(
                  children: [
                    Image.asset(
                      "assets/icons/ic_camera.png",
                      height: 20,
                      width: 20,
                      fit: BoxFit.fill,
                    ),
                    const Padding(
                        padding: EdgeInsets.fromLTRB(
                            0, 0, 5, 0)),
                    Text(item.type!,
                        style: CustomTextStyle
                            .secondTextStyle)
                  ],
                ),
                const  Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 5)),
                const Divider(thickness: 1,),
                const  Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 5)),
                Text("Thành viên tham gia",style: Theme.of(context).textTheme.headline3),
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: item.participants!.length,
                      itemBuilder: (context,index){
                        Participants participants = item.participants![index];
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Row(children: [
                            Image.asset("assets/icons/ic_group.png",width: 24,height: 24,),
                            const Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
                            Text("${participants.name!} (${participants.position})",style: Theme.of(context).textTheme.headline3,)
                          ],),
                        );

                      }),
                )


              ],
            )),
      ),
    );
  }
}

