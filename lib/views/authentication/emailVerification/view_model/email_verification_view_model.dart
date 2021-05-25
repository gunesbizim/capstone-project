import 'package:capstone_project/core/base/model/base_view_model.dart';
import 'package:capstone_project/core/constants/route_constants.dart';
import 'package:capstone_project/services/FirebaseAuth.dart';
import 'package:capstone_project/services/navigation/navigation_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'email_verification_view_model.g.dart';

class EmailVerificationViewModel = _EmailVerificationViewModelBase
    with _$EmailVerificationViewModel;

abstract class _EmailVerificationViewModelBase with Store, BaseViewModel {
  late AuthenticationService firebaseService;
  late NavigationService navigationService;

  @override
  void setContext(BuildContext context) => this.context = context;

  @override
  void init() {
    firebaseService = AuthenticationService(FirebaseAuth.instance);
    navigationService = NavigationService.instance;
    updateEmail();
  }

  @observable
  String email = "";

  late bool _state;
  Future<void> emailVerificationCheck() async {
    await firebaseService.verifyEmail().then((value) => _state = value);
  }

  bool getState() {
    return _state;
  }

  @action
  void updateEmail() {
    firebaseService.returnUserEmail().then((value) => email = value);
  }

  void navigateToHomePage() {
    emailVerificationCheck();
    print(_state);
    if (_state) {
      navigationService.navigateToPageClear(
          path: RouteConstants.HOME_PAGE, data: 1);
    } else {}
  }
}
