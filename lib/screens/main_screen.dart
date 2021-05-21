import 'package:capstone_project/widgets/profile_picture.dart';
import 'package:flutter/material.dart';

import 'package:capstone_project/constant_data/app_colors.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  static const 
  String _ppURL = "https://teknokupur.net/wp-content/uploads/2020/07/4-2-scaled.jpg";
  String _usersName = "Robert Downey Jr.";
  String _flightTime = "30M 00S" ;
  //TODO: update _isValidURL
  bool _isValidURL = true;
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.backgroundGradient,
      ),
      child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(//profile picture, first row
                children: [
                  Row(//left wing image
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.asset('assets/images/left_wing.png'),
                    ],
                  ),
                  _isValidURL? ProfilePicture(ppURL: "", screenHeight: queryData.size.height): Container(), //if user hasa pp, display it otherwise display add picture
                  Row(//right wing image
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset('assets/images/left_wing.png'),
                    ],
                  )

                ],
              ),
              Column(//Name and flight time, second row
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(_usersName),
                  Text("Flight Time: ${_flightTime}")
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 Card(
                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(30),bottomRight: Radius.circular(30))),
                   elevation: 4,
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: [
                       
                     ],
                   ),
                 ),
                  SizedBox(),
                  
                ],
              ),
              Row(),

            ],),
        ),
    );
  }
}
