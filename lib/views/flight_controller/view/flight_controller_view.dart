
import 'package:capstone_project/core/base/view/base_widget.dart';
import 'package:capstone_project/core/components/control_pad/control_pad.dart';
import 'package:capstone_project/views/flight_controller/view_model/flight_controller_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FlightController extends StatefulWidget {
  @override
  _FlightControllerState createState() => _FlightControllerState();
}

class _FlightControllerState extends State<FlightController> {
  JoystickView leftJoystick = new JoystickView();
  JoystickView rightJoystick = new JoystickView();


  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.white),
          ),
          Row(children: [
            BaseView<FlightControllerViewModel>(
              viewModel: FlightControllerViewModel(), 
              onPageBuilder: (BuildContext context, FlightControllerViewModel model){
                return GestureDetector(
                  child: Container()
                  );
              }, onModelReady: (model){
                model.setContext(context);
                model.init();
              }),
            Expanded(child: Container(height: queryData.size.height,width: 50, decoration: BoxDecoration(color: Colors.red),)),
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