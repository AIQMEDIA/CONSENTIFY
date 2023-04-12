import 'package:consentify/get/repository/main_repository.dart';
import 'package:get/get.dart';

import '../controller/main_controller.dart';

class SplashBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<MainController>(MainController(MainRepository()));
  }
}
