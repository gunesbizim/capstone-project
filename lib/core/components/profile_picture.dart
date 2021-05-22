import 'dart:ui';

import 'package:capstone_project/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  final String ppURL;
  final double screenHeight;
  ProfilePicture({
    required this.ppURL,
    required this.screenHeight
  });

  @override
  Widget build(BuildContext context) {
    //TODO:
    //calculate dimension according to screen height.
    final double dimension = 138.0;
    return Container(
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
                    ));
  }
}
