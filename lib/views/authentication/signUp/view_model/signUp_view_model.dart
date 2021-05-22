import 'package:capstone_project/core/base/model/base_view_model.dart';
import 'package:capstone_project/services/FirebaseAuth.dart';
import 'package:capstone_project/services/navigation/navigation_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'signup_view_model.g.dart';

class SignupViewModel = _SignupViewModelBase with _$SignupViewModel;

class _SignupViewModelBase with Store, BaseViewModel {
    GlobalKey<FormState> globalFormState = GlobalKey();
    GlobalKey<ScaffoldState> globalScaffoldState = GlobalKey();
    late AuthenticationService signUpService;
    late NavigationService navigationService;
    TextEditingController? emailCntrl;
    TextEditingController? pwCntrl;
    TextEditingController? pw2Cntrl;

    @override 
    void setContext(BuildContext context) => this.context = context;
    @override
    void init(){
      print("init2");
      signUpService = AuthenticationService(FirebaseAuth.instance);
      navigationService = NavigationService.instance; 
    }
}