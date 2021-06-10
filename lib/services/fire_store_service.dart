import 'package:capstone_project/core/constants/functions/duratio_parser.dart';
import 'package:capstone_project/services/authentication_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class FireStoreService {
  final String filePath = "FireStoreService:";

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  static final FireStoreService instance = FireStoreService._init();
  final AuthenticationService authService = AuthenticationService.instance;
  FireStoreService._init();
  FirebaseFirestore get fireStore => _fireStore;
  CollectionReference get pilotsRef => _fireStore.collection("pilots");

  Future<void> setUserData(
      {required String id,
      required String name,
      required String email,
      String ppURL = "",
      Map<String,String> flightTime = const {
        "hours":"00",
        "minutes":"00",
        "seconds":"00"
      }}) async {
    Map<String, dynamic> pilot = {
      "pilotId": id,
      "fullName": name,
      "email": email,
      "ppURL": ppURL,
      "flightTime": flightTime
    };
    print("$filePath Setting user data of $id");
    await pilotsRef.doc(id).set(pilot);
  }

  Future<void> addFlight(
      {required DateTime flightStartTime,
      required DateTime flightEndTime,
      required Map<String, String> duration}) async {
    final CollectionReference flightsRef = _fireStore.collection('flights');
    Map<String, Object> flight = {
      "pilotId": authService.user!.uid,
      "flightStartTime": flightStartTime,
      "flightEndtime": flightEndTime,
      "duration": duration
    };
    await flightsRef.add(flight);
    Duration durationToAdd = _parseDurationFromMap(duration["hours"], duration["minutes"], duration["seconds"]);
    await _addDuration(durationToAdd);
  }

  Future<Duration> getFlightTime() async {
    Duration duration = Duration();
    print("----------------------uid");
    print(authService.user!.uid);
    try {
      var ref = pilotsRef.where("id", isEqualTo: authService.user!.uid);
      await ref.get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((singleUser) {
          print("single user duration");
          print(singleUser.data());
          duration = _parseDurationFromMap(singleUser["flightTime"]["hours"],singleUser["flightTime"]["minutes"],singleUser["flightTime"]["seconds"]);
        });
      });
    } on Exception {}
    return duration;
  }

  Duration _parseDurationFromMap(String? hours, String? minutes, String? seconds) {
    print("*************************");
    print(hours);
    print(minutes);
    print(seconds);
    return Duration(
          hours: int.parse(hours!),
          minutes: int.parse(minutes!), 
          seconds: int.parse(seconds!));
  }
  Future _addDuration(Duration durationToAdd) async {

    await getFlightTime().then((value) {
      
      Duration currentDuration = value;
      print(currentDuration);
      currentDuration += durationToAdd;
      Map<String, String> finalDuration =
          DurationParser.parseDurationToMapHMS(currentDuration);
      pilotsRef
          .doc(authService.user!.uid)
          .update({"flightTime": finalDuration});
    });
  }

  Query getLimitedCollection(
      {required String collectionName,
      required String whereField,
      required String orderBy,
      required bool isDescending,
      required int limit}) {
    return _fireStore
        .collection(collectionName)
        .where(whereField, isEqualTo: authService.user!.uid)
        .orderBy(orderBy, descending: isDescending)
        .limit(limit);
  }

  
  Future<Map<String, String>> getUserDetails() async{
    print("$filePath Getting user details from Fire Store");
    Map<String, String> result = {
      "userName": "No User Found!",
      "flightTime": "00:00:00",
      "ppURL": ""
    };

    var userDetails = _fireStore
        .collection("pilots")
        .where("pilotId", isEqualTo: authService.user!.uid);
    print("$filePath getting user details of${authService.user!.uid}");

    await userDetails.get().then((querySnapshot) {
      querySnapshot.docs.forEach((data) {
        result = {
          "userName": data["fullName"].toString(),
          "flightTime": parseFlightTime(data["flightTime"]),
          "ppURL": data["ppURL"].toString()
        };
      });
    });
    print(result);
    return result;
  }

  Future updateField(
      {required String collection,
      String doc = "",
      required String field,
      required String value}) async {
    if (doc == "") doc = authService.user!.uid;
    _fireStore.collection("pilots").doc(doc).update({field: value});
  }

  String parseFlightTime(Map<String, dynamic> flightTime) {
    return "${flightTime["hours"].toString()}H ${flightTime["minutes"].toString()}M ${flightTime["seconds"].toString()}S";
  }

  void getLastFlight(Function setLastFlight){
    String lastFlight = "No Flight";
    var collection = getLimitedCollection(
      collectionName: "flights",
      whereField: "pilotId",
      orderBy: "flightStartTime",
      isDescending: true,
      limit: 1
    );

    collection.get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
            DateTime date = DateTime.parse(element["flightStartTime"].toDate().toString());
            String startString = DateFormat("dd-MM-yyyy").format(date);
            print("###############################33");
            print("start $startString");
            setLastFlight(startString);
        });
    } );
  }
}
