
import 'package:capstone_project/services/navigation/navigation_route.dart';
import 'package:capstone_project/services/navigation/navigation_service.dart';
import 'package:capstone_project/views/flight_controller/view/flight_controller_view.dart';
import 'package:capstone_project/views/flight_controller/view/transition_view.dart';
import 'package:capstone_project/views/hompage/view/home_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
} 


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "Roboto",
      ),
      home: TransitionView(),
      onGenerateRoute: NavigationRoute.instance.generateRoute,
      navigatorKey: NavigationService.instance.navigatorKey,
    );
  }


}
