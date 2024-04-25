import 'dart:convert';
import 'dart:io';

import 'package:chat_app/controller/theme_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

import '../../controller/sign_controller.dart';
import '../../controller/user_list_controller.dart';
import '../../model/fs_model.dart';
import '../../model/login&sign_model.dart';
import '../chat_screen/chat_page.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  var cu = FirebaseAuth.instance.currentUser;
  final ThemeController _themeController = Get.put(ThemeController());
  final U_list controller = Get.put(U_list());
  // late final AddUserModel? userModel;
  late AddUserModel userModel = AddUserModel();
  final _obscureText = true.obs;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _themeController.appBarColor.value,
        title: Text("New Messages"),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("user").snapshots(),
          builder: (context, snapshot) {
            var list = snapshot.data?.docs ?? [];
            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                var item = list[index];
                var data = item.data() as Map<String, dynamic>;

                return Column(
                  children: [
                    SizedBox(height: 10,),
                    ListTile(
                      onTap: () {
                        Get.to(() => ChatPage(), arguments: {
                          "id": item.id,
                          "email": data["email"],
                          "name": data["name"],
                          "photo": data["image"],
                        });
                      },
                      leading: CircleAvatar(
                          radius: 25,
                          child: Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50)),
                            child:
                            ("${data["image"]}").startsWith("https://")
                                ? Image.network(
                                    ("${data["image"]}"),
                                    width: double.infinity,
                                    fit: BoxFit.fitWidth,
                                  )
                                : Image.memory(
                                    base64Decode("${data["image"]}"),
                                    fit: BoxFit.fitWidth,
                                    width: double.infinity,
                                  ),
                          )),
                      title: Text("${data["name"]}"),
                      // shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10),)
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                );
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {


          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return SingleChildScrollView(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    // mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.only(right: 230, top: 20),
                        child: Text(
                          "New User",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: TextFormField(
                          controller:userModel.fname,
                          decoration: const InputDecoration(
                              labelText: "Enter Your Full Name",
                              border: OutlineInputBorder()),
                          keyboardType: TextInputType.name,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 10),
                        child: TextFormField(
                            controller: userModel.pnumber,
                            decoration: const InputDecoration(
                                labelText: "Enter Your Number",
                                border: OutlineInputBorder()),
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value?.isEmpty ?? false) {
                                return "* Plz Enter Your Phone Number";
                              } else if (value?.length != 10) {
                                return "* Invalid Phone Number";
                              } else {
                                return null;
                              }
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 10),
                        child: TextFormField(
                          controller: userModel.email,
                          decoration: const InputDecoration(
                              labelText: "Email",
                              border: OutlineInputBorder()),
                          validator: (value) {
                            if (value?.isEmpty ?? false) {
                              return "* Plz Enter Your Email";
                            } else if (!isEmail(value ?? "")) {
                              return "* Invalid Email ";
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 10),
                        child: Obx(
                          () => TextFormField(
                            controller: userModel.password,
                            obscureText: _obscureText.value,
                            decoration: InputDecoration(
                              labelText: "Password",
                              border: OutlineInputBorder(),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureText.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  _obscureText
                                      .toggle(); // Toggle password visibility
                                },
                              ),
                            ),
                            validator: (value) {
                              controller.value?.value = value ?? "";
                              if (value?.isEmpty ?? false) {
                                return "Plz Enter Your Password";
                              } else if (value?.contains("@") ?? false) {
                                return null;
                              } else {
                                return "Not A Strong password";
                              }
                            },
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 10),
                          child: InkWell(

                            onTap: ()async {
                              controller.goto1();

                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                  borderRadius: BorderRadius.circular(5)),
                            child: Center(child: Text("Create User",style: TextStyle(fontSize: 20 ))),
                            ),
                          )),
                      // ElevatedButton(
                      //   onPressed: () async {
                      //     controller.goto();
                      //     // Get.to(LoginPage());
                      //   },
                      //   child: Text("Create User"),
                      // ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
        shape: CircleBorder(),
        child: Icon(Icons.edit),
      ),
    );
  }

  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = RegExp(p);

    return regExp.hasMatch(em);
  }
}
