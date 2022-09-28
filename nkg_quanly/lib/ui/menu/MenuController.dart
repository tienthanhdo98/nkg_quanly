import 'package:get/get.dart';




class MenuController extends  GetxController  {
  final RxMap<int,String> listStateStatus = <int,String>{}.obs;
  final RxSet<int> listStatePriority = <int>{}.obs;
  final RxMap<int,String> listPriorityStatus = <int,String>{}.obs;
  final RxMap<int,String> listDepartmentStatus = <int,String>{}.obs;

  @override
  void onInit() {
    super.onInit();
  }
  void checkboxPriorityState(bool value, int key, String filterValue) {
    if (value == true) {
      var map = {key : filterValue};
      listPriorityStatus.addAll(map);
    } else {
      listPriorityStatus.remove(key);
    }

  }
  void checkboxDepartmentState(bool value, int key, String filterValue) {
    if (value == true) {
      var map = {key : filterValue};
      listDepartmentStatus.addAll(map);
    } else {
      listDepartmentStatus.remove(key);
    }

  }
  void checkboxStatusState(bool value, int key, String filterValue) {
    if (value == true) {
      var map = {key : filterValue};
      listStateStatus.addAll(map);
    } else {
      listStateStatus.remove(key);
    }
    print(listStateStatus.toString());
  }
  //show more info in screen list eoffice
  Rx<bool> rxShowStatistic = false.obs;
  void changeStateShowStatistic(bool value) {
    rxShowStatistic.value = value;
  }

}
