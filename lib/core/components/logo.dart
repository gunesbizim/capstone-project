import 'package:flutter/material.dart';

class ZettLogo extends StatelessWidget {
  final double height;

  ZettLogo({
    required this.height
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
       shape: BoxShape.circle,
       color: Colors.red, 
      ),
      height: height,
    );
  }
}