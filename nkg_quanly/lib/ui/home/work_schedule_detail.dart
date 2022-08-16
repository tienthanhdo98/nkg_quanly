import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nkg_quanly/const.dart';
import 'package:url_launcher/url_launcher.dart';

class WorkScheduleDetail extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => WorkScheduleInfoState();
}

class WorkScheduleInfoState extends State<WorkScheduleDetail> {
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
                Text("Hội thảo trực tuyến phòng ngừa thuốc lá cho học sinh",style: Theme.of(context).textTheme.headline1,),
                const Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 5)),
                const Text("Phòng họp lớp 01"),
                const Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 5)),
                InkWell(
                    onTap: () {
                      launch("https://meet.google.com/xxa-kjeh-kjc");
                    },
                    child: const Text("https://meet.google.com/xxa-kjeh-kjc",style: TextStyle(color: kBlueButton)
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
                    const Text("Họp online",
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
                      itemCount: 5,
                      itemBuilder: (context,index){
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Row(children: [
                              Image.asset("assets/icons/ic_user.png",width: 24,height: 24,),
                              Text("Trần Tuấn Anh(GĐ SGD HUNG YEN)",style: Theme.of(context).textTheme.headline3,)
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
