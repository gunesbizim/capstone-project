
import 'package:capstone_project/core/base/view/base_widget.dart';
import 'package:capstone_project/core/components/fly_button.dart';
import 'package:capstone_project/core/components/home_button.dart';
import 'package:capstone_project/core/components/profile_picture.dart';
import 'package:capstone_project/core/constants/app_colors.dart';
import 'package:capstone_project/core/constants/route_constants.dart';
import 'package:capstone_project/services/navigation/navigation_service.dart';
import 'package:capstone_project/views/authentication/login/view_model/login_view_model.dart';
import 'package:capstone_project/views/hompage/view_model/log/flightlog_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

class HomeView extends StatelessWidget {
  static const String _ppURL =
      "https://teknokupur.net/wp-content/uploads/2020/07/4-2-scaled.jpg";
  String _usersName = "Robert Downey Jr.";
  String _flightTime = "30M 00S";
  //TODO: update _isValidURL
  bool _isValidURL = true;

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    print(queryData.size.height);
    return buildBaseContainer(context, queryData);
  }

  Container buildBaseContainer(BuildContext ctx, MediaQueryData queryData) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.backgroundGradient,
      ),
      child: buildScaffold(ctx, queryData),
    );
  }

  Scaffold buildScaffold(BuildContext context, MediaQueryData queryData) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.red.shade900 ,
        foregroundColor: Colors.transparent,

        actions: <Widget>[GestureDetector(child: Icon(Icons.logout_sharp,color: Colors.white,))],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: buildProfilePictureRow(queryData),
          ),
          buildUserNameFlightTime(),
          buildThirdRow(context,queryData),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [FlightButton()],
          ),
          HomeButton(),
        ],
      ),
    );
  }

  Row buildThirdRow(BuildContext context, MediaQueryData queryData) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        buildConnectedDroneCard(queryData),
        SizedBox(width: queryData.size.width * 0.10),
        buildLasFlightCard(context,queryData)
      ],
    );
  }

  Card buildConnectedDroneCard(MediaQueryData queryData) {
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), bottomRight: Radius.circular(30))),
      elevation: 4,
      child: Container(
          padding: EdgeInsets.zero,
          height: queryData.size.height * 0.24,
          width: queryData.size.width * 0.45,
          decoration: BoxDecoration(
              gradient: AppColors.connectedDroneGradient,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  bottomRight: Radius.circular(30))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              
            ],
          )),
    );
  }

  Card buildLasFlightCard(BuildContext context, MediaQueryData queryData) {
    print(queryData.size.width);
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), bottomLeft: Radius.circular(30))),
      elevation: 4,
      child: Container(
          height: queryData.size.height * 0.24,
          width: queryData.size.width * 0.45,
          decoration: BoxDecoration(
              gradient: AppColors.lastFlighGradient,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomLeft: Radius.circular(30))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BaseView<FlightLogViewModel>(//!Flight Log View Model initializaion
                 viewModel: FlightLogViewModel(), 
                 onPageBuilder: (BuildContext context, FlightLogViewModel value){
                   return lastFlightObserver(context,value);
                 },
                 onModelReady: (model){
                   model.setContext(context);
                   model.init();

                 })            
              ],
          )
          ),
    );
  }

  Observer lastFlightObserver(BuildContext context, FlightLogViewModel value){
    return Observer(
                     builder: (_){
                       return Column(
                         children: [
                           const Text("Last Flight", style: TextStyle(color: Colors.white,fontWeight: FontWeight.w100,fontSize: 35)),
                           Text(value.lastFlight,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w100,fontSize: 24),),
                           buildSeeAllFlights(value)
                         ],
                       );
                     }
                   );
  }
  Observer buildSeeAllFlights(FlightLogViewModel flightLogWiewModel) {
      return Observer(
        builder: (_){
          return Container(
                  height: 20,
                  width: 100,
                  child: Material(
                    borderRadius:
                        BorderRadius.all(Radius.circular(30)),
                    color: AppColors.primaryBlue,
                    child: InkWell(
                      borderRadius:
                          BorderRadius.all(Radius.circular(30)),
                      child: Center(
                        child: Text("See All",
                        style: TextStyle(color: Colors.white,fontWeight: FontWeight.w100,fontSize: 20,),),
                      ),
                      onTap: flightLogWiewModel.isLoading?
                        null:
                        () {
                          flightLogWiewModel.loadList();
                        },
                    ),
                  ),
                );
        },
      );
  }
  Column buildUserNameFlightTime() {
    return Column(
      //Name and flight time, second row
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Text(_usersName), Text("Flight Time: ${_flightTime}")],
    );
  }

  Row buildProfilePictureRow(MediaQueryData queryData) {
    return Row(
      //profile picture, first row
      children: [
        Row(
          //left wing image
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image(
                image: AssetImage('assets/images/left_wing.png'),
                //TODO: Calculate it in another way.
                height: queryData.size.width * 0.32 * 1.05,
                width: queryData.size.width * 0.32),
          ],
        ),
        _isValidURL
            ? ProfilePicture(ppURL: _ppURL, screenHeight: queryData.size.height)
            : Container(), //if user hasa pp, display it otherwise display add picture
        Row(
          //right wing image
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image(
                image: AssetImage('assets/images/right_wing.png'),
                //TODO: Calculate it in another way.
                height: queryData.size.width * 0.32 * 1.05,
                width: queryData.size.width * 0.32),
          ],
        )
      ],
    );
  }
}
