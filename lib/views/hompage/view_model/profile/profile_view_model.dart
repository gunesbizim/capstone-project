import 'dart:io';

import 'package:capstone_project/core/base/model/base_view_model.dart';
import 'package:capstone_project/core/enums/profile_picture_enum.dart';
import 'package:capstone_project/views/hompage/services/user_detail_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
part 'profil_view_model.g.dart';

class ProfileViewModel = _ProfileViewModelBase with _$ProfileViewModel;

abstract class _ProfileViewModelBase with Store, BaseViewModel {
  
  @observable
  var image;

  final picker = ImagePicker();

  late UserDetailService userDetailService;

  @observable
  bool hasPP = false;

  @observable
  String ppURL = "https://tr.web.img3.acsta.net/c_310_420/pictures/210/017/21001798_20130426172912097.jpg";

  @observable 
  String userName = "Rober Downey Jr.";

  @observable 
  String flightTime = "30H 00S";

  @override
  void setContext(BuildContext context) => this.context = context;

  @override
  void init(){
    userDetailService = UserDetailService(FirebaseFirestore.instance);
  }

  
  @action
  Future selectImage(ProfilePictureEnums mode)async {
    final  pickedFile = await picker.getImage(source: ImageSource.gallery);
     
    if (pickedFile != null) {
      image = File(pickedFile.path);
      print("----------------------------------------------------------------------------------------------------------------");
      File? croppedImage = await ImageCropper.cropImage(
        sourcePath: pickedFile.path,
        maxWidth: 1080,
        maxHeight: 1080,
        aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
        
    );
      if (mode == ProfilePictureEnums.NEW) {
        //add image to firestore
      }else if(mode == ProfilePictureEnums.NEW){
        //update existing image in firestore
      }
      ppURL = "https://i.pinimg.com/originals/8e/21/29/8e2129f44804db65316ed3db92cf8552.jpg";
      hasPP = true;
    } else {
      print('No image selected.');
    }
  }
  
}