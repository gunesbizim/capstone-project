import 'dart:io';

import 'package:capstone_project/core/base/model/base_view_model.dart';
import 'package:capstone_project/core/enums/profile_picture_enum.dart';
import 'package:capstone_project/views/hompage/services/user_detail_service.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'profile_view_model.g.dart';

class ProfileViewModel = _ProfileViewModelBase with _$ProfileViewModel;

abstract class _ProfileViewModelBase with Store, BaseViewModel{
    
  @observable
  var image;

  late UserDetailService userDetailService;

  @observable
  bool hasPP = false;

  @observable
  String ppURL = "";

  @observable 
  String userName = "";

  @observable 
  String flightTime = "";

  @override
  void setContext(BuildContext context) => this.context = context;

  @override
  void init(){
    userDetailService = UserDetailService();
    getUserDetails();
  }

  @action
  Future getUserDetails() async {
    print("before: $userName");
    await userDetailService.getUserDetails().then((result){
      userName = result["userName"]!;
      ppURL = result["ppURL"]!;
      flightTime = result["flightTime"]!;
    });
    print("after: $userName");
    }
  
  @action
  Future selectImage(ProfilePictureEnums mode)async{
    userDetailService.selectImage(mode).then((value) => ppURL = value);
    } 
}