import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ThemeController extends GetxController {
  RxBool isDarkMode = false.obs;
  Rx<Color> appBarColor = Rx<Color>(const Color(0xFF24A1DE));
  Rx<Color> textform = Rx<Color>(const Color(0xC8E7E7E7));

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
    updateAppBarColor();
    updateATextformColor();
  }
  void updateATextformColor() {
    textform.value = isDarkMode.value ? const Color(0x0A3B73FF): const Color(0xC8E7E7E7) ;
  }


  void updateAppBarColor() {
    appBarColor.value = isDarkMode.value ? const Color(0x0A3B73FF): const Color(0xFF24A1DE) ;
  }
}

