
import 'package:capstone_project/core/base/view/base_widget.dart';
import 'package:capstone_project/core/components/control_pad/control_pad.dart';
import 'package:capstone_project/core/enums/joystick_type.dart';import 'package:capstone_project/views/flight_controller/view_model/flight_controller_view_model.dart';
import 'package:flutter/material.dart';

class FlightController extends StatelessWidget{
  late JoystickViewUpdated leftJoystick;
  //late JoystickViewUpdated rightJoystick;

  @override
  Widget build(BuildContext context) {
    print("FlightController: Building Widget");
    MediaQueryData queryData = MediaQuery.of(context);
    double screenHeight = queryData.size.height;
    double screenWidth = queryData.size.width;
    double joystickSize = screenHeight *0.35;
    print("FlightController Width: $screenWidth, Height: $screenHeight");
    return Scaffold(
      
      body: BaseView<FlightControllerViewModel>(viewModel: FlightControllerViewModel(), 
        onPageBuilder: (BuildContext context, FlightControllerViewModel model){
          return Stack(
        children: [
          Container(decoration: BoxDecoration(color: Colors.green),),
          Row(children: [
            leftJoystick,
            Expanded(child: Container(decoration: BoxDecoration(color: Colors.transparent),)),
            //rightJoystick
          ],),
           
        ],);
        }, onModelReady: (model){
          model.setContext(context);
          model.init();
          leftJoystick = new JoystickViewUpdated(size: joystickSize,
            onDirectionChanged: model.onDirectionChangedLeft,
            flightControllerViewModel: model,
            joystickType: JoystickType.Movement,
            opacity: 0.25,
            );
          leftJoystick.init();
          // rightJoystick = new JoystickViewUpdated(size: 120, 
          //   onDirectionChanged: model.onDirectionChangedLeft,
          //   flightControllerViewModel: model);
        })
    );
  }
}
