import 'dart:async';

import 'package:capstone_project/core/base/model/base_view_model.dart';
import 'package:capstone_project/core/constants/functions/duratio_parser.dart';
import 'package:capstone_project/core/constants/values/app_colors.dart';
import 'package:capstone_project/core/constants/values/route_constants.dart';
import 'package:capstone_project/core/constants/values/text_constants.dart';
import 'package:capstone_project/services/navigation/navigation_service.dart';
import 'package:capstone_project/views/flight_controller/services/flight_data_service.dart';
import 'package:capstone_project/views/flight_controller/services/flight_request_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobx/mobx.dart';
part 'flight_controller_view_model.g.dart';

class FlightControllerViewModel = _FlightControllerViewModelBase with _$FlightControllerViewModel;

abstract class _FlightControllerViewModelBase with Store, BaseViewModel {
  
  @observable
  double leftX = 160;
  @observable
  double leftY = 400;

  @observable
  double rightX = 80;
  @observable
  double rightY = 80;

  @observable
  String flightDuration = "0H:0M:0S";
  
  @observable
  Icon cameraIcon = Icon(Icons.videocam_sharp,color: Colors.white,);

  bool hasVideoStream = false;

  bool isRecording = false;

  late final double _normalLeftX;
  late final double _normalLeftY;
  
  late final double _normalRightX;
  late final double _normalRightY;

  late Timer flightDurationTimer;
  @override
  void setContext(context) => this.context = context;

  late final FlightDataService flightDataService;

  late final FlightRequestService flightRequestService;

  late final NavigationService navigationService;
  late double _screenWidth;
  late double _screenHeight;
  @override
  void init(){
    flightDataService = FlightDataService.instance;
    flightRequestService = FlightRequestService.instance;
    navigationService = NavigationService.instance;
    MediaQueryData queryData = MediaQuery.of(this.context!);
    _screenWidth = queryData.size.width;
    _screenHeight = queryData.size.height;
    _normalLeftX = _screenWidth*0.13;
    _normalLeftY = _screenHeight*0.70;

    _normalRightX = _screenWidth*0.2;
    _normalRightY = _screenHeight*0.70;


    leftX = _normalLeftX;
    leftY = _normalLeftY;

    rightX = _normalRightX;
    rightY = _normalRightY;

    flightDataService.startTimer();
    flightDurationTimer = Timer.periodic(new Duration(seconds:1), (timer) {
      updateTimerUI();
     });
  }

  @action 
  Offset setPositionLeft( Offset localPosition){
    //Offset localPosition = box.globalToLocal(globalPosition);
    leftX = localPosition.dx;
    leftY= localPosition.dy;
    return Offset(leftX,leftY);
  }

  @action
  setPositionToNormalLeft(){
    leftX = _normalLeftX;
    leftY = _normalLeftY;
  }


  @action
  Future<void> onDirectionChangedLeft(double degrees, double distance) async{
    if(degrees==0.0&& distance==0.0){
      setPositionToNormalLeft();
    }
    
    print("directionChangedLeft degrees $degrees");
    print("directionChangedLeft distance $distance");
    flightRequestService.horizontalPlaneMovement(degrees, distance);
  }
  @action
  setPositionToNormalRight(){
    rightX = _normalRightX;
    rightY = _normalRightY;
  }

    @action 
  Offset setPositionRight( Offset localPosition){
    //Offset localPosition = box.globalToLocal(globalPosition);
    rightX = localPosition.dx;
    rightY= localPosition.dy;
    return Offset(rightX,rightY);
  }

  @action
  Future<void> onDirectionChangedRight(double degrees, double distance) async{
    if(degrees==0.0&& distance==0.0){
      setPositionToNormalRight();
    }
    print("directionChangedRight degrees $degrees");
    print("directionChangedRight distance $distance");

  }
  @action
  void updateTimerUI(){
    Duration d = flightDataService.currentTime();
    var parsedDuration = DurationParser.parseDurationToMapHMS(d);
    flightDuration = "${parsedDuration["hours"]}H ${parsedDuration["minutes"]}M ${parsedDuration["seconds"]}S";
  }

  void startVideoRecording(){
    switchRecording();
    cameraIcon = Icon(Icons.fiber_manual_record,color: Colors.red[900],);
    ScaffoldMessenger.of(this.context!).showSnackBar(SnackBar(content: Text("Video recording is started.63221"),duration: Duration(seconds: 1),));
    flightDataService.startRecording();
  }
  
  @action
  void stopVideoRecording() {
    switchRecording();
    cameraIcon = Icon(Icons.videocam_sharp,color: Colors.white,);
    flightDataService.stopRecording();
    ScaffoldMessenger.of(this.context!).showSnackBar(SnackBar(content: Text("Video saved to local storage."),duration: Duration(seconds: 1)));

  }

  void takeSnapshot(){
    flightDataService.takeSnapshot();
    ScaffoldMessenger.of(this.context!).showSnackBar(SnackBar(content: Text("The image is saved to the gallery."),duration: Duration(seconds: 1)));

  }
  void switchRecording(){
    isRecording = !isRecording;
  }
  
  void endFlight() {
    customDialog(content: "Are you sure?",title: "End flight",context: this.context );
  } 
  void _endFlight() {
    
    customLoadingDialog();
    if(isRecording)
      flightDataService.stopRecording();
    flightDataService.saveFlight();
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    navigationService.navigateToPageClear(path:RouteConstants.HOME_PAGE , data:[]);
  }

  void customDialog({BuildContext? context, String? title, String? content}){
    showDialog(
      context: context!, 
        builder: (BuildContext context) => AlertDialog(
        title: Text(title!),
        content: Text(content!),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
                Navigator.pop(context, 'Yes');
                _endFlight();
              },
            child: const Text('Yes'),
          ),
        ],
      )
    );
  }
  void customLoadingDialog(){
    showDialog(
      context: context!, 
        builder: (BuildContext context) => AlertDialog(
        title: Text("Ending the flight"),
        content: Container(width: _screenWidth*0.75 , height: _screenWidth*0.75,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          Text("Ending Flight", style: TextConstants.home_screen_50 ),
          SizedBox(
                                  height: _screenHeight* 0.1,
                                  width: _screenWidth * 0.1,
                                  child: CircularProgressIndicator(
                                    backgroundColor: Colors.transparent,
                                    color: AppColors.primaryBlue,
                                    strokeWidth: 2,
                                  ),
                                )

        ],),),
        actions: [],
      )
    );
  }
}


enum JojystickPosition{
  left,
  rigth
}