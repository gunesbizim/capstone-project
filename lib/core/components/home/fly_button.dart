import 'package:capstone_project/core/base/view/base_widget.dart';
import 'package:capstone_project/core/constants/values/app_colors.dart';
import 'package:capstone_project/core/constants/values/text_constants.dart';
import 'package:capstone_project/views/flight_controller/services/flight_data_service.dart';
import 'package:capstone_project/views/hompage/view_model/drone/drone_connection_view_model.dart';
import 'package:capstone_project/views/hompage/view_model/fly/fly_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class FlightButton extends StatelessWidget {
  final FlyViewModel flyViewModel;

  FlightButton({required this.flyViewModel});


  @override
  Widget build(BuildContext context) {
    MediaQueryData data = MediaQuery.of(context);
    return buildFlightButton(context, data);
  }

  Widget buildFlightButton(BuildContext context, MediaQueryData data) {
    double width = data.size.width;
    double height = data.size.height;
    return Observer(
      builder: (_) => Stack(
        alignment: Alignment.center,
        children: [
          buildWings(),
          Container(
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.white),
            height: height * 0.19,
            width: width * 0.4,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                  customBorder: CircleBorder(),
                  splashColor: AppColors.primaryPurple,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: AppColors.flightButtonGradient,
                      shape: BoxShape.circle,
                    ),
                    child: Observer(
                      builder: (_){
                        return !flyViewModel.isStarting?Text(
                          "FLY",
                          style: TextConstants.home_screen_50,
                        ): Column(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          Text(
                            "ABORT",
                            style: TextConstants.home_screen_35,
                          ),Text(
                            flyViewModel.start.toString(),
                            style: TextConstants.home_screen_35,
                          )
                          ],);
                      } ,)
                  ),
                  onTap: flyViewModel.isConnected
                      ? () {
                        //FlightDataService.instance.generateMockData();
                        if(!flyViewModel.isStarting)
                          flyViewModel.startFlight();
                        else
                          flyViewModel.breakStartFlight();
                      }
                      : () {                        

                          final snackBar = SnackBar(
                              content: Text('Drone is not connected!'));

                          // Find the ScaffoldMessenger in the widget tree
                          // and use it to show a SnackBar.
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }),
            ),
          ),
        ],
      ),
    );
  }

  Column buildWings() {
    return Column(children: <Widget>[
      buildSingleWing(1.0),
      SizedBox(
        height: 15,
      ),
      buildSingleWing(0.88),
      SizedBox(
        height: 15,
      ),
      buildSingleWing(0.76)
    ]);
  }

  Container buildSingleWing(double ratio) {
    return Container(
      width: 351 * ratio, //TODO: change it to dynamic
      height: 22,
      decoration: BoxDecoration(
          gradient: AppColors.wingGradient,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30))),
    );
  }
}
