
import 'package:capstone_project/core/components/control_pad/control_pad.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FlightController extends StatefulWidget {
  @override
  _FlightControllerState createState() => _FlightControllerState();
}

class _FlightControllerState extends State<FlightController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.white),
          ),
          Row(children: [
            JoystickView(size: 150,),
            Expanded(child: Container()),
            JoystickView(size: 150,),
          ],)
        ],),
    );
  }
  @override
  void initState(){
    super.initState();
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
  ]);
}
}