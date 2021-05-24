import 'package:flutter/material.dart';

class ZettLogo extends StatelessWidget {
  final double height;

  ZettLogo({
    required this.height
  });

  @override
  Widget build(BuildContext context) {
    return Center(child: Image.asset("assets/images/logo.png",width: height,height: height,));
  }
}