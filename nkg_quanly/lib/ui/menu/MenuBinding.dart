import 'package:get/get.dart';
import 'package:nkg_quanly/viewmodel/date_picker_controller.dart';

class ScenarioBinding extends Bindings {
  @override
  void dependencies() {
    return Get.put(DatePickerController());
  }
}
