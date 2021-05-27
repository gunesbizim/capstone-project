import 'package:capstone_project/core/constants/sorting_constants.dart';
import 'package:capstone_project/views/flight_list/Model/flight_log_item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';

class FlightListLoadService{
  late QuerySnapshot collectionState;
  late ObservableList<FlightLogItemModel> flights;
  late bool isDecending;
  late String fieldName;
  FlightListLoadService({
    required this.flights
  });

  Future<void> getDocuments(String dropDownValue) async {
    setSearchCriteria(dropDownValue);

    var collection = FirebaseFirestore.instance
        .collection('flights').where("pilotId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .orderBy(fieldName,descending: isDecending)
        .limit(15);
    print('getDocuments');
    fetchDocuments(collection,true);
  }

  Future<void> getDocumentsNext(String dropDownValue) async {
    // Get the last visible document
    var lastVisible = collectionState.docs[collectionState.docs.length-1];
    print('listDocument legnth: ${collectionState.size} last: $lastVisible');
    

    setSearchCriteria(dropDownValue);
    
        var collection = FirebaseFirestore.instance
            .collection('flights').where("pilotId", isEqualTo: FirebaseAuth.instance.currentUser!.uid).orderBy(fieldName,descending: isDecending)
            .startAfterDocument(lastVisible).limit(8);
    
        fetchDocuments(collection,false);
  }

  void fetchDocuments(Query collection,bool isNew){
        if(isNew) flights.clear();
        collection.get().then((querySnapshot) {
          collectionState = querySnapshot; // store collection state to set where to start next
          querySnapshot.docs.forEach((element) { 
            DateTime start = DateTime.parse(element["flightStartTime"].toDate().toString());
            DateTime end =DateTime.parse(element["flightEndTime"].toDate().toString());
            Duration duration = end.difference(start);
            String startString = DateFormat("dd-MM-yyyy").format(start);
            String timeString = DateFormat(DateFormat.HOUR24_MINUTE_SECOND).format(start);
            Duration d = Duration();
            String durationString = formatDuration(duration);
            flights.add(FlightLogItemModel(date: startString, time: timeString, duration: durationString));
          });
        });
      }
      String formatDuration(Duration duration) {
        String twoDigits(int n) => n.toString().padLeft(2, "0");
        String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
        String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
      return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
      }
    
      void setSearchCriteria(String dropDownValue) {
        if(dropDownValue == SortingConstants.FLIGHT_DATE_ASCENDING.name){
          isDecending = false;
          fieldName = "flightStartTime";
          print("current field name: $fieldName");

        } else if(dropDownValue == SortingConstants.FLIGHT_DATE_DESCENDING.name){
          isDecending = true;
          fieldName = "flightStartTime";
          print("current field name: $fieldName");
        } else if(dropDownValue == SortingConstants.FLIGHT_DURATION_ASCENDING.name){
          isDecending = false;
          fieldName = "duration";
          print("current field name: $fieldName");
        } else if(dropDownValue == SortingConstants.FLIGHT_DURATION_DESCENDING.name){
          isDecending = true;
          fieldName = "duration";      
          print("current field name: $fieldName");
        }   
      }

}