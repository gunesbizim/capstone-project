
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:capstone_project/views/flight_controller/view/flight_controller_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TransitionView extends StatefulWidget {
  @override
  _TransitionViewState createState() => _TransitionViewState();
}

class _TransitionViewState extends State<TransitionView> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: AnimatedSplashScreen.withScreenFunction(
        splash: SizedBox(
          width: 300.0,
          child: FittedBox(
            child: Image.asset('assets/images/launch_image.gif'),
            fit: BoxFit.fitWidth,
          ),
        ),
        duration: 3000,
        screenFunction: () async {
          return FlightController();
        },
    ));
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);
  }
}