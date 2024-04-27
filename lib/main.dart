import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:travelbuddy/responsive/mobile_screen_layout.dart';
// import 'package:travelbuddy/responsive/resposive_layout_screen.dart';
// import 'package:travelbuddy/responsive/web_screen_layout.dart';
import 'package:travelbuddy/screens/login_screen.dart';
import 'package:travelbuddy/utils/colors.dart';
// import 'package:travelbuddy/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyDmUIsSEDgUkPq9zrsUJRPlOxtmuhsNHyU",
        appId: "1:152258898412:web:24ebd714c9e6178ca978c9",
        messagingSenderId: "152258898412",
        projectId: "travelbuddy-b6e88",
        storageBucket: "travelbuddy-b6e88.appspot.com",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TravelBuddy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark()
          .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
      home: const LoginScreen(),
    );
  }
}
