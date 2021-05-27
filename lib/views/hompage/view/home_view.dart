

import 'dart:math';

import 'package:capstone_project/core/base/view/base_widget.dart';
import 'package:capstone_project/core/components/fly_button.dart';
import 'package:capstone_project/core/components/logo.dart';
import 'package:capstone_project/core/components/profile_picture.dart';
import 'package:capstone_project/core/constants/app_colors.dart';
import 'package:capstone_project/core/constants/text_constants.dart';
import 'package:capstone_project/views/hompage/view_model/drone/drone_connection_view_model.dart';
import 'package:capstone_project/views/hompage/view_model/fly/fly_view_model.dart';
import 'package:capstone_project/views/hompage/view_model/log/flightlog_view_model.dart';
import 'package:capstone_project/views/hompage/view_model/profile/profile_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class HomeView extends StatelessWidget {
  final DroneConnectionViewModel droneConnectionViewModel = DroneConnectionViewModel();
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
        backgroundColor: Colors.transparent ,
        foregroundColor: Colors.transparent,
        leading: Padding(
          padding: EdgeInsets.all(8.0),
          child: SizedBox(
            width:queryData.size.height*0.04
          ),
        ),
        centerTitle: true,
        title: ZettLogo(height:queryData.size.height*0.045),  
        actions: <Widget>[Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(child: Icon(Icons.logout_sharp,color: Colors.white,size:queryData.size.height*0.04)),
        )],
        elevation: 0,
      ),  
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildProfileData(context,queryData),
          SizedBox(height:queryData.size.height*0.013),
          buildThirdRow(context,queryData),
          SizedBox(height:queryData.size.height*0.13),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BaseView<FlyViewModel>(viewModel: FlyViewModel(),
               onPageBuilder: (context, model){
                 return FlightButton(flyViewModel: model);
               },
                onModelReady:(model){
                  model.setContext(context);
                  model.init();
                  model.setDroneConnectionViewModel(this.droneConnectionViewModel);
                })
            ],
          ),
          Expanded(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Developed by Exarillion & Ocliptus",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w200),),
              )]),
          ),
        ],
      ),
    );
  }

  Row buildProfileData(BuildContext context, MediaQueryData queryData) {
    return Row(
      mainAxisAlignment:  MainAxisAlignment.center,
      children:[ BaseView<ProfileViewModel>(
        viewModel: ProfileViewModel(), onPageBuilder: (BuildContext context, ProfileViewModel model){
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: buildProfilePictureRow(queryData,model),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0,bottom:10.0),
                child: buildUserNameFlightTime(model),
              ),
            ],
          );
        }, onModelReady: (model){
          model.setContext(context);
          model.init();

        }),]
    );
  }

  Row buildThirdRow(BuildContext context, MediaQueryData queryData) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        buildConnectedDroneCard(context, queryData),
        SizedBox(width: queryData.size.width * 0.10),
        buildLasFlightCard(context,queryData)
      ],
    );
  }

  Card buildConnectedDroneCard(BuildContext context, MediaQueryData queryData) {
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
              Text("Status", style: TextConstants.home_screen_35),
              BaseView<DroneConnectionViewModel>(
                viewModel: this.droneConnectionViewModel,
                onPageBuilder: (BuildContext context, DroneConnectionViewModel dcvm){
                  return Column(
                      children: [
                        Observer(
                            builder: (_) => Text(dcvm.status,
                            style: TextConstants.home_screen_24,
                            ),
                        ),
                          Observer(builder: (_) {
                            return  dcvm.isLoading?
                                SizedBox(height:queryData.size.height*0.026,
                                width:queryData.size.height*0.026,
                                        
                                  child:CircularProgressIndicator(
                                    backgroundColor: Colors.transparent,
                                    color: AppColors.primaryBlue,
                                    strokeWidth: 2,
                                  ),
                                ):SizedBox(
                                  height:queryData.size.height*0.026,
                                width:queryData.size.height*0.026
                                );
                          }),
                          SizedBox(
                            height:queryData.size.height*0.034
                          )
                      ],
                    );
                },
                onModelReady: (model){
                  model.setContext(context);
                  model.init();
                })
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
                   return Column(
                     children: [
                       lastFlightObserver(context,value, queryData),
                      
                     ],
                   );
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

  Observer lastFlightObserver(BuildContext context, FlightLogViewModel value, MediaQueryData queryData){
    return Observer(
                     builder: (_){
                       return Column(
                         children: [
                           const Text("Last Flight", style: TextConstants.home_screen_35),
                           Text(value.lastFlight,style: TextConstants.home_screen_24 ,),
                           SizedBox(height:queryData.size.height*0.03),
                           buildSeeAllFlights(value,queryData),
                         ],
                       );
                     }
                   );
  }
  Observer buildSeeAllFlights(FlightLogViewModel flightLogWiewModel,MediaQueryData queryData) {
      return Observer(
        builder: (_){
          return Container(
                  height: queryData.size.height*0.034,
                  width: queryData.size.width*0.24,
                  child: Material(
                    borderRadius:
                        BorderRadius.all(Radius.circular(30)),
                    color: AppColors.primaryBlue,
                    child: InkWell(
                      borderRadius:
                          BorderRadius.all(Radius.circular(30)),
                      child: Center(
                        child: Text(
                          "See All",
                          style: TextConstants.home_screen_20,),
                      ),
                      onTap: flightLogWiewModel.isLoading?
                        null:
                        () {
                          // for(int i = 1; i<=31; i++){
                          //   print(i);
                          //   int startHour = 1+Random().nextInt(13);
                          //   int min = 1+Random().nextInt(59);
                          //   int endHour = startHour + Random().nextInt(11);
                          //   var start = DateTime.parse("2020-03-${i>=10?i:"0"+i.toString()} ${startHour>=10?startHour:"0"+startHour.toString()}:${min>=10?min:"0"+min.toString()}:00");
                          //   var end = DateTime.parse("2020-03-${i>=10?i:"0"+i.toString()} ${endHour>=10?endHour:"0"+endHour.toString()}:${min>=10?min:"0"+min.toString()}:00");
                          //   List<String> duration = formatDuration( end.difference(start));
                            
                          //   FirebaseFirestore.instance.collection("flights").add(
                          //   {
                          //     "flightStartTime" : start,
                          //     "flightEndTime" : end,
                          //     "pilotId" : FirebaseAuth.instance.currentUser!.uid,
                          //     "duration" : {
                          //       "hours":duration[0],
                          //       "minutes":duration[1],
                          //       "seconds":duration[2]
                          //     }
                          //   }
                          //   );
                          //   print(i);
                          // }
                          flightLogWiewModel.loadList();
                        },
                    ),
                  ),
                );
        },
      );
  }
  List<String> formatDuration(Duration duration) {
        String twoDigits(int n) => n.toString().padLeft(2, "0");
        String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
        String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));

      return [twoDigits(duration.inHours),twoDigitMinutes,twoDigitSeconds];
      }



  Column buildUserNameFlightTime(ProfileViewModel model) {
    return Column(
      //Name and flight time, second row
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(model.userName, style: TextConstants.home_screen_24,), 
        Text("Flight Time: ${model.flightTime}",style: TextConstants.home_screen_14,)],
    );
  }

  Observer buildProfilePictureRow(MediaQueryData queryData,ProfileViewModel profileViewModel) {
    return Observer(
          builder: (BuildContext context){
            return  Row(
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
                  
                  ProfilePicture(
                    ppURL: profileViewModel.ppURL, 
                    screenHeight: queryData.size.height,
                    hasPP: profileViewModel.hasPP, 
                    selectImage: profileViewModel.selectImage),
                    //ProfilePicture(ppURL: profileViewModel.ppURL, screenHeight: queryData.size.height)
                     //if user hasa pp, display it otherwise display add picture
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
          },
    ); 
  }
}
