
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  String? id;
  String? senderId;
  String? email;
  String? name;
  String? photo;
  RxString chatRoomId = "".obs;

  TextEditingController chatMsg = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      id = Get.arguments["id"];
      email = Get.arguments["email"];
      name = Get.arguments["name"];
      photo = Get.arguments["photo"];
    }
    senderId = FirebaseAuth.instance.currentUser?.uid ?? "";

    chatRoomId.value = "$senderId-$id";
  }
}
