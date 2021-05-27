import 'package:capstone_project/core/constants/functions/duratio_parser.dart';
import 'package:capstone_project/services/authentication_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:duration/duration.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FireStoreService {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  static final FireStoreService instance = FireStoreService._init();
  final AuthenticationService authService = AuthenticationService.instance;
  FireStoreService._init();
  FirebaseFirestore get fireStore => _fireStore;
  CollectionReference get pilotsRef => _fireStore.collection("pilots");

  Future<void> setUserData({ 
      required String id,
      required String name,
      required String email,
      String lastFlightId = "",
      String ppURL = "",
      String flightTime = "00:00:00"
      }) async {
    Map<String, String> pilot = {
      "pilotId": id,
      "fullName": name,
      "email": email,
      "lastFlightId": lastFlightId,
      "ppURL": ppURL,
      "flightTime": flightTime
    };
    await pilotsRef.doc(id).set(pilot);
  }

  Future<void> addFlight({ 
    required DateTime flightStartTime,
    required DateTime flightEndTime, 
    required Map<String,String> duration})async {
    
    final CollectionReference flightsRef = _fireStore.collection('flights');
    Map<String, Object> flight = {
      "pilotId": authService.user!.uid,
      "flightStartTime": flightStartTime,
      "flightEndtime": flightEndTime,
      "duration": duration
    }; 
    await flightsRef.add(flight);
  }
  Future<Duration> getFlightTime() async{
    Duration duration = Duration();
    try{
      await pilotsRef.where("id",isEqualTo: authService.user!.uid ).get().then((querySnapshot){
        querySnapshot.docs.forEach((singleUser) {
          duration = Duration(
            hours: int.parse(singleUser["duration"]["hours"]),
            minutes: int.parse(singleUser["duration"]["minutes"]), 
            seconds: int.parse(singleUser["duration"]["seconds"]));
        });
      });
    } on Exception {}
    return duration;
  }
  Future _addDuration(Duration durationToAdd) async {
    await getFlightTime().then((value){ 
      Duration currentDuration = value;
      currentDuration += durationToAdd;
      Map<String,String> finalDuration = DurationParser.parseDurationToMapHMS(currentDuration);
      pilotsRef.doc(authService.user!.uid).update({"flightTime":finalDuration});
     
    });
  }
  Query getLimitedCollection({
    required String collectionName, 
    required String whereField,
    required String orderBy, 
    required bool isDescending, 
    required int limit} ){
    return _fireStore.collection(collectionName).where(whereField, isEqualTo: authService.user!.uid)
        .orderBy(orderBy,descending: isDescending)
        .limit(limit);
  }

  
  Future<Map<String, String>> getUserDetails() async{
    print("**********************USER DETAILS**********************");//hazarcandogabakan@gmail.com
    print("**********************${authService.user!.uid}**********************");
    Map<String, String> result = {
          "userName" : "No User Found!",
          "flightTime" : "00:00:00",
          "ppURL" : ""};

    var userDetails = _fireStore.collection("pilots")
      .where("id",isEqualTo: authService.user!.uid);

    await userDetails.get().then((querySnapshot){
        querySnapshot.docs.forEach((data) {
        result ={
          "userName" : data["fullName"].toString(),
          "flightTime" : parseFlightTime(data["flightTime"]),
          "ppURL" : data["ppURL"].toString()
          };
        });
      });
      print(result);
      return result;
  }
  Future updateField({
    required String collection,
    String doc = "",
    required String field,
    required String value
  }) async {
    if(doc == "") doc = authService.user!.uid;
    _fireStore.collection("pilots").doc(doc).update({field:value});
  }
  String parseFlightTime(Map<String,dynamic> flightTime){
    return "${flightTime["hours"].toString()}H ${flightTime["minutes"].toString()}M ${flightTime["seconds"].toString()}S";
  }
}
