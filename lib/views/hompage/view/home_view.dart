import 'package:capstone_project/core/components/fly_button.dart';
import 'package:capstone_project/core/components/profile_picture.dart';
import 'package:capstone_project/core/constants/app_colors.dart';
import 'package:flutter/material.dart';


class HomeView extends StatelessWidget {
  static const 
  String _ppURL = "https://teknokupur.net/wp-content/uploads/2020/07/4-2-scaled.jpg";
  String _usersName = "Robert Downey Jr.";
  String _flightTime = "30M 00S" ;
  //TODO: update _isValidURL
  bool _isValidURL = true;



  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    return buildBaseContainer(context, queryData);
  }

  Container buildBaseContainer(BuildContext ctx, MediaQueryData queryData) {
    return Container(
    decoration: BoxDecoration(
      gradient: AppColors.backgroundGradient,
    ),
    child: buildScaffold(queryData),
  );
  }

  Scaffold buildScaffold(MediaQueryData queryData) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildProfilePictureRow(queryData),
          buildUserNameFlightTime(),
          buildThirdRow(queryData),
          Row(
            children: [
              FlightButton()
            ],
          ),

        ],),
    );
  }
  Row buildThirdRow(MediaQueryData queryData) {
    return Row(   
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
           buildConnectedDroneCard(queryData),
           SizedBox(width:queryData.size.width*.10),
           buildLasFlightCard(queryData)
          ],
        );
  }
  Card buildConnectedDroneCard(MediaQueryData queryData) {
    return Card(
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(30),bottomRight: Radius.circular(30))),
              elevation: 4,
              child: Container(padding: EdgeInsets.zero,
                height: queryData.size.height*0.24,
                width: queryData.size.width*0.45,
                decoration: BoxDecoration(
                  gradient: AppColors.connectedDroneGradient,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(30),bottomRight: Radius.circular(30))),
                child:Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                    
                ],
              )
            ),
          );
  }
  Card buildLasFlightCard(MediaQueryData queryData) {
    return Card(
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(30),bottomLeft: Radius.circular(30))),
              elevation: 4,
              child: Container(
                height: queryData.size.height*0.24,
                width: queryData.size.width*0.45,
                decoration: BoxDecoration(
                  gradient: AppColors.connectedDroneGradient,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30),bottomLeft: Radius.circular(30))),
                child:Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                    
                ],
              )
            ),
          );
  }
  Column buildUserNameFlightTime() {
    return Column(//Name and flight time, second row
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_usersName),
            Text("Flight Time: ${_flightTime}")
          ],
        );
  }
  Row buildProfilePictureRow(MediaQueryData queryData) {
    return Row(//profile picture, first row
          children: [
            Row(//left wing image
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image(image:AssetImage('assets/images/left_wing.png'),
                //TODO: Calculate it in another way.
                height:queryData.size.width*0.32*1.05 ,width:queryData.size.width*0.32),                ],
            ),
            _isValidURL? ProfilePicture(ppURL: _ppURL, screenHeight: queryData.size.height): Container(), //if user hasa pp, display it otherwise display add picture
            Row(//right wing image
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image(image:AssetImage('assets/images/right_wing.png'),
                 //TODO: Calculate it in another way.
                height:queryData.size.width*0.32*1.05 ,width:queryData.size.width*0.32),
              ],
            )

          ],
        );
  }
}
