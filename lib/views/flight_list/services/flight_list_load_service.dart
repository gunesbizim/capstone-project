import 'package:capstone_project/core/constants/values/sorting_constants.dart';
import 'package:capstone_project/services/authentication_service.dart';
import 'package:capstone_project/services/fire_store_service.dart';
import 'package:capstone_project/views/flight_list/Model/flight_log_item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';

class FlightListLoadService{
  static final FlightListLoadService instance = FlightListLoadService._init();
  late QuerySnapshot collectionState;
  late ObservableList<FlightLogItemModel> flights;
  late bool isDescending;
  late String orderBy;
  FlightListLoadService._init();
  AuthenticationService _authService = AuthenticationService.instance;
  FireStoreService _fireStoreService = FireStoreService.instance;
  Future<void> getDocuments(String dropDownValue) async {
    setSearchCriteria(dropDownValue);
    var collection = _fireStoreService.getLimitedCollection(
      collectionName: "flights",
      whereField: "pilotId",
      orderBy: orderBy,
      isDescending: isDescending,
      limit: 15
    );
        
    fetchDocuments(collection,true);
  }

  Future<void> getDocumentsNext(String dropDownValue) async {
    // Get the last visible document
    var lastVisible = collectionState.docs[collectionState.docs.length-1];
    print('listDocument legnth: ${collectionState.size} last: $lastVisible');
    

    setSearchCriteria(dropDownValue);
    
    var collection = _fireStoreService.getLimitedCollection(
      collectionName: "flights",
      whereField: "pilotId",
      orderBy: orderBy,
      isDescending: isDescending,
      limit: 8
    );

    fetchDocuments(collection,false);
  }

  void fetchDocuments(Query collection,bool isNew){
        if(isNew) flights.clear();
        collection.get().then((querySnapshot) {
          collectionState = querySnapshot; // store collection state to set where to start next
          print("query snapshot length: ${querySnapshot.docs.length}");
          querySnapshot.docs.forEach((element) { 
            DateTime start = DateTime.parse(element["flightStartTime"].toDate().toString());
            String startString = DateFormat("dd-MM-yyyy").format(start);
            String timeString = DateFormat(DateFormat.HOUR24_MINUTE_SECOND).format(start);
            String durationString = "${element["duration"]["hours"]}:${element["duration"]["minutes"]}:${element["duration"]["seconds"]}";
            print(durationString);
            flights.add(FlightLogItemModel(date: startString, time: timeString, duration: durationString));
          });
        });
      }
 
    
  void setSearchCriteria(String dropDownValue) {
    if(dropDownValue == SortingConstants.FLIGHT_DATE_ASCENDING.name){
      isDescending = false;
      orderBy = "flightStartTime";
      print("current field name: $orderBy");

    } else if(dropDownValue == SortingConstants.FLIGHT_DATE_DESCENDING.name){
      isDescending = true;
      orderBy = "flightStartTime";
      print("current field name: $orderBy");
    } else if(dropDownValue == SortingConstants.FLIGHT_DURATION_ASCENDING.name){
      isDescending = false;
      orderBy = "duration";
      print("current field name: $orderBy");
    } else if(dropDownValue == SortingConstants.FLIGHT_DURATION_DESCENDING.name){
      isDescending = true;
      orderBy = "duration";      
      print("current field name: $orderBy");
    }   
  }

}