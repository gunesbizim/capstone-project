
import 'dart:io';

import 'package:capstone_project/core/base/model/base_view_model.dart';
import 'package:capstone_project/views/hompage/services/user_detail_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
part 'profile_view_model.g.dart';

class ProfileViewModel = _ProfileViewModelBase with _$ProfileViewModel;

abstract class _ProfileViewModelBase with BaseViewModel,Store {
  @observable
  var image;

  final picker = ImagePicker();

  late UserDetailService userDetailService;

  @observable
  bool hasPP = false;

  @observable
  String ppURL = "https://teknokupur.net/wp-content/uploads/2020/07/4-2-scaled.jpg";

  @observable 
  String userName = "Rober Downey Jr.";

  @observable 
  String flightTime = "30H 00S";

  @observable

  @override
  void setContext(BuildContext context) => this.context = context;

  @override
  void init(){
    userDetailService = UserDetailService(FirebaseFirestore.instance);
  }

  
  @action
  Future selectImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      hasPP = true;
    } else {
      print('No image selected.');
    }
    
  }

}