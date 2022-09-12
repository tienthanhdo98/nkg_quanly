import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:nkg_quanly/ui/home/menu_detail.dart';

import '../../const.dart';
import '../chart2/pie_chart.dart';

class MenuScreen extends GetView {
  String? header;
  String? icon;

  MenuScreen({this.header, this.icon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(children: [
          Stack(
            children: [
              Image.asset("assets/bgtophome.png",
                  height: 220, width: double.infinity, fit: BoxFit.cover),
              Container(
                color: Theme.of(context).cardColor,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.arrow_back_ios_outlined),
                      ),
                      const Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
                      Text(
                        header!,
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      const Expanded(
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: Icon(Icons.search)))
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 100, 20, 0),
                child: border(
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text('Tổng văn bản'),
                                Text('5.987',style: TextStyle(color: kBlueButton,fontSize: 40),)
                              ],
                            ),
                              Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Image.asset(
                                  icon!,
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                            )
                          ],
                        ),
                       const Padding(
                         padding: EdgeInsets.fromLTRB(0, 10, 0, 20),
                         child: Divider(
                            thickness: 1,
                          ),
                       ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [Text('Chưa bút phê'), Text('300',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20))],
                            ),
                            Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0)),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [Text('Chưa bút phê'), Text('300',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)],
                            )
                          ],
                        )
                      ]),
                    ),
                    context),
              )
            ],
          ),
         const Padding(padding : EdgeInsets.fromLTRB(0, 20, 0, 0),child: PieChart2()),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
            child: ElevatedButton(onPressed: (){
              Get.to(() => MenuDetail(header: header,));
            }, child: Text('Xem danh sách VB đến chưa bút phê'),style: ButtonStyle(
                backgroundColor:  MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return kBlueButton;
                    }
                    else{
                      return kBlueButton;
                    }// Use the component's default.
                  },
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                    )
                )
            ),),
          )
        ]),
      ),
    );
  }
}
