import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors{
  static const Color primaryBlue = Color.fromRGBO(19, 171, 205, 1);
  static const Color _primaryBlue075 = Color.fromRGBO(19, 171, 205, 075);

  static const Color primaryPurple = Color.fromRGBO(148, 21, 151, 1);
  static const Color _primaryPurple052 = Color.fromRGBO(148, 21, 151, 0.52);
  static const Color _primaryPurple056 = Color.fromRGBO(148, 21, 151, 0.56);
  static const Color _buttonUpperBlue075 = Color.fromRGBO(50, 90, 176, 0.75);
  static const Color _primaryPurple092 = Color.fromRGBO(148, 21, 151, 0.92);

  static const Color backgroundUp = Color.fromRGBO(55, 21, 151, 0.9);
  static const Color backgroundDown = Color.fromRGBO(0, 129, 158, 1);
  static const LinearGradient backgroundGradient =  LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors:<Color>[
      backgroundUp,
      backgroundDown
    ]);


  static const LinearGradient inputBoxGradient =  LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors:<Color>[
      _primaryPurple052,
      primaryBlue,
    ]);
  static const RadialGradient flightButtonGradient = RadialGradient(
    center: Alignment.center,
    colors: [_primaryBlue075,_buttonUpperBlue075],

   );

  static const LinearGradient wingGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [primaryBlue, _primaryPurple056]);

  static const LinearGradient flightItemGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      primaryPurple,
      primaryBlue
    ]);
  static const LinearGradient connectedDroneGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      primaryPurple,
      primaryBlue
    ]);
  static const LinearGradient lastFlighGradient = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: [
    primaryBlue,
    primaryPurple
  ]);

  static const LinearGradient homeButtonGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    primaryBlue,
    primaryPurple
  ]);

  static const LinearGradient logoGradient = LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [
      primaryBlue,
      primaryPurple,
      Colors.white
    ]);
  static const RadialGradient  addPhotoGradient = RadialGradient(
    center: Alignment.center,
    colors: [primaryBlue,_primaryPurple056]
  );

}