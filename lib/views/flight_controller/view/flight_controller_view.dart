
import 'package:capstone_project/core/base/view/base_widget.dart';
import 'package:capstone_project/core/components/control_pad/control_pad.dart';
import 'package:capstone_project/core/components/control_pad/views/joystic_view.dart';
import 'package:capstone_project/views/flight_controller/view_model/flight_controller_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class FlightController extends StatefulWidget {
  @override
  _FlightControllerState createState() => _FlightControllerState();
}

class _FlightControllerState extends State<FlightController> {
  late JoystickViewUpdated leftJoystick;
  JoystickView rightJoystick = JoystickView(size: 120,);
  GlobalKey _keyRed = GlobalKey<_FlightControllerState>();
  @override
  Widget build(BuildContext context) {
    
    MediaQueryData queryData = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: BaseView<FlightControllerViewModel>(viewModel: FlightControllerViewModel(), 
        onPageBuilder: (BuildContext context, FlightControllerViewModel model){
          return Stack(
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.green),
          ),
          Row(children: [
            leftJoystick,
            Expanded(child: Container()),
            rightJoystick,
          //  GestureDetector(
          //         child: Container(
          //               height: queryData.size.height*0.65,
          //               width: queryData.size.width*0.33, 
          //               decoration: BoxDecoration(color: Colors.red[900]),
          //               //decoration: BoxDecoration(color: Colors.transparent),
          //               ),
          //         onTapDown: (TapDownDetails tapDownDetails){
          //           RenderBox renderBox = context.findRenderObject() as RenderBox;
          //           model.setPositionLeft(renderBox, tapDownDetails.globalPosition);

          //         },
          //         onPanUpdate: (DragUpdateDetails details){
          //           print(details.globalPosition);
          //         },
          //   ),
            // Expanded(child: Container()),
          ],),
           
        ],);
        }, onModelReady: (model){
          model.setContext(context);
          model.init();
          leftJoystick = new JoystickViewUpdated(size: 120,onDirectionChanged: model.onDirectionChangedLeft,flightControllerViewModel: model,);
        })
    );
  }
  @override
  void initState(){

    super.initState();
    
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
    ]);
    //WidgetsBinding.instance!.addPostFrameCallback(_afterLayout);

  }

 _afterLayout(_) {
     //renderBox = _keyRed.currentContext!.findRenderObject() as RenderBox;
  }
}
