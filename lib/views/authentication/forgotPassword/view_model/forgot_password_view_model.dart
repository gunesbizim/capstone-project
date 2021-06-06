import 'package:capstone_project/core/base/model/base_view_model.dart';
import 'package:capstone_project/core/constants/values/route_constants.dart';
import 'package:capstone_project/services/authentication_service.dart';
import 'package:capstone_project/services/navigation/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'forgot_password_view_model.g.dart';

class ForgotPasswordViewModel = _ForgotPasswordViewModelBase
    with _$ForgotPasswordViewModel;

abstract class _ForgotPasswordViewModelBase with Store, BaseViewModel {
  GlobalKey<FormState> globalFormState = GlobalKey();
  GlobalKey<ScaffoldState> globalScaffoldState = GlobalKey();
  TextEditingController? emailController;
  late NavigationService navigationService;
  late AuthenticationService authenticationService;

  @override
  void setContext(BuildContext context) => this.context = context;
  @override
  void init() {
    navigationService = NavigationService.instance;
    authenticationService = AuthenticationService.instance;
    emailController = TextEditingController();
  }

  void navigateToSignUp() {
    navigationService.navigateToPage(path: RouteConstants.SIGNUP);
  }

  void sendEmail() {
    authenticationService.sendRecoveryEmail(emailController!.text, context!);
  }
}
