import 'package:get/get.dart';




class MenuController extends  GetxController  {
  final RxSet<int> listStatePriority = <int>{}.obs;
  final RxSet<int> listStateStatus = <int>{}.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
  void checkboxPriorityState(bool value, int index) {
    if (value == true) {
      listStatePriority.add(index);
    } else {
      listStatePriority.remove(index);
    }
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
