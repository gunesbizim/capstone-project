
import 'package:capstone_project/core/base/view/base_widget.dart';
import 'package:capstone_project/core/components/control_pad/control_pad.dart';
import 'package:capstone_project/views/flight_controller/view_model/flight_controller_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class FlightController extends StatefulWidget {
  @override
  _FlightControllerState createState() => _FlightControllerState();
}

class _FlightControllerState extends State<FlightController> {
  JoystickView leftJoystick = new JoystickView(size: 120);
  JoystickView rightJoystick = new JoystickView(size: 120);
  GlobalKey _keyRed = GlobalKey();

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    RenderBox box = context.findRenderObject() as RenderBox;
    print(box);
    return Scaffold(
      appBar: AppBar(),
      body: BaseView<FlightControllerViewModel>(viewModel: FlightControllerViewModel(), 
        onPageBuilder: (BuildContext context, FlightControllerViewModel model){
          return Stack(
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.white),
          ),
          Row(children: [
           GestureDetector(
                  child: Container(
                    height: queryData.size.height*0.65,
                    width: queryData.size.width*0.33, 
                    decoration: BoxDecoration(color: Colors.red),
                    ),
                  onTapDown: (TapDownDetails tapDownDetails){
                    print("---------------");
                    print('${tapDownDetails.globalPosition}');
                    print("---------------");
                    model.setPosition(box, tapDownDetails.globalPosition);
                  },
            ),
            Expanded(child: Container()),
            JoystickView(size: 150,),
          ],),
          Observer(builder: (_){
                      return Positioned(

                        left: model.x,
                        bottom: model.y,
                        child: leftJoystick,);
                    }),
        ],);
        }, onModelReady: (model){
          model.setContext(context);
          model.init();
        })
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