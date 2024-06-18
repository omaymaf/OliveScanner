import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:project_olivier/Pages/Scan_Olive.dart';
import 'package:project_olivier/features/app/splash_screen/splash_screen.dart';
import 'package:project_olivier/features/user_auth/presentation/pages/home_page.dart';
import 'package:project_olivier/features/user_auth/presentation/pages/login_page.dart';
import 'package:project_olivier/features/user_auth/presentation/pages/sign_up_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyBp1ecwddzNJNMTQv-DlEBhMSkqAc-0jtU",
        appId: "1:1067218382988:web:a67d46cd3ba0965247cba9",
        messagingSenderId: "1067218382988",
        projectId: "scannerolives",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Olivier Scanner',
        routes: {
        '/': (context) => SplashScreen(
        // Here, you can decide whether to show the LoginPage or HomePage based on user authentication
     //   child: LoginPage(),
        ),
        '/login': (context) => LoginPage(),
        '/signUp': (context) => SignUpPage(),
        '/home': (context) => HomePage(),
        },
    );
  }
}
