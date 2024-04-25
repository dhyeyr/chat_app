import 'package:chat_app/model/fs_model.dart';
import 'package:chat_app/view/home%20screens/Home_Page.dart';
import 'package:chat_app/view/login_screen/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'firebase_options.dart';

// FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // InitializationSettings settings =
  // const InitializationSettings(android: AndroidInitializationSettings("ic_notification"));
  //
  // await flutterLocalNotificationsPlugin.initialize(settings);
  // flutterLocalNotificationsPlugin
  //     .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
  //     ?.requestNotificationsPermission();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var cu = FirebaseAuth.instance.currentUser;
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
        theme: ThemeData.light(), // Default light theme
        darkTheme: ThemeData.dark(), // Default dark theme
        themeMode: ThemeMode.light,
      // home: cu != null ? HomePage() : LoginPage(),
      home: cu != null ? HomePage() : LoginPage(),
    );
  }
}

// void showLocalNotification() {
//   flutterLocalNotificationsPlugin.show(
//     0,
//     "Hello",
//     "Good morning",
//     NotificationDetails(
//       android: AndroidNotificationDetails(
//         "chat_app",
//         "chat_app",
//         priority: Priority.max,
//         importance: Importance.max,
//       ),
//     ),
//   );
// }

// void showLocalNotification2() {
//   flutterLocalNotificationsPlugin.zonedSchedule(
//     0,
//     "Hello",
//     "Good morning",
//     TZDateTime(),
//     NotificationDetails(
//       android: AndroidNotificationDetails(
//         "GROUP",
//         "GROUP",
//         priority: Priority.max,
//         importance: Importance.max,
//       ),
//     ),
//   );
// }
