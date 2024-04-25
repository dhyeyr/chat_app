import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

import '../../controller/chat_controller.dart';
import '../../controller/theme_controller.dart';
import '../../model/fs_model.dart';
import '../photo.dart';

class ChatPage extends StatelessWidget {
  final ChatController controller = Get.put(ChatController());
  final ThemeController _themeController = Get.put(ThemeController());

  ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController _themeController = Get.put(ThemeController());
    return Scaffold(
      appBar: AppBar(
         titleSpacing: -6,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
      InkWell(
        onTap: () {
          Get.to(() => PhotoBar(),
              arguments: {
                "image":
                controller.photo ?? "",
                "name":
                controller.name ?? "",
              });
        },
        child: CircleAvatar(
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(40)),
          child: ((controller.photo ?? "").startsWith("https://")
              ? Image.network(
            (controller.photo ?? ""),
            width: double.infinity,
            fit: BoxFit.fitWidth,
          )
              : Image.memory(base64Decode(controller.photo ?? ""),
            width: double.infinity,
            fit: BoxFit.fitWidth,)),
        ),
            ),
      ),
            SizedBox(width: 10,),
            Text(controller.name ?? ""),
          ],
        ),
        backgroundColor: _themeController.appBarColor.value,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () {
                print(
                    "controller.chatRoomId.value  ${controller.chatRoomId.value}");
                return StreamBuilder<QuerySnapshot>(
                    // stream: FirebaseFirestore.instance.collection("${controller.senderId}-${controller.id}").doc("message").snapshots(),
                    stream: FirebaseFirestore.instance
                        .collection("chat")
                        .doc(controller.chatRoomId.value)
                        .collection("messages")
                        .snapshots(),
                    builder: (context, snapshot) {
                      List<QueryDocumentSnapshot> data =
                          snapshot.data?.docs ?? [];
                      print("data => $data");
                      return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          var item = data[index].data() as Map<String, dynamic>;
                          var isLoginUser =
                              controller.senderId == item["sender_id"];
                          // var item = data[index].data();
                          return Align(
                            alignment: isLoginUser
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Container(
                              margin: EdgeInsets.all(10),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    bottomLeft:
                                        Radius.circular(isLoginUser ? 20 : 0),
                                    topRight:
                                        Radius.circular(isLoginUser ? 0 : 20),
                                    bottomRight: Radius.circular(20),
                                  )),
                              child: InkWell(
                                onTap: () async {
                                  // var future = await FirebaseFirestore.instance.collection(controller.chatRoomId??"").doc().get();
                                  var future = await FirebaseFirestore.instance
                                      .collection("chat")
                                      .doc(controller.chatRoomId.value)
                                      .collection("messages")
                                      .get();
                                  // var msg=await future.reference.collection("messages").get();
                                  print(controller.chatRoomId);
                                  // var future2 = future as Map<String,dynamic>;
                                  print(future.docs);
                                  // print(msg.docs);
                                },
                                child: Text(
                                  item["msg"],
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    });
              },
            ),
          ),
          TextFormField(
            controller: controller.chatMsg,
            onFieldSubmitted: (value) async {
              var currentUser = FirebaseAuth.instance.currentUser;
              var uid = currentUser?.uid ?? "";

              AddUserModel().chat(
                  uid,
                  controller.id ?? "",
                  currentUser?.email ?? "",
                  controller.email ?? "",
                  controller.chatMsg.text,

              );
              controller.chatMsg.clear();
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: _themeController.textform.value,
                hintText: "    Enter message",
                suffixIcon: IconButton(
                    onPressed: () async {
                      var currentUser = FirebaseAuth.instance.currentUser;
                      var uid = currentUser?.uid ?? "";

                      if (controller.chatMsg.text.isNotEmpty) {
                        AddUserModel().chat(
                            uid,
                            controller.id ?? "",
                            currentUser?.email ?? "",
                            controller.email ?? "",
                            controller.chatMsg.text,

                        );
                      }
                      controller.chatMsg.clear();
                    },
                    icon: Icon(Icons.send))),
          ),

        ],
      ),
    );
  }
}

