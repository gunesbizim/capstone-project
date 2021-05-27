import 'dart:math';

import 'package:capstone_project/core/base/view/base_widget.dart';
import 'package:capstone_project/core/components/fly_button.dart';
import 'package:capstone_project/core/components/logo.dart';
import 'package:capstone_project/core/components/profile_picture.dart';
import 'package:capstone_project/core/constants/values/app_colors.dart';
import 'package:capstone_project/core/constants/values/text_constants.dart';
import 'package:capstone_project/views/hompage/view_model/app_bar/app_bar_view_model.dart';
import 'package:capstone_project/views/hompage/view_model/drone/drone_connection_view_model.dart';
import 'package:capstone_project/views/hompage/view_model/fly/fly_view_model.dart';
import 'package:capstone_project/views/hompage/view_model/log/flightlog_view_model.dart';
import 'package:capstone_project/views/hompage/view_model/profile/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class HomeView extends StatelessWidget {

  final String filePath = "package:capstone_project/views/hompage/view/home_view.dart:";

  final DroneConnectionViewModel droneConnectionViewModel =
      DroneConnectionViewModel();
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
      appBar: buildAppBar(context, queryData),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildProfileData(context, queryData),
          SizedBox(height: queryData.size.height * 0.013),
          buildCards(context, queryData),
          SizedBox(height: queryData.size.height * 0.08),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BaseView<FlyViewModel>(
                  viewModel: FlyViewModel(),
                  onPageBuilder: (BuildContext context, FlyViewModel model) {
                    return FlightButton(flyViewModel: model);
                  },
                  onModelReady: (model) {
                    model.setContext(context);
                    model.init();
                  })
            ],
          ),
           Expanded(
                        child: Column(
               mainAxisAlignment: MainAxisAlignment.end,
               children: [
                 Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Developed by Exarillion & Ocliptus",
                            style: TextStyle(
                                color: Colors.white, fontWeight: FontWeight.w200),
                          ),
                        ),
               ],
             ),
           )
        ],
      ),
      

    );
  }

 AppBar buildAppBar(BuildContext context, MediaQueryData queryData) {
    
    return AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        leading: Padding(
          padding: EdgeInsets.all(8.0),
          child: SizedBox(width: queryData.size.height * 0.04),
        ),
        centerTitle: true,
        title: ZettLogo(height: queryData.size.height * 0.045),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:BaseView<AppBarViewModel>(
              viewModel: AppBarViewModel(), 
              onPageBuilder: (BuildContext context,AppBarViewModel model){
                return GestureDetector(
                      child: Icon(Icons.logout_sharp,
                          color: Colors.white, size: queryData.size.height * 0.04),
                      onTap: () {
                        print("logging out");
                        model.logOut();
                      },
                    );
                
              } , onModelReady: (model){
                model.setContext(context);
                model.init();
            })
          )
        ],
        elevation: 0,
      );

    
  }

  Row buildProfileData(BuildContext context, MediaQueryData queryData) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      BaseView<ProfileViewModel>(
          viewModel: ProfileViewModel(),
          onPageBuilder: (BuildContext context, ProfileViewModel model) {
            print("$filePath Building Profile Data");
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: buildProfilePictureRow(queryData, model),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 10.0),
                  child: buildUserNameFlightTime(model),
                ),
              ],
            );
          },
          onModelReady: (model) {
            model.setContext(context);
            model.init();
          }),
    ]);
  }

  Observer buildUserNameFlightTime(ProfileViewModel model) {
    print("$filePath Building User's name and Flight Time");
    return Observer(builder: (_){
      return Column(
      //Name and flight time, second row
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          model.userName,
          style: TextConstants.home_screen_24,
        ),
        Text(
          "Flight Time: ${model.flightTime}",
          style: TextConstants.home_screen_14,
        )
      ],
    );
    });
  }

  Row buildCards(BuildContext context, MediaQueryData queryData) {
    print("$filePath Building Cards");
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        buildConnectedDroneCard(context, queryData),
        SizedBox(width: queryData.size.width * 0.10),
        buildLasFlightCard(context, queryData)
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
                  onPageBuilder:
                      (BuildContext context, DroneConnectionViewModel dcvm) {
                    print("$filePath Building connected drone card.");                    
                    return Column(
                      children: [
                        Observer(
                          builder: (_) {

                            print("$filePath Building drone status.");                    

                            return Text(
                            dcvm.status,
                            style: TextConstants.home_screen_24,
                          );
                          },
                        ),
                        Observer(builder: (_) {
                          print("$filePath Building drone status progress indicator.");                    
                          return dcvm.isLoading
                              ? SizedBox(
                                  height: queryData.size.height * 0.026,
                                  width: queryData.size.height * 0.026,
                                  child: CircularProgressIndicator(
                                    backgroundColor: Colors.transparent,
                                    color: AppColors.primaryBlue,
                                    strokeWidth: 2,
                                  ),
                                )
                              : SizedBox(
                                  height: queryData.size.height * 0.026,
                                  width: queryData.size.height * 0.026);
                        }),
                        SizedBox(height: queryData.size.height * 0.034)
                      ],
                    );
                  },
                  onModelReady: (model) {
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
              BaseView<FlightLogViewModel>(
                  //!Flight Log View Model initializaion
                  viewModel: FlightLogViewModel(),
                  onPageBuilder:
                      (BuildContext context, FlightLogViewModel value) {
                    
                    print("$filePath Building last flight card");                    
                    

                    return Column(
                      children: [
                        lastFlightObserver(context, value, queryData),
                      ],
                    );
                  },
                  onModelReady: (model) {
                    model.setContext(context);
                    model.init();
                  })
            ],
          )),
    );
  }

  Observer lastFlightObserver(BuildContext context, FlightLogViewModel value, MediaQueryData queryData) {
    return Observer(builder: (_) {
      print("$filePath Building last flight observer");                    
      return Column(
        children: [
          const Text("Last Flight", style: TextConstants.home_screen_35),
          Text(
            value.lastFlight,
            style: TextConstants.home_screen_24,
          ),
          SizedBox(height: queryData.size.height * 0.03),
          buildSeeAllFlights(value, queryData),
        ],
      );
    });
  }
 
  Observer buildSeeAllFlights(FlightLogViewModel flightLogWiewModel, MediaQueryData queryData) {
    return Observer(
      builder: (_) {
        print("$filePath Building see all flights button");                    
        return Container(
          height: queryData.size.height * 0.034,
          width: queryData.size.width * 0.24,
          child: Material(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            color: AppColors.primaryBlue,
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              child: Center(
                child: Text(
                  "See All",
                  style: TextConstants.home_screen_20,
                ),
              ),
              onTap: flightLogWiewModel.isLoading
                  ? null
                  : () {
                      flightLogWiewModel.loadList();
                    },
            ),
          ),
        );
      },
    );
  }

  Observer buildProfilePictureRow(MediaQueryData queryData, ProfileViewModel profileViewModel) {
    return Observer(
      builder: (BuildContext context) {
        print("$filePath Building Profile Picture Row");
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
