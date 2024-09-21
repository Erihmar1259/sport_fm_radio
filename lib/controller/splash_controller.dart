import 'package:get/get.dart';

import '../views/screens/bottom_nav_menu.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAll(() => const BottomNavMenu());
    });
    super.onInit();
  }
}
