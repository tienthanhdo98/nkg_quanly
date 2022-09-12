

import 'package:get/get.dart';
import 'package:nkg_quanly/ui/menu/MenuController.dart';
class ScenarioBinding extends Bindings{
  @override
  void dependencies() {
    return Get.put(MenuController());
  }

}