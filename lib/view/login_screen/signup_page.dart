import 'dart:convert';
import 'dart:io';

import 'package:chat_app/view/login_screen/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/image_controller.dart';
import '../../controller/sign_controller.dart';
import '../../model/fs_model.dart';
import '../../model/login&sign_model.dart';
import '../home screens/Home_Page.dart';

class Sign_up extends StatefulWidget {
  const Sign_up({super.key});

  @override
  State<Sign_up> createState() => _LoginPageState();
}

class _LoginPageState extends State<Sign_up> {
  final SignupController controller = Get.put(SignupController());
  final ImageController controller1 = Get.put(ImageController());
  final _obscureText = true.obs; // Obx for reactive state management
  late AddUserModel userModel = AddUserModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registration",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue)),
        centerTitle: true,
      ),
        body: SingleChildScrollView(
          child: Container(
            child: Form(
              key: controller.globalKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(

                    alignment: Alignment.topCenter,
                    margin: EdgeInsets.only(top: 30),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Center(
                        child: Column(
                      children: [
                        Obx(
                          () => CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.black12,
                            backgroundImage: filepath.isNotEmpty
                                ? FileImage(File(filepath.value))
                                : null,
                            child: filepath.isEmpty
                                ? IconButton(
                                    onPressed: () {
                                      pickImage(true);
                                    },
                                    icon: Icon(
                                      Icons.camera_alt_rounded,
                                    ),
                                  )
                                : SizedBox.shrink(),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            pickImage(false);
                          },
                          child: Text("Edit Picture"),
                        ),
                      ],
                    )),
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                      controller: userModel.fname,
                      decoration: const InputDecoration(
                          labelText: "Enter Your Full Name",
                          border: OutlineInputBorder()),
                      keyboardType: TextInputType.name,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
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
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: TextFormField(
                      controller: userModel.email,
                      decoration: const InputDecoration(
                          labelText: "Email", border: OutlineInputBorder()),
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
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
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
                              _obscureText.toggle(); // Toggle password visibility
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
                  const SizedBox(
                    height: 50,
                  ),

                  Text(
                    "New User ?",
                    style: TextStyle(fontSize: 17),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      controller.goto();
                      // Get.to(LoginPage());
                    },
                    child: Text("Signup Now"),
                  ),
                ],
              ),
            ),
          ),
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
