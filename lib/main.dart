import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:capstone_project/core/components/control_pad/control_pad.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ZettApp());
}

class ZettApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Control Pad Example',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Control Pad Example'),
      ),
      body: Container(
        child: JoystickView(
          size: 200,
        ),
      ),
    );
  }
}
