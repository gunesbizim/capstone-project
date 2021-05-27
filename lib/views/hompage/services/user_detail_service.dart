
import 'dart:io';

import 'package:capstone_project/core/enums/profile_picture_enum.dart';
import 'package:capstone_project/services/FirebaseAuth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:path/path.dart' as p;

class UserDetailService with  ChangeNotifier{
  @observable String userName;
  @observable String flightTime;
  @observable bool hasPP;
  @observable String ppURL;
  late final FirebaseFirestore _fireStore;
  final _picker = ImagePicker();
  final _user = FirebaseAuth.instance.currentUser!;

  late File? _image;
  late Reference storageReference;
  UserDetailService(
   {required this.userName,
    required this.flightTime,
    required this.hasPP,
    required this.ppURL}
  );
  void init(){
    _fireStore = FirebaseFirestore.instance;
  }

  Future getUserDetails() async{
    print("**********************USER DETAILS**********************");//hazarcandogabakan@gmail.com
    print("**********************${_user.uid}**********************");
    Map<String, String> result = {};

    var user_details = await _fireStore.collection("pilots")
      .where("id",isEqualTo: _user.uid);
    await user_details.get().then((querySnapshot){
        querySnapshot.docs.forEach((data) {
          print("######");
          print(data["fullName"]);
          print("######");
          userName = data["fullName"];
          flightTime = data["flightTime"];
          ppURL = data["ppURL"];
        });
      });
  }
  Future _setProfilePicture(ProfilePictureEnums mode, String ppURL) async{  

      if(mode == ProfilePictureEnums.UPDATE){
        //update existing image in firestore
        await storageReference.delete();
      }
      try {
        storageReference.putFile(_image!)
        .whenComplete(() => print("file uploaded"));    
        storageReference
          .getDownloadURL()
          .then((fileURL) {    
            ppURL = fileURL;
          });  
      } on Exception catch (e) {
        print(e);
      } 

  }

  Future selectImage(ProfilePictureEnums mode, bool hasPP, String ppURL)async {
    _getStorageInstance();
    final  pickedFile = await _picker.getImage(source: ImageSource.gallery);
     
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      print("----------------------------------------------------------------------------------------------------------------");
      _image = await ImageCropper.cropImage(
        sourcePath: pickedFile.path,
        maxWidth: 1080,
        maxHeight: 1080,
        aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
        
      );
      _setProfilePicture(mode,ppURL);
      hasPP = true;
    } else {
      print('No image selected.');
    }
  }
  void _getStorageInstance(){
    storageReference = FirebaseStorage.instance    
       .ref()    
       .child('profile_pictures')
       .child(_user.uid)
       .child("${_user.uid}_pp.${p.extension(_image!.path)}");  
  }
}