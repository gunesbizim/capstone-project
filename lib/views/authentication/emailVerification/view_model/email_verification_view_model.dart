import 'dart:async';

import 'package:capstone_project/core/base/model/base_view_model.dart';
import 'package:capstone_project/core/constants/values/route_constants.dart';
import 'package:capstone_project/services/authentication_service.dart';
import 'package:capstone_project/services/navigation/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'email_verification_view_model.g.dart';

class EmailVerificationViewModel = _EmailVerificationViewModelBase
    with _$EmailVerificationViewModel;

abstract class _EmailVerificationViewModelBase with Store, BaseViewModel {
  late AuthenticationService authenticationService;
  late NavigationService navigationService;
  var args;

  void setArgs(args) {
    this.args = args;
  }

  @override
  void setContext(BuildContext context) => this.context = context;

  @override
  void init() {
    authenticationService = AuthenticationService.instance;
    navigationService = NavigationService.instance;
    updateEmail();
    emailVerificationCheck(args);
  }

  @observable
  String email = "";

  late bool _state = false;
  late Timer timer;
  Future<void> emailVerificationCheck(Map<dynamic, dynamic> response) async {
    timer = Timer.periodic(Duration(seconds: 2), (timer) async {
      await authenticationService.verifyEmail().then((value) => _state = value);
      navigateToHomePage(response);
      print(_state);
    });
  }

  void disposeTimer() {
    timer.cancel();
  }

  bool getState() {
    return _state;
  }

  @action
  void updateEmail() {
    authenticationService.returnUserEmail().then((value) => email = value);
  }

  void navigateToHomePage(Map<dynamic, dynamic> response) {
    print(_state);
    if (_state) {
      disposeTimer();
      navigationService.navigateToPageClear(
          path: RouteConstants.HOME_PAGE, data: response);
    } else {}
  }
}
