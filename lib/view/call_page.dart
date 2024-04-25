import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/theme_controller.dart';

class Call_page extends StatelessWidget {
  final ThemeController _themeController = Get.put(ThemeController());
   Call_page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:_themeController.appBarColor.value ,title: Text("Call History"),
      centerTitle: true,),
      body: Center(child: Text("is Empty",style: TextStyle(fontSize: 25),)),
    );
  }
}
