import 'package:flutter/material.dart';
import 'package:nkg_quanly/const/utils.dart';

import '../../const/widget.dart';
import '../birthday/birthday_screen.dart';
import '../birthday/birthday_viewmodel.dart';

class BirthdayWidget extends StatelessWidget {
  BirthdayWidget({
    Key? key,
  }) : super(key: key);
  final birthDayViewModel = Get.put(BirthDayViewModel());
  @override
  Widget build(BuildContext context) {
    birthDayViewModel.getBirthDayInHomeScreen(DateFormat('yyyy-MM-dd').format(dateNow));
    return Padding(
      padding: const EdgeInsets.all(15),
      child: borderItem(
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sinh nhật",
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        const Padding(
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 5)),
                        Text(convertDateToWidget(dateNow),
                            style: Theme.of(context).textTheme.headline1)
                      ],
                    ),
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    BirthDayScreen()));
                      },
                      child: const Align(
                          alignment: Alignment.topRight,
                          child: Icon(Icons.more_horiz)),
                    ))
                  ],
                ),
              ),
              const Divider(
                thickness: 2,
              ),
              //table
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).splashColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  width: double.infinity,
                  height: 40,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 100,
                        child: Center(
                          child: Text(
                            "Tên",
                            style: Theme.of(context).textTheme.headline2,
                          ),
                        ),
                      ),
                      const VerticalDivider(width: 1, thickness: 1),
                      const Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 10, 0)),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Ngày sinh",
                              style: Theme.of(context).textTheme.headline2),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: Divider(
                  thickness: 2,
                ),
              ),
              SizedBox(
                height: 300,
                child: Obx(() => (birthDayViewModel
                    .rxBirthDayListItemsInCurDay.isNotEmpty)
                    ? ListView.builder(
                    itemCount: birthDayViewModel.rxBirthDayListItemsInCurDay.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                          onTap: () {
                            // Get.to(() => DocumentInDetail(
                            //     id: snapshot.data!.items![index].id!));
                          },
                          child: BirthDayItem(index,
                              birthDayViewModel.rxBirthDayListItemsInCurDay[index]));
                    })
                    : noData()),
              ),
              const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 15))
            ],
          ),
          context),
    );
  }
}
