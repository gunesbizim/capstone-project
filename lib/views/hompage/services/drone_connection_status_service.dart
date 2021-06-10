import 'dart:async';

import 'package:capstone_project/core/enums/drone_connection_status_type_enum.dart';
import 'package:connectivity/connectivity.dart';

class DroneConnectionStatusService {
  static final DroneConnectionStatusService instance =
      DroneConnectionStatusService._init();

  late Function setStatus;
  late Connectivity _connectivity = new Connectivity();
  ConnectivityResult? _result;

  late Timer _timer;

  int counter = 0;
  DroneConnectionStatusService._init();
  Future checkStatus() async {
    print("Checking Status");
    _timer = Timer.periodic(Duration(milliseconds: 50), (Timer t) async {
      if (counter == 10) {
        print("Timer is finished with count of 100");
        setStatus(DroneConnectionStatusTypeEnum.SUCCESS, "Connected");
        t.cancel();
        counter = 0;
      }
      counter++;
    });
  }

//  Future<void> droneConnectionCheck() async {
//    final String ip = await Wifi.ip;
  //   final String subnet = ip.substring(0, ip.lastIndexOf('.'));
  //  final int port = 80;

  // final stream = NetworkAnalyzer.discover(subnet, port);
  // stream.listen((NetworkAddress addr) {
  // if (addr.exists) {
  //   print('Found device: ${addr.ip}');
  // }
  //  });
  // }
}
