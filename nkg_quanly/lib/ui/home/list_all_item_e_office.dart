import 'package:flutter/material.dart';
import 'package:nkg_quanly/const.dart';

import 'home_screen.dart';

class ListAllItemEOffice extends StatelessWidget {
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
                  bottom: BorderSide( //                    <--- top side
                    color: Theme.of(context).dividerColor,
                    width: 1,
                  ),
                )
            ),

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
                    "Hệ thống E-Office",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  const Expanded(
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Text('Chỉnh sửa',
                              style: TextStyle(color: kBlueButton))))
                ],
              ),
            ),
          ),
          SizedBox(
            child: GridView.count(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              // Create a grid with 2 columns. If you change the scrollDirection to
              // horizontal, this produces 2 rows.
              crossAxisCount: 4,
              childAspectRatio: 0.9,
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              // Generate 100 widgets that display their index in the List.
              children: List.generate(listEOffice.length, (index) {
                return InkWell(
                  onTap: () {
                    toScreenEoffice(listEOffice[index].type!, listEOffice[index].title, listEOffice[index].img);
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        listEOffice[index].img!,
                        width: 50,
                        height: 50,
                      ),
                      Flexible(
                        child: Text(
                          listEOffice[index].title!,
                          style: const TextStyle(fontSize: 12),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                );
              }),
            ),
          ),
        ],
      )),
    );
  }
}
