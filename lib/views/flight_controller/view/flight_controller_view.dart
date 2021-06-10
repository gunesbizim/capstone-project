
import 'package:capstone_project/core/base/view/base_widget.dart';
import 'package:capstone_project/core/components/control_pad/control_pad.dart';
import 'package:capstone_project/core/enums/joystick_type.dart';import 'package:capstone_project/views/flight_controller/view_model/flight_controller_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class FlightController extends StatelessWidget{
  late JoystickViewUpdated leftJoystick;
  late JoystickViewUpdated rightJoystick;
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
          model.hasVideoStream ?Container(decoration: BoxDecoration(color: Colors.red),):
          Container(height: screenHeight,
          width: screenWidth, 
          decoration: BoxDecoration(color: Colors.green),child: Center(child: Text("There is no incoming video stream.",style: TextStyle(color: Colors.white,fontSize: 50,),)) ),
          Row(children: [
            leftJoystick,
            Expanded(child: Container(decoration: BoxDecoration(color: Colors.transparent),)),
            rightJoystick
          ],),
           Column(children: [
             SizedBox(height:25),
             Row(
               children: [
                 Observer(builder: (_){
                   return Text(model.flightDuration);
                 }),
                 Expanded(child: Container()),
                 Observer(builder: 
                  (_){
                    return IconButton(onPressed: 
                    model.isRecording?
                    (){
                      model.stopVideoRecording();
                    }
                    :(){
                      model.startVideoRecording();
                    }, icon: model.cameraIcon );
                  }
                 ),IconButton(onPressed: (){
                     model.takeSnapshot();
                  }, icon: Icon(Icons.camera_alt,color: Colors.white,) )
               ],
             )
           ],)
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

            rightJoystick = new JoystickViewUpdated(size: joystickSize,
              onDirectionChanged: model.onDirectionChangedRight,
              flightControllerViewModel: model,
              joystickType: JoystickType.RotationAttitude,
              opacity: 0.25,
            );
          leftJoystick.init();
          rightJoystick.init();

        })
    );
  }
}
