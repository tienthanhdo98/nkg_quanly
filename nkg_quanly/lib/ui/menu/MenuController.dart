import 'package:get/get.dart';

import '../home/menu_detail.dart';

class MenuController extends  GetxController  {
  final RxList<DocModel> listDemo = <DocModel>[].obs;
  final RxSet<int> listStatePriority = <int>{}.obs;
  final RxSet<int> listStateStatus = <int>{}.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    initData();
    super.onInit();
  }
  void checkboxPriorityState(bool value, int index) {
    if (value == true) {
      listStatePriority.add(index);
    } else {
      listStatePriority.remove(index);
    }
  }
  void initData(){
    listDemo.value = listDocDemo;
  }
  void checkboxAllPriorityState(bool value, int index) {
    if(index == 0) {
      if (value == true) {
        listStatePriority.add(0);
        listStatePriority.add(1);
        listStatePriority.add(2);
        listStatePriority.add(3);
      } else {
        listStatePriority.remove(0);
        listStatePriority.remove(1);
        listStatePriority.remove(2);
        listStatePriority.remove(3);
      }
    }
    if(index == 4){
      if (value == true) {
        listStatePriority.add(4);
        listStatePriority.add(5);
        listStatePriority.add(6);
      } else {
        listStatePriority.remove(4);
        listStatePriority.remove(5);
        listStatePriority.remove(6);
      }
    }
  }
  void checkboxStatusState(bool value, int index) {
    if (value == true) {
      listStateStatus.add(index);
    } else {
      listStateStatus.remove(index);
    }
  }
}
List<DocModel> listDocDemo = [
  DocModel('VB01-Văn bản 01 Cao', 3, true),
  DocModel('VB01-Văn bản 02 Trung bình', 2, false),
  DocModel('VB01-Văn bản 03', 1, false),
  DocModel('VB01-Văn bản 04 Cao', 3, true),
  DocModel('VB01-Văn bản 05', 2, true),
  DocModel('VB01-Văn bản 06 Thấp', 1, true),
  DocModel('VB01-Văn bản 07 Cao', 3, false),
];