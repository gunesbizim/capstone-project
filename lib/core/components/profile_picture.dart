import 'dart:io';
import 'dart:ui';

import 'package:capstone_project/core/constants/values/app_colors.dart';
import 'package:capstone_project/core/enums/profile_picture_enum.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget with RouteAware{
  final String ppURL;
  final double screenHeight;
  final Function  selectImage;
  ProfilePicture({
    required this.ppURL,
    required this.screenHeight,
    required this.selectImage
  });

  @override
  Widget build(BuildContext context) {
    //TODO:
    //calculate dimension according to screen height.
    final double dimension = 138.0;
    return ppURL!=""? GestureDetector(
                      child: Container(
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
                        )
                      ),
                      onTap: (){
                        customDialog(
                        context: context, 
                        title: 'Update Profile Picture', 
                        content: 'Do you want to change your profile picture?', 
                        mode: ProfilePictureEnums.UPDATE);
                      },
                    ):
                    GestureDetector(
                      child: Container(
                        width: dimension,
                        height: dimension,
                        decoration: new BoxDecoration(
                          gradient: AppColors.addPhotoGradient,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.add_a_photo_outlined,color: Colors.white,),
                      ),
                      onTap: (){
                        customDialog(
                        context: context, 
                        title: 'Add Profile Picture', 
                        content: 'Do you want to add a profile picture?', 
                        mode: ProfilePictureEnums.NEW);
                      },
                    );   
  }

  void customDialog({BuildContext? context, String? title, String? content, String? confirmation, ProfilePictureEnums? mode}){
    showDialog(
      context: context!, 
        builder: (BuildContext context) => AlertDialog(
        title: Text(title!),
        content: Text(content!),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'Yes');
              selectImage(mode);
              },
            child: const Text('Yes'),
          ),
        ],
      )
    );
  }
}
