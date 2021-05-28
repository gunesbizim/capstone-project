import 'package:capstone_project/core/base/model/base_view_model.dart';
import 'package:capstone_project/core/enums/profile_picture_enum.dart';
import 'package:capstone_project/views/hompage/services/user_detail_service.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'profile_view_model.g.dart';

class ProfileViewModel = _ProfileViewModelBase with _$ProfileViewModel;

abstract class _ProfileViewModelBase with Store, BaseViewModel{
  final String filePath = "package:capstone_project/views/hompage/view_model/profile/profile_view_model.dart";
  @observable
  var image;

  late UserDetailService userDetailService;

  @observable
  bool isLoaded = false;

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
    userDetailService = UserDetailService.instance;
    print("Profile View Model initialized");
    if(!isLoaded){
      getUserDetails();
    }
  }

  @action
  Future getUserDetails() async {
    print("$filePath: Getting user details");
    userDetailService.getUserDetails().then((result){
      print("$filePath: Assigning profile data to observable variables");
      userName = result["userName"]!;
      ppURL = result["ppURL"]!;
      flightTime = result["flightTime"]!;
    });
    }
  
  @action
  Future selectImage(ProfilePictureEnums mode)async{
    userDetailService.selectImage(mode).then((value) => ppURL = value);
    } 
}