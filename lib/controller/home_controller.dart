import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class MessageController extends GetxController {
  QuerySnapshot<Map<String, dynamic>>? map;

  RxBool isShow = false.obs;
  String? image;
  String? name;
  RxString receiverId = "".obs;
  String? senderMail;


  // final RxList<QueryDocumentSnapshot> chatData =
  // RxList<QueryDocumentSnapshot>();
  // final RxList<QueryDocumentSnapshot> foundData =
  // RxList<QueryDocumentSnapshot>();

  @override
  void onInit() {
    FirebaseFirestore.instance
        .collection("user")
        .get()
        .then((value) => {print("data inserted")});
    super.onInit();
    super.onInit();
  }




}
