import 'package:capstone_project/core/constants/app_colors.dart';
import 'package:capstone_project/services/navigation/navigation_route.dart';
import 'package:capstone_project/services/navigation/navigation_service.dart';
import 'package:capstone_project/views/authentication/login/view/login_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ZettApp());
}

class ZettApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        splash: SizedBox(
          width: 300.0,
          child: FittedBox(
            child: Image.asset('assets/images/launch_image.gif'),
            fit: BoxFit.fitWidth,
          ),
        ),
        splashTransition: SplashTransition.sizeTransition,
        duration: 3000,
        nextScreen: LoginView(),
      ),
      onGenerateRoute: NavigationRoute.instance.generateRoute,
      navigatorKey: NavigationService.instance.navigatorKey,
    );
  }
}
