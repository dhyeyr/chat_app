import 'package:chat_app/view/login_screen/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../model/fs_model.dart';
import '../home screens/Home_Page.dart';

//keytool -list -v -keystore "C:\Users\dhyey\.android\debug.keystore" -alias androiddebugkey -storepass android -keypass android
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late AddUserModel userModel = AddUserModel();
  // GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  final _obscureText = true.obs; // Obx for reactive state management

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 110,
            ),
            const Text(
              "Your Phone",
              style: TextStyle(fontSize: 35),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
                "Please Confirm Your Country Code \n  And Enter Your Phone Number .",
                style: TextStyle(fontSize: 18)),
            const SizedBox(
              height: 80,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                controller: userModel.email,
                decoration: const InputDecoration(
                    labelText: "Email", border: OutlineInputBorder()),
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
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 40,
              width: 360,
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    UserCredential user = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: userModel.email.text, password: userModel.password.text);
                    print("user Login==> ${user.user}");
                    AddUserModel().addUser(user.user);
                    Get.to(HomePage());
                  } on FirebaseAuthException catch (e) {
                    print(e.code);
                    print(e.message);
                  }

                },
                child: Text(
                  "Login",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            SizedBox(
              height: 140,
            ),
            Text(
              "New User ?",
              style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),
            ),
            InkWell(
                onTap: () async {
                  Get.to(Sign_up());
                },
                child: Text(
                  "Signup Now",
                  style: TextStyle(
                      color: Colors.blueAccent, fontWeight: FontWeight.bold),
                )),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Divider(endIndent: 20,indent: 20,thickness: 1.7,),
            ),
            InkWell(
                onTap: () async {
                  var cu = FirebaseAuth.instance.currentUser;
                  print(cu);


                  if (cu != null) {
                    print("Already Login");
                  } else {
                    var google = await GoogleSignIn().signIn();
                    var auth = await google?.authentication;
                    var credential = GoogleAuthProvider.credential(
                        accessToken: auth?.accessToken, idToken: auth?.idToken);
                    var data = await FirebaseAuth.instance
                        .signInWithCredential(credential);
                    print(data);
                    AddUserModel().addUser(data.user);
                    print(google?.displayName);
                    print(google?.photoUrl);
                    print("object $google");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  }
                },
                child: Image(
                  image: AssetImage("assets/google.png"),
                  width: 35,
                  height: 35,
                )),
    Text("Signin With Google",style: TextStyle(fontWeight: FontWeight.w500),)
          ],
        ),
      ),
    );
  }
}
