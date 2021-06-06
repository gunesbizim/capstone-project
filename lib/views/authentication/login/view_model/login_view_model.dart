import 'package:capstone_project/core/base/model/base_view_model.dart';
import 'package:capstone_project/services/authentication_service.dart';
import 'package:capstone_project/services/fire_store_service.dart';
import 'package:capstone_project/services/navigation/navigation_service.dart';
import 'package:capstone_project/views/authentication/emailVerification/view_model/email_verification_view_model.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:capstone_project/core/constants/values/route_constants.dart';
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
    loginService = AuthenticationService.instance;
    navigationService = NavigationService.instance;
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @observable
  bool isLoading = false;

  @observable
  bool isLockOpen = false;

  @action
  Future<void> login() async {
    isLoadingChange();
    if (globalFormState.currentState!.validate()) {
      final response = await loginService.signIn(
          email: emailController!.text, password: passwordController!.text);
      if (response["userCredential"] != null) {
        print(response["message"]);
        print(await response["state"]);
        bool state = response["state"];
        if (state) {
          //FireStoreService.instance.getUserDetails();
          navigationService.navigateToPageClear(
              path: RouteConstants.HOME_PAGE, data: response["userCredential"]);
        } else {
          navigationService.navigateToPageClear(
              path: RouteConstants.VERIFICATION,
              data: response["userCredential"]);
        }
      } else {
        //TODO: Show Snackbar
        print(response["message"]);
      }
    } //else
    isLoadingChange();
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
