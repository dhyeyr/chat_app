import 'dart:convert';

import 'package:chat_app/view/login_screen/signup_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../controller/animation.dart';
import '../../controller/home_controller.dart';
import '../../controller/login_controller.dart';
import '../../controller/theme_controller.dart';
import '../../okok.dart';
import '../call_page.dart';
import '../chat_screen/chat_page.dart';
import '../login_screen/login_page.dart';
import '../pages/setting_page.dart';
import '../photo.dart';
import '../user_list_screens/user_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  final MessageController controller = Get.put(MessageController());
  final ThemeController _themeController = Get.put(ThemeController());
  final MyController myController = Get.put(MyController());
  // var cu = FirebaseAuth.instance.currentUser;
  String? filePath;


  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _themeController.appBarColor.value,
        title: Text("Chat"),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(SettingsPage());
              },
              icon: Icon(Icons.search))
        ],
      ),
      drawer: NavigationDrawer(children: [
        Stack(
          children: [
            StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("user")
                    .doc(user?.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError && snapshot.data != null) {
                    return Text("Error ${snapshot.error}");
                  } else if (snapshot.data != null && snapshot.hasData) {
                    var data = snapshot.data?.data() as Map<String, dynamic>?;

                    return Obx(
                      () =>  UserAccountsDrawerHeader(
                        decoration: BoxDecoration(
                            color: _themeController.appBarColor.value),
                        currentAccountPicture: CircleAvatar(
                            radius: 50,
                            child: Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50)),
                              child: ("${data?["image"]}").startsWith("https://")
                                  ? Image.network(
                                      ("${data?["image"]}"),
                                      fit: BoxFit.fitWidth,
                                    )
                                  : Image.memory(
                                      base64Decode("${data?["image"]}"),
                                      width: double.infinity,
                                      fit: BoxFit.cover),
                            )),
                        accountName: Text(
                          "${data?["name"] ?? ""}",
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                        accountEmail: Text(
                          "${data?["email"] ?? ""}",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
            Padding(
              padding: const EdgeInsets.only(left: 250,top: 15),
              child:
              GestureDetector(
                onTap: () {
                  _themeController.toggleTheme(); // Toggle between light and dark themes
                },
                child: GetBuilder<ThemeController>(
                  builder: (ThemeController) {
                    return Obx(
                          () =>  AnimatedSwitcher(
                        duration: Duration(milliseconds: 300),

                        child: _themeController.isDarkMode.value
                            ? Icon(
                          Icons.wb_sunny,
                          key: Key('light_icon'),

                        )
                            : Icon(
                          Icons.nightlight_round,
                          key: Key('dark_icon'),

                        ),
                      ),
                    );
                  },
                ),
              ),

            ),

            Padding(
              padding: const EdgeInsets.only(left: 250, top: 100),
              child:

              GestureDetector(
                onTap: () {
                  myController.toggleVisibility(); // Toggle animation state
                },
                child: Obx(() {
                  return TweenAnimationBuilder<double>(
                    tween: Tween<double>(
                      begin: myController.isTileVisible.value ? 0 : 0.1,
                      end: myController.isTileVisible.value ? 1 : 2,
                    ),
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    builder: (context, value, child) {
                      return Transform.rotate(
                        angle: value * 3.14, // 180 degrees rotation
                        child: Icon(

                          Icons.keyboard_arrow_down_sharp,
                          size: 40.0,
                        ),
                      );
                    },
                  );
                }),
              ),
            ),
          ],
        ),
        Obx(() => myController.isTileVisible.value
            ? StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("user")
                    .doc(user?.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError && snapshot.data != null) {
                    return Text("Error ${snapshot.error}");
                  } else if (snapshot.data != null && snapshot.hasData) {
                    var data = snapshot.data?.data() as Map<String, dynamic>?;

                    return Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                              radius: 24,
                              child: Container(
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30)),
                                child:
                                    ("${data?["image"]}").startsWith("https://")
                                        ? Image.network(
                                            ("${data?["image"]}"),
                                            fit: BoxFit.fitWidth,
                                          )
                                        : Image.memory(
                                            base64Decode("${data?["image"]}"),
                                            width: double.infinity,
                                            fit: BoxFit.cover),
                              )),
                          title: Text(
                            "${data?["name"] ?? ""}",
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(LoginPage());
                          },
                          child: ListTile(
                            leading: Icon(Icons.add, size: 30),
                            title: Text(
                              "Add Account",
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                        Divider(indent: 20,endIndent: 20,)
                      ],
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                })
            : SizedBox()),
        ListTile(
          onTap: () async {
            // Get.to(UserListPage());
          },
          leading: Icon(Icons.group),
          title: Text("New Group"),
        ),
        ListTile(
          onTap: () async {
            Get.to(UserListPage());
          },
          leading: Icon(Icons.account_circle),
          title: Text("Contacts"),
        ),
        ListTile(
          onTap: () async {Get.to(Call_page());},
          leading: Icon(Icons.call_sharp),
          title: Text("Calls"),
        ),
        ListTile(
          onTap: () async {},
          leading: Icon(Icons.emoji_people_sharp),
          title: Text("People Nearby"),
        ),
        ListTile(
          onTap: () async {},
          leading: Icon(Icons.bookmark),
          title: Text("Saved Messages"),
        ),
        ListTile(
          onTap: () async {Get.to(SliverAppBarExample());
            },
          leading: Icon(Icons.settings),
          title: Text("Settings"),
        ),
        const ListTile(
          title: Divider(),
        ),
        ListTile(
          onTap: () async {
            await FirebaseAuth.instance.signOut();
            await GoogleSignIn().signOut();
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return LoginPage();
              },
            ));
          },
          title: Text("Logout"),
        ),
      ]),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("chat")
            .where("sender_email", isEqualTo: user?.email ?? "")
            .snapshots(),
        builder: (context, snapshot) {
          // controller.foundData.assignAll(snapshot.data?.docs ?? []);
          var foundData = snapshot.data?.docs ?? [];
          if (snapshot.hasError) {
            return Text("Error :${snapshot.error}");
          }
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            default:
              return ListView.builder(
                shrinkWrap: true,
                itemCount: foundData.length,
                itemBuilder: (context, index) {
                  var data = foundData[index];
                  var item = data.data() as Map<String, dynamic>;

                  return Card(
                    elevation: 0,
                    child: StreamBuilder<DocumentSnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("user")
                            .doc("${item["receiverId"]}")
                            .snapshots(),
                        builder: (context, snapshot) {
                          var userDetails =
                              snapshot.data?.data() as Map<String, dynamic>?;
                          print(item["sender_email"]);
                          return ListTile(
                            onTap: () {
                              var uid =
                                  FirebaseAuth.instance.currentUser?.uid ?? "";
                              // isRead.value = true;
                              var id = ((uid == item["receiverId"])
                                  ? item["senderId"]
                                  : item["receiverId"]);
                              var email = ((uid == item["receiverId"])
                                  ? item["sender_email"]
                                  : item["receiver_email"]);
                              Get.to(() => ChatPage(), arguments: {
                                "id": id,
                                "email": email,
                                "photo": userDetails?["image"],
                                "name": userDetails?["name"]
                              });
                              // print(userData.id);
                            },
                            leading: Container(
                                height: 50,
                                width: 50,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.white),
                                child: CircleAvatar(
                                    radius: 50,
                                    child: ("${userDetails?["image"]}")
                                            .startsWith("https://")
                                        ? Image.network(
                                            ("${userDetails?["image"]}"),
                                            width: double.infinity,
                                            fit: BoxFit.fitWidth,
                                          )
                                        : Image.memory(
                                            base64Decode(
                                                "${userDetails?["image"]}"),
                                            width: double.infinity,
                                            fit: BoxFit.fitWidth,
                                          ))),
                            title: Text(
                                ((user?.uid == controller.receiverId.value))
                                    ? "${userDetails?["name"]}"
                                    : "${userDetails?["name"]}"),
                            subtitle: Text("${item["last_msg"]}",
                                overflow: TextOverflow.ellipsis, maxLines: 1),
                            // trailing: Text(userTime),
                          );
                        }),
                  );
                },
              );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {Get.to(() => UserListPage());},
        shape: CircleBorder(),
        child: Icon(Icons.edit),

      ),
      // floatingActionButton: FloatingActionButton(
      //
      //   onPressed: () {
      //     Get.to(() => UserListPage());
      //   },
      //   child: Icon(Icons.edit),
      // ),
    );
  }
}
