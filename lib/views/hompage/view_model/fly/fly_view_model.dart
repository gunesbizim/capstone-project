import 'dart:async';

import 'package:capstone_project/core/base/model/base_view_model.dart';
import 'package:capstone_project/core/constants/values/route_constants.dart';
import 'package:capstone_project/services/navigation/navigation_service.dart';
import 'package:capstone_project/views/hompage/view_model/drone/drone_connection_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:mobx/mobx.dart';
part 'fly_view_model.g.dart';

class FlyViewModel = _FlyViewModelBase with _$FlyViewModel;

abstract class _FlyViewModelBase  with BaseViewModel, Store {  

  
  @observable
  String flyButtonText = "FLY";

  late final DroneConnectionViewModel droneConnectionViewModel;
  @override
  void setContext(context) => this.context = context;

  @override
  void init() {
  }


  void setDroneConnectionViewModel(DroneConnectionViewModel droneConnectionViewModel){
    this.droneConnectionViewModel = droneConnectionViewModel;
  }

  @computed
  bool get isConnected => droneConnectionViewModel.isConnected;

  @observable
  bool isStarting = false;

  late Timer _timer;

  @observable
  int start = 3;

  @action
  void startFlight(){
    setIsStarting();
    startTimer();
  }
  
  @action
  void setFlightButtonText(String text){
    flyButtonText = text;
  }

@action
 void setIsStarting(){
   isStarting = !isStarting;
   
 }
 void breakStartFlight(){
   setIsStarting();
   _timer.cancel();
   start = 3;
   ScaffoldMessenger.of(this.context!).showSnackBar(SnackBar(content: Text("Flight canceled"),));
 }

@action
void startTimer() {
  const oneSec = const Duration(seconds: 1);
  _timer = new Timer.periodic(
    oneSec,
    (Timer timer) {
      print("Remaining: $start");
      if (start == 0) {
        timer.cancel(); 
        NavigationService.instance.navigateToPageClear(path: RouteConstants.FLIGHT_CONTROLLER,data: []);
      } else {
        start--;
      }
    },
  );
  }

}