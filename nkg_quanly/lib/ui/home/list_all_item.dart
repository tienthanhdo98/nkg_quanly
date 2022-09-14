import 'package:flutter/material.dart';
import 'package:nkg_quanly/const.dart';

import 'home_screen.dart';

class ListAllItem extends StatelessWidget {
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
                    "Không gian số",
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
          Padding(
            padding: const EdgeInsets.all(20),
            child: Align(
              alignment: Alignment.centerLeft,
              child:
                  Text('Báo cáo', style: Theme.of(context).textTheme.headline1),
            ),
          ),
          SizedBox(
            height: 180,
            child: GridView.count(
              physics: BouncingScrollPhysics(),
              // Create a grid with 2 columns. If you change the scrollDirection to
              // horizontal, this produces 2 rows.
              crossAxisCount: 4,
              childAspectRatio: 0.9,
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              // Generate 100 widgets that display their index in the List.
              children: List.generate(list.length, (index) {
                return InkWell(
                  onTap: () {
                    toScreen(list[index].type!, list[index].title, list[index].img);
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        list[index].img!,
                        width: 50,
                        height: 50,
                      ),
                      Flexible(
                        child: Text(
                          list[index].title!,
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
          const Divider(
            thickness: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Tiện ích khác',
                  style: Theme.of(context).textTheme.headline1),
            ),
          ),
          SizedBox(
            height: 180,
            child: GridView.count(
              physics: BouncingScrollPhysics(),
              // Create a grid with 2 columns. If you change the scrollDirection to
              // horizontal, this produces 2 rows.
              crossAxisCount: 4,
              childAspectRatio: 0.9,
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              // Generate 100 widgets that display their index in the List.
              children: List.generate(list2.length, (index) {
                return InkWell(
                  onTap: (){
                    toScreen(list2[index].type!,list2[index].title,list2[index].img);
                    print(list2[index].type!);
                    print(list2[index].title!);
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        list2[index].img!,
                        width: 50,
                        height: 50,
                      ),
                      Flexible(
                        child: Text(
                          list2[index].title!,
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