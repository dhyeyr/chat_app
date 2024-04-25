// // ignore_for_file: prefer_const_constructors
//
//
// import 'dart:convert';
// import 'dart:html';
//
// import 'package:chat_app/view/home%20screens/Home_Page.dart';
// import 'package:chat_app/view/login_screen/login_page.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../model/fs_model.dart';
// import '../model/login&sign_model.dart';
// import '../model/user_model.dart';
//
// class SignupController extends GetxController {
//   RxBool isTerm = RxBool(false);
//
//   GlobalKey<FormState> globalKey = GlobalKey<FormState>();
//
//   // void goto() async {
//   //   if (globalKey.currentState?.validate() ?? false) {
//   //     FocusScope.of(Get.context!).unfocus();
//   //     UserCredential user = await FirebaseAuth.instance
//   //         .createUserWithEmailAndPassword(
//   //         email: email.text, password: password.text);
//   //
//   //     AddUserModel().addUser(user.user);
//   //     AddUser(
//   //         name: fname.text,
//   //         email: email.text,
//   //         phone: pnumber.text,
//   //         image: image);
//   //
//   //     Get.to(()=>LoginPage());
//   //   }
//   //
//   // }
//   RxString? value;
//   String? image;
//   void goto() async {
//     if (globalKey.currentState?.validate() ?? false) {
//       FocusScope.of(Get.context!).unfocus();
//       UserCredential user = await FirebaseAuth.instance
//           .createUserWithEmailAndPassword(
//           email: email.text, password: password.text);
//       //base memory image:
//       if(filepath.isNotEmpty){
//         var file = File(filepath.value);
//         var readAsBytes =await file.readAsBytes();
//         image = base64Encode(readAsBytes);
//
//       }
//       AddUserModel().addUser(user.user);
//       AddUser(
//           name: fname.text,
//           email: email.text,
//           phone: pnumber.text,
//           image: image);
//
//       Get.off(()=>LoginPage());
//     }
//   }
// }
// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:chat_app/view/home%20screens/Home_Page.dart';
import 'package:chat_app/view/login_screen/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../model/fs_model.dart';
import '../model/login&sign_model.dart';
import '../model/user_model.dart';

class U_list extends GetxController {
  RxBool isTerm = RxBool(false);
  late AddUserModel userModel = AddUserModel();
  // TextEditingController email = TextEditingController();
  // TextEditingController fname = TextEditingController();
  // TextEditingController password = TextEditingController();
  // TextEditingController newPassword = TextEditingController();
  // TextEditingController pnumber = TextEditingController();
  // TextEditingController chatMessage = TextEditingController();

  RxString? value;
  String? image;
  void goto1() async {

      FocusScope.of(Get.context!).unfocus();
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: userModel.email.text, password: userModel.password.text);

      //base memory image:s
      if(filepath.isNotEmpty){
        var file = File(filepath.value);
        var readAsBytes =await file.readAsBytes();
        image = base64Encode(readAsBytes);

      }
      AddUserModel().addUser(user.user);
      AddUser(
          name: userModel.fname.text,
          email: userModel.email.text,
          phone: userModel.pnumber.text,
          image: image
      );
// Get.off(LoginPage());

    // fname.clear();
    // email.clear();
    // pnumber.clear();
    // password.clear();
  }


}
