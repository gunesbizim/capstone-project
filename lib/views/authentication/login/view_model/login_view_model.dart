import 'package:capstone_project/core/base/model/base_view_model.dart';
import 'package:capstone_project/core/base/view/base_widget.dart';
import 'package:capstone_project/services/FirebaseAuth.dart';
import 'package:capstone_project/services/navigation/navigation_service.dart';
import 'package:capstone_project/views/authentication/emailVerification/view_model/email_verification_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:capstone_project/core/constants/route_constants.dart';
part 'login_view_model.g.dart';

class LoginViewModel = _LoginViewModelBase with _$LoginViewModel;

abstract class _LoginViewModelBase with Store, BaseViewModel {
  GlobalKey<FormState> globalFormState = GlobalKey();
  GlobalKey<ScaffoldState> globalScaffoldState = GlobalKey();
  late AuthenticationService loginService;
  late NavigationService navigationService;
  late EmailVerificationViewModel emailVerif;
  TextEditingController? emailController;
  TextEditingController? passwordController;

  @override
  void setContext(BuildContext context) => this.context = context;
  @override
  void init() {
    print("init");
    loginService = AuthenticationService(FirebaseAuth.instance);
    navigationService = NavigationService.instance;
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @observable
  bool isLoading = false;

  @observable
  bool isLockOpen = false;

  late bool _state;

  @action
  Future<void> login() async {
    //isLoadingChange();
    print("test123123");
    print(globalFormState);
    if (globalFormState.currentState!.validate()) {
      print("2");

      final response = await loginService.signIn(
          email: emailController!.text, password: passwordController!.text);
      if (response["userCredential"] != null) {
        print(response["message"]);

        //TODO: Sow snackbar
        //isLoadingChange(); zett@zett.com
        print("4");
        loginService.verifyEmail().then((value) => _state = value);
        if (_state) {
          navigationService.navigateToPageClear(
              path: RouteConstants.HOME_PAGE, data: response["userCredential"]);
        } else {
          navigationService.navigateToPageClear(
              path: RouteConstants.VERIFICATION,
              data: response["userCredential"]);
        }
      } else {
        print(response["message"]);
      }
    } //else
    //isLoadingChange();
  }

  navigateToSignUp() {
    navigationService.navigateToPage(path: RouteConstants.SIGNUP);
  }

  @action
  void isLoadingChange() {
    isLoading = !isLoading;
  }

  @action
  void isLockStateChange() {
    isLockOpen = !isLockOpen;
  }
}
