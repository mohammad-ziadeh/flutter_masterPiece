import 'package:flutter/material.dart';
import 'package:masterpiece_flutter/pages/login.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      navigateRoute: Login(),
      duration: 8000,
      imageSize: 230,
      imageSrc: "assets/images/logo.png",
      textType: TextType.ColorizeAnimationText,
      textStyle: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
      colors: [Colors.white, Colors.white, Color(0xFF8D77AB)],
      backgroundColor: Color(0xFF3B1E54),
    );
  }
}
