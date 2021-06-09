
class FlightRequestService{
  static final FlightRequestService instance = FlightRequestService._init();
  FlightRequestService._init();

  String _address = "";

  void setAddress(String address){
    this._address = address;
  }
  String _parseMovementHTTP(double degrees, double distance){
    //TODO: Parse the data into respective http request
    return "";
  }
  void horizontalPlaneMovement(double degrees, double distance) async {
    final String parsedRequest = _parseMovementHTTP(degrees, distance);

  }
  Map<String,double> _separateRotationAndAlttitude(double degrees, double distance){
    return {"altitudeCoefficient":0.0, //TODO cos(degrees)*distance*100
    "rotationCoefficient": 0.0, //TODO sin(degrees)*distance*100
    };
  }

  String _parseChangeAltitudeHTTP(double altitudeCoefficient){
    //TODO: Parse the data into respective http request
    return "";
  }

  String _parseRotationHTTP(double altitudeCoefficient){
    //TODO: Parse the data into respective http request
    return "";
  }
  void changeAltitudeAndRotate(double degrees, double distance) async {
    final result = _separateRotationAndAlttitude(degrees, distance);
    
    final String parsedAltitudeRequest = _parseChangeAltitudeHTTP(result["altitudeCoefficient"]!);
    //TODO send the request to drone

    final String parsedTorationRequest = _parseChangeAltitudeHTTP(result["rotationCoefficient"]!);
    //TODO send the request to drone
  }
}