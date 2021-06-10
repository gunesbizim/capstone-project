import 'dart:async';

import 'package:capstone_project/core/base/model/base_view_model.dart';
import 'package:capstone_project/core/constants/functions/duratio_parser.dart';
import 'package:capstone_project/views/flight_controller/services/flight_data_service.dart';
import 'package:capstone_project/views/flight_controller/services/flight_request_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  @override
  void init(){
    flightDataService = FlightDataService.instance;
    flightRequestService = FlightRequestService.instance;
    MediaQueryData queryData = MediaQuery.of(this.context!);
    double screenWidth = queryData.size.width;
    double screenHeight = queryData.size.height;
    _normalLeftX = screenWidth*0.13;
    _normalLeftY = screenHeight*0.70;

    _normalRightX = screenWidth*0.2;
    _normalRightY = screenHeight*0.70;


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
    
  }
  
  @action
  void stopVideoRecording() {
    switchRecording();
    cameraIcon = Icon(Icons.videocam_sharp,color: Colors.white,);
    ScaffoldMessenger.of(this.context!).showSnackBar(SnackBar(content: Text("Video saved to local storage."),duration: Duration(seconds: 1)));

  }

  void takeSnapshot(){
    ScaffoldMessenger.of(this.context!).showSnackBar(SnackBar(content: Text("The image is saved to the gallery."),duration: Duration(seconds: 1)));

  }
  void switchRecording(){
    isRecording = !isRecording;
  }
  
}


enum JojystickPosition{
  left,
  rigth
}