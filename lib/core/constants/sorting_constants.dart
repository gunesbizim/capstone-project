
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum SortingConstants{
  FLIGHT_DURATION_ASCENDING,
  FLIGHT_DURATION_DESCENDING,
  FLIGHT_DATE_ASCENDING,
  FLIGHT_DATE_DESCENDING,
}
extension SortinConstantsExtension on SortingConstants {
  String get name =>  describeEnum(this);

  Row get getChild {
    switch(this){
      case SortingConstants.FLIGHT_DURATION_ASCENDING:
        return Row(
          children: [
            Text("Flight Duration"),
            Icon(Icons.arrow_downward_sharp)
          ],
        );
      case SortingConstants.FLIGHT_DURATION_DESCENDING:
        return Row(
          children: [
            Text("Flight Duration"),
            Icon(Icons.arrow_upward_sharp)
          ],
        );
      case SortingConstants.FLIGHT_DATE_ASCENDING:
        return Row(
          children: [
            Text("Flight Start Time"),
            Icon(Icons.arrow_downward_sharp)
          ],
        );
      case SortingConstants.FLIGHT_DATE_DESCENDING:
        return Row(
          children: [
            Text("Flight Start Time"),
            Icon(Icons.arrow_upward_sharp),
          ],
        );
    }
  }
}