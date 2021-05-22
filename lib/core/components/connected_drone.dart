import 'package:flutter/material.dart';

class ConnectedDrone extends StatelessWidget {
  final bool connectionStatus;

  ConnectedDrone({required this.connectionStatus});

  @override
  Widget build(BuildContext context) {
    return connectionStatus? Container():
     Container();
  }
}