import 'package:capstone_project/views/flight_list/Model/flight_log_item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';

class FlightListLoadService{
  late QuerySnapshot collectionState;
  late ObservableList<FlightLogItemModel> flights ;

  FlightListLoadService({
    required this.flights
  });

  Future<void> getDocuments() async {
    var collection = FirebaseFirestore.instance
        .collection('flights').where("pilotId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .orderBy("flightStartTime",descending: true)
        .limit(15);
    print('getDocuments');
    fetchDocuments(collection);
  }

  Future<void> getDocumentsNext() async {
    // Get the last visible document
    var lastVisible = collectionState.docs[collectionState.docs.length-1];
    print('listDocument legnth: ${collectionState.size} last: $lastVisible');

    var collection = FirebaseFirestore.instance
        .collection('flights').where("pilotId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .orderBy("flightStartTime",descending: true).startAfterDocument(lastVisible).limit(8);

    fetchDocuments(collection);
  }
 fetchDocuments(Query collection){
    collection.get().then((querySnapshot) {
      collectionState = querySnapshot; // store collection state to set where to start next
      querySnapshot.docs.forEach((element) { 
        DateTime start = DateTime.parse(element["flightStartTime"].toDate().toString());
        DateTime end =DateTime.parse(element["flightEndTime"].toDate().toString());
        Duration duration = end.difference(start);
        String startString = DateFormat("dd-MM-yyyy").format(start);
        String timeString = DateFormat(DateFormat.HOUR24_MINUTE_SECOND).format(start);
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

}