import 'dart:developer';
import 'dart:math';

import 'package:capstone_project/core/constants/functions/duratio_parser.dart';
import 'package:capstone_project/services/fire_store_service.dart';

class FlightDataService{
  FireStoreService _fireStoreService = FireStoreService.instance;
  static final FlightDataService instance = FlightDataService._init();
  FlightDataService._init();

  void generateMockData(){
    for(int i = 1; i<=31; i++){
      print(i);
      print("-------------");
      int start = 1+Random().nextInt(23);
      int end = start + Random().nextInt(23-start);
      int startMin = Random().nextInt(60);
      int endMin = Random().nextInt(60);

      DateTime flightStartTime = DateTime.parse("2020-03-${i>=10?i:"0"+i.toString()} ${start>=10?start:"0"+start.toString()}:${startMin>=10?startMin:"0"+startMin.toString()}:00");
      DateTime flightEndTime = DateTime.parse("2020-03-${i>=10?i:"0"+i.toString()} ${end>=10?end:"0"+end.toString()}:${endMin>=10?endMin:"0"+endMin.toString()}:00");
      Map<String,String> durationString = DurationParser.parseDurationToMapHMS(flightEndTime.difference(flightStartTime));
      _fireStoreService.addFlight(
        flightStartTime: flightStartTime,
        flightEndTime : flightEndTime,
        duration: durationString
      );
      print("-------------");
    }
 

  }
}