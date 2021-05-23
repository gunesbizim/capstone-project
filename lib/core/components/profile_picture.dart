import 'dart:io';
import 'dart:ui';

import 'package:capstone_project/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  final String ppURL;
  final  double screenHeight;
  final File imageFile;
  ProfilePicture({
    required this.ppURL,
    required this.screenHeight,
    required this.imageFile
  });

  @override
  Widget build(BuildContext context) {
    //TODO:
    //calculate dimension according to screen height.
    final double dimension = 138.0;
    return ppURL!=""? Container(
                    width: dimension,
                    height: dimension,
                    decoration: new BoxDecoration(
                      border: Border.all(
                        color: AppColors.primaryBlue,
                        width: 2
                      ) ,
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: new NetworkImage(
                              ppURL)
                        )
                    )):
                     Container(
                    width: dimension,
                    height: dimension,
                    decoration: new BoxDecoration(
                      border: Border.all(
                        color: AppColors.primaryBlue,
                        width: 2
                      ) ,
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: new FileImage(
                              imageFile)
                        )
                    ));
  }
}
