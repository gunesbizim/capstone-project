


import 'dart:async';

import 'package:capstone_project/core/enums/drone_connection_status_type_enum.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';

class DroneConnectionStatusService {

  static final DroneConnectionStatusService instance = DroneConnectionStatusService._init();

  late Function setStatus;
  late Connectivity _connectivity = new Connectivity();
  ConnectivityResult? _result;

  //late final Timer _timer;
  final String = "";

  int counter = 0;
  DroneConnectionStatusService._init();

  void checkStatus() async{
     //_timer  = 
     Timer.periodic(
      Duration(milliseconds: 50),
      (Timer t) async{
        if(counter ==100){
          setStatus(DroneConnectionStatusTypeEnum.SUCCESS,"Hell yeah");
          t.cancel();
        }
        // try {
        //  _result = await _connectivity.checkConnectivity();
        //  setStatus(DroneConnectionStatusTypeEnum.SUCCESS,"hell yeah");
        // } on PlatformException catch (e) {
        //   setStatus(DroneConnectionStatusTypeEnum.ERROR,e.toString());
        // }
        counter++;
      }
    );
     
  }
}