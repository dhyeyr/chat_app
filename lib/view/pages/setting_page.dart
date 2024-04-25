// import 'dart:convert';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import 'login_screen/login_page.dart';
//
// /// Flutter code sample for [SliverAppBar].
//
//
//
// class SliverAppBarExample extends StatefulWidget {
//   const SliverAppBarExample({super.key});
//
//   @override
//   State<SliverAppBarExample> createState() => _SliverAppBarExampleState();
// }
//
// class _SliverAppBarExampleState extends State<SliverAppBarExample> {
//   bool _pinned = true;
//   bool _snap = false;
//   bool _floating = false;
//   var user = FirebaseAuth.instance.currentUser;
//
// // [SliverAppBar]s are typically used in [CustomScrollView.slivers], which in
// // turn can be placed in a [Scaffold.body].
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomScrollView(
//         slivers: <Widget>[
//           const SliverAppBar(
//             pinned:true,
//             snap: true,
//             floating: true,
//             expandedHeight: 300.0,
//             flexibleSpace: FlexibleSpaceBar(
//               title: StreamBuilder<DocumentSnapshot>(
//                   stream: FirebaseFirestore.instance
//                       .collection("user")
//                       .doc(user?.uid)
//                       .snapshots(),
//                   builder: (context, snapshot) {
//                     if (snapshot.hasError && snapshot.data != null) {
//                       return Text("Error ${snapshot.error}");
//                     } else if (snapshot.data != null && snapshot.hasData) {
//                       var data = snapshot.data?.data() as Map<String, dynamic>?;
//
//                       return Column(
//                         children: [
//                           ListTile(
//                             leading: CircleAvatar(
//                                 radius: 24,
//                                 child: Container(
//                                   clipBehavior: Clip.antiAlias,
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(30)),
//                                   child:
//                                   ("${data?["image"]}").startsWith("https://")
//                                       ? Image.network(
//                                     ("${data?["image"]}"),
//                                     fit: BoxFit.fitWidth,
//                                   )
//                                       : Image.memory(
//                                       base64Decode("${data?["image"]}"),
//                                       width: double.infinity,
//                                       fit: BoxFit.cover),
//                                 )),
//                             title: Text(
//                               "${data?["name"] ?? ""}",
//                               style: TextStyle(fontWeight: FontWeight.w700),
//                             ),
//                           ),
//                           InkWell(
//                             onTap: () {
//                               Get.to(LoginPage());
//                             },
//                             child: ListTile(
//                               leading: Icon(Icons.add, size: 30),
//                               title: Text(
//                                 "Add Account",
//                                 style: TextStyle(fontWeight: FontWeight.w700),
//                               ),
//                             ),
//                           ),
//                           Divider(indent: 20,endIndent: 20,)
//                         ],
//                       );
//                     } else {
//                       return Center(child: CircularProgressIndicator());
//                     }
//                   })
//               // Row(
//               //   children: [
//               //     Icon(Icons.people),
//               //     Text('NAME'),
//               //   ],
//               // ),
//
//               // background: FlutterLogo(),
//             ),
//           ),
//           const SliverToBoxAdapter(
//             child: SizedBox(
//               height: 20,
//               child: Center(
//                 child: Text('Scroll to see the SliverAppBar in effect.'),
//               ),
//             ),
//           ),
// SliverList(
//   delegate: SliverChildBuilderDelegate(
//         (BuildContext context, int index) {
//       return Container(
//         color: index.isOdd ? Colors.white : Colors.black12,
//         height: 100.0,
//         child: Center(
//           child:
//           Text('$index', textScaler: const TextScaler.linear(5)),
//         ),
//       );
//     },
//     childCount: 20,
//   ),
// ),
//         ],
//       ),
//
//     );
//   }
// }

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/theme_controller.dart';
import '../login_screen/login_page.dart';

class SliverAppBarExample extends StatefulWidget {
  const SliverAppBarExample({Key? key}) : super(key: key);

  @override
  State<SliverAppBarExample> createState() => _SliverAppBarExampleState();
}

class _SliverAppBarExampleState extends State<SliverAppBarExample> {
  final ThemeController _themeController = Get.put(ThemeController());
  bool _pinned = true;
  bool _snap = false;
  bool _floating = false;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: _themeController.appBarColor.value,
            pinned: true,
            snap: _snap,
            floating: _floating,
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
                title: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("user")
                  .doc(user?.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data == null) {
                  return Text("User data not found");
                }

                var data = snapshot.data!.data() as Map<String, dynamic>?;

                if (data == null) {
                  return Text("User data is null");
                }

                // Determine the image source and create the appropriate ImageProvider
                ImageProvider<Object>? backgroundImage;
                String? imageUrl = data["image"] as String?;

                if (imageUrl != null && imageUrl.startsWith("https://")) {
                  // Image is a network URL
                  backgroundImage = NetworkImage(imageUrl);
                } else if (imageUrl != null && imageUrl.isNotEmpty) {
                  // Image is a base64-encoded string
                  backgroundImage = MemoryImage(base64Decode(imageUrl));
                } else {
                  // Default placeholder image or null if no valid image source
                  backgroundImage = null; // Or use a placeholder image here
                }

                return Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: backgroundImage,
                    ),
                    SizedBox(
                      width: 10,
                    ),

                    // Container(
                    //   // height: 20,
                    //
                    //   child: Padding(
                    //     padding: const EdgeInsets.only(right: 13.0),
                    //     child: Text(
                    //       data["name"] ?? "",
                    //       overflow: TextOverflow.ellipsis,
                    //       // style: TextStyle(overflow: TextOverflow.visible),
                    //
                    //     ),
                    //   ),
                    // ),
                    Expanded(
                      child: Text(
                        data["name"] ?? "",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Divider(indent: 20, endIndent: 20),
                  ],
                );
              },
            )),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              const <Widget>[
                ListTile(
                  title: Text("Account"),
                ),
                ListTile(
                  leading: Text("+91"),
                  title: Text('9510558348'),
                  // subtitle: Text('sunny, h: 80, l: 65'),
                ),
                ListTile(
                  // leading: Text("None"),
                  title: Text('None'),
                  subtitle: Text('User Name'),
                ),
                ListTile(
                  // leading: Text("None"),
                  title: Text('Bio'),
                  subtitle: Text('Add a few words about your self'),
                ),
                ListTile(
                  // leading: Text("None"),
                  title: Divider(),
                  // subtitle: Text('Add a few words about your self'),
                ),
                ListTile(
                  // leading: Text("None"),
                  title: Text("Settings"),

                  // subtitle: Text('Add a few words about your self'),
                ),
                ListTile(
                  leading: Icon(Icons.chat_outlined),
                  title: Text('Chat Settings'),
                  // subtitle: Text('sunny, h: 80, l: 65'),
                ),
                ListTile(
                  leading: Icon(Icons.lock_outlined),
                  title: Text('Privacy And Security'),
                  // subtitle: Text('sunny, h: 80, l: 65'),
                ),
                ListTile(
                  leading: Icon(Icons.notifications_none_sharp),
                  title: Text('Notification And Sounds'),
                  // subtitle: Text('sunny, h: 80, l: 65'),
                ),
                ListTile(
                  leading: Icon(Icons.sd_storage_outlined),
                  title: Text('Data And Storage'),
                  // subtitle: Text('sunny, h: 80, l: 65'),
                ),
                ListTile(
                  leading: Icon(Icons.battery_3_bar_outlined),
                  title: Text('Power Saving'),
                  // subtitle: Text('sunny, h: 80, l: 65'),
                ),
                ListTile(
                  leading: Icon(Icons.folder_outlined),
                  title: Text('Chat Folder'),
                  // subtitle: Text('sunny, h: 80, l: 65'),
                ),
                ListTile(
                  leading: Icon(Icons.devices_sharp),
                  title: Text('Devices'),
                  // subtitle: Text('sunny, h: 80, l: 65'),
                ),
                ListTile(
                  leading: Icon(Icons.language),
                  title: Text('Languages'),
                  // subtitle: Text('sunny, h: 80, l: 65'),
                ),
                // ListTiles++
              ],
            ),
          ),
        ],
      ),
    );
  }

// Widget _buildUserDetails(User? user) {
//   if (user == null) {
//     // User is not authenticated, show login button
//     return Center(
//       child: ElevatedButton(
//         onPressed: () {
//           Get.to(LoginPage());
//         },
//         child: Text('Log In'),
//       ),
//     );
//   } else {
//     // User is authenticated, show user details
//     return StreamBuilder<DocumentSnapshot>(
//       stream: FirebaseFirestore.instance
//                     .collection("user")
//                     .doc(user.uid)
//                     .snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return Text("Error: ${snapshot.error}");
//         }
//
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         }
//
//         if (!snapshot.hasData || snapshot.data == null) {
//           return Text("User data not found");
//         }
//
//         var data = snapshot.data!.data() as Map<String, dynamic>?;
//
//         if (data == null) {
//           return Text("User data is null");
//         }
//
//         // Determine the image source and create the appropriate ImageProvider
//         ImageProvider<Object>? backgroundImage;
//         String? imageUrl = data["image"] as String?;
//
//         if (imageUrl != null && imageUrl.startsWith("https://")) {
//           // Image is a network URL
//           backgroundImage = NetworkImage(imageUrl);
//         } else if (imageUrl != null && imageUrl.isNotEmpty) {
//           // Image is a base64-encoded string
//           backgroundImage = MemoryImage(base64Decode(imageUrl));
//         } else {
//           // Default placeholder image or null if no valid image source
//           backgroundImage = null; // Or use a placeholder image here
//         }
//
//         return Row(
//           children: [
//             ListTile(
//               leading: CircleAvatar(
//                 radius: 24,
//                 backgroundImage: backgroundImage,
//               ),
//               title: Text(
//                 data["name"] ?? "",
//                 style: TextStyle(fontWeight: FontWeight.w700),
//               ),
//             ),
//             Divider(indent: 20, endIndent: 20),
//           ],
//         );
//       },
//     );
//   }
// }
}
