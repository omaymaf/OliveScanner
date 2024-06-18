import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:project_olivier/features/user_auth/presentation/pages/login_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splashIconSize: 300,
      backgroundColor: Colors.white,
      pageTransitionType: PageTransitionType.leftToRight,
      splashTransition: SplashTransition.rotationTransition,
      splash: ClipOval(
        child: Image.asset(
          "assets/images/Logo.jpg",
          fit: BoxFit.cover, // Adjust this if needed
        ),
      ),
      nextScreen: const LoginPage(),
      duration: 5000,
      animationDuration: const Duration(seconds: 5),
    );
  }
}
