// import 'dart:convert';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:http/http.dart' as http;
// import 'auth_user..dart';
// import 'chat_model.dart';
//
// class FsModel {
//   static final FsModel _instance = FsModel._();
//
//   FsModel._();
//
//   factory FsModel() {
//     return _instance;
//   }
//
//   void addUser(User? user) async {
//     // var token = await FirebaseMessaging.instance.getToken();
//     // print(token);
//     AuthUser authUser = AuthUser(
//       name: user?.displayName ?? "",
//       number: user?.phoneNumber??"",
//       email: user?.email ?? "",
//       img: "",
//       lastMsg: "",
//       lastTime: "",
//       online: true,
//       status: "",
//       // fcmToken: token,
//     );
//
//     // FirebaseFirestore.instance.collection("user").add(authUser.toJson());
//
//     FirebaseFirestore.instance.collection("user").doc(user?.uid ?? "").set(authUser.toJson()
//     );
//   }
//
//   void chat(String senderId, String receiverId, String senderEmail, String receiverEmail, String msg) async {
//     print("senderId $senderId");
//     print("receiverId $receiverId");
//     var doc1 = await FirebaseFirestore.instance.collection("chat").doc("$senderId-$receiverId").get();
//     var doc2 = await FirebaseFirestore.instance.collection("chat").doc("$receiverId-$senderId").get();
//     var receiverData = await FirebaseFirestore.instance.collection("user").doc(receiverId).get();
//     var receiverToken = receiverData.data()?["fcmToken"]??"";
//
//     // sendFCMNotification(receiverToken, senderEmail, msg);
//     doc1.reference.set({
//       "last_msg": msg,
//       "sender_email": senderEmail,
//       "email": receiverEmail,
//       "senderId": senderId,
//       "receiverId": receiverId,
//     });
//
//     doc2.reference.set({
//       "last_msg": msg,
//       "sender_email": receiverEmail,
//       "email": senderEmail,
//       "senderId": receiverId,
//       "receiverId": senderId,
//     });
//
//     doc1.reference.collection("messages").doc(DateTime.now().millisecondsSinceEpoch.toString()).set(
//       ChatModel(
//         time: DateTime.now().toString(),
//         senderId: senderId,
//         senderEmail: senderEmail,
//         msg: msg,
//       ).toJson(),
//     );
//     doc2.reference.collection("messages").doc(DateTime.now().millisecondsSinceEpoch.toString()).set(
//       ChatModel(
//         time: DateTime.now().toString(),
//         senderId: senderId,
//         senderEmail: senderEmail,
//         msg: msg,
//       ).toJson(),
//     );
//   }
//
//   // void sendFCMNotification(String receiverToken, String senderName, String msg) async {
//   //   Map<String, dynamic> map = {
//   //     "to": receiverToken,
//   //     "notification": {
//   //       "title": senderName,
//   //       "body": msg,
//   //     }
//   //   };
//   //   print(map);
//
//
//   }

import 'dart:convert';
import 'dart:io';

import 'package:chat_app/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'chat_model.dart';
import 'login&sign_model.dart';

class AddUserModel {
  static final _instance = AddUserModel._();

  AddUserModel._();

  factory AddUserModel() {
    return _instance;
  }
  TextEditingController email = TextEditingController();
  TextEditingController fname = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController pnumber = TextEditingController();
  TextEditingController chatMessage = TextEditingController();


  void addUser(User? user) async {
    // var token = await FirebaseMessaging.instance.getToken();
    String? image;
    DateTime dateTime = DateTime.now();
    var time = DateFormat("HH:mm a").format(dateTime);
    if (filepath.isNotEmpty) {
      var file = File(filepath.value);
      var readAsBytes = file.readAsBytesSync();
      image = base64Encode(readAsBytes);
    }

    AddUser addUsers = AddUser(
        name: user?.displayName ?? fname.text ,
        email: user?.email ?? "$email",
        image: user?.photoURL ?? "$image",
        lastMessage: "",
        lastTime: time,
        online: true,
        phone: user?.phoneNumber ?? pnumber.text,
        status: "",
        // fcmToken: token
    );

    FirebaseFirestore.instance
        .collection("user")
        .doc(user?.uid ?? "")
        .set(addUsers.toJson());
  }


  void chat(
      String senderId,
      String receiverId,
      String senderEmail,
      String receiverEmail,
      String msg,
      // String receiverName,
      // String senderName
      ) async {
    print("senderId $senderId");
    print("receiverId $receiverId");
    var doc1 = await FirebaseFirestore.instance
        .collection("chat")
        .doc("$senderId-$receiverId")
        .get();
    var doc2 = await FirebaseFirestore.instance
        .collection("chat")
        .doc("$receiverId-$senderId")
        .get();
    // var receiverData = await FirebaseFirestore.instance.collection("user").doc(receiverId).get();
    // var receiverToken = receiverData.data()?["fcmToken"]??"";

    // sendFCMNotification(receiverToken, senderEmail, msg);
    doc1.reference.set(
      {
        "last_msg": msg,
        "sender_email": senderEmail,
        "receiver_email": receiverEmail,
        "senderId": senderId,
        "receiverId": receiverId,
        // "receiver_name": receiverName,
        // "sender_name": senderName
      },
    );

    doc2.reference.set(   {
      "last_msg": msg,
      "sender_email": receiverEmail,
      "receiver_email": senderEmail,
      "senderId": receiverId,
      "receiverId": senderId,
      // "receiver_name": senderName,
      // "sender_name": receiverName
    },);



    doc1.reference
        .collection("messages")
        .doc(DateTime.now().millisecondsSinceEpoch.toString())
        .set(
          ChatModel(
            time: DateTime.now().toString(),
            senderId: senderId,
            senderEmail: senderEmail,
            msg: msg,
          ).toJson(),
        );
    doc2.reference
        .collection("messages")
        .doc(DateTime.now().millisecondsSinceEpoch.toString())
        .set(
          ChatModel(
            time: DateTime.now().toString(),
            senderId: senderId,
            senderEmail: senderEmail,
            msg: msg,
          ).toJson(),
        );
  }
}
