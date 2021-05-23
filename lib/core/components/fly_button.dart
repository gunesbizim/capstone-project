import 'package:capstone_project/core/base/view/base_widget.dart';
import 'package:capstone_project/core/constants/app_colors.dart';
import 'package:capstone_project/core/constants/text_constants.dart';
import 'package:capstone_project/views/hompage/view_model/fly/fly_view_model.dart';
import 'package:flutter/material.dart';

class FlightButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<StartFlightViewModel>(
        viewModel: StartFlightViewModel(), //TODO: Tidy up!!
        onPageBuilder: (BuildContext buildContext, StartFlightViewModel value) {
          return buildFlightButton(value);
        },
        onModelReady: (model) {});
  }

  Widget buildFlightButton(StartFlightViewModel startFlightViewModel) {
    return Stack(
      alignment: Alignment.center,
      children: [
        buildWings(),
        Container(
          decoration:
            BoxDecoration(shape: BoxShape.circle, color: Colors.white),
          height: 147,//todo calculate dynamically
          width: 147,
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
                child: Text(
                  "FLY",
                  style: TextConstants.home_screen_50,
                ),
              ),
              onTap: (){

              },
            ),
          ),
        )
      ],
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
