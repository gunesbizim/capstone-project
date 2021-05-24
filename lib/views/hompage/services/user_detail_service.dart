
import 'dart:io';

import 'package:capstone_project/services/FirebaseAuth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserDetailService with ChangeNotifier{
final FirebaseFirestore _fireStore;

  UserDetailService(this._fireStore);

  Future<Map<String,String>> getUserDetails() async{
    //TODO: fetch user data from firestore and return it.
    final user = FirebaseAuth.instance.currentUser;
    final userMap = {
      "name" : "Robert Downey Jr.",
      "flight_time": "30M 00S",
      "ppURL" : "https://media1.popsugar-assets.com/files/thumbor/HwtAUAufmAZv-FgGEIMJS2eQM-A/0x1:2771x2772/fit-in/2048xorig/filters:format_auto-!!-:strip_icc-!!-/2020/03/30/878/n/1922398/eb11f12e5e825104ca01c1.02079643_/i/Robert-Downey-Jr.jpg"
    };
    return userMap;
  }
  Future setProfilePicture(File ppFile) async{
    //TODO: Add given file to firestore
  }
}