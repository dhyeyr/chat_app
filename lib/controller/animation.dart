import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class MyController extends GetxController {
  // Define an observable variable to control visibility
  RxBool isTileVisible = false.obs;


  // var iconData = Icons.nightlight_round;

  // Method to toggle visibility
  void toggleVisibility() {
    isTileVisible.value = !isTileVisible.value;

  }
  // IconData getShowaccountIcon() {
  //   return isTileVisible.value ?  Icons.keyboard_arrow_up_rounded:Icons.keyboard_arrow_down_outlined ;
  // }


}




