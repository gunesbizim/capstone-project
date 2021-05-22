import 'package:capstone_project/core/base/model/base_view_model.dart';
import 'package:capstone_project/core/base/view/base_widget.dart';
import 'package:capstone_project/services/FirebaseAuth.dart';
import 'package:capstone_project/services/navigation/navigation_service.dart';
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
  TextEditingController? emailController;
  TextEditingController? passwordController;

  @override
  void setContext(BuildContext context) => this.context = context;
  @override
  void init() {
    loginService = AuthenticationService(FirebaseAuth.instance);
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
    if(globalFormState.currentState!.validate()){
      final response = await loginService.signIn(email: emailController!.text, password: passwordController!.text);
      if(response["userCredential"]==null){
        //TODO: Sow snackbar
      isLoadingChange();
     }else{
        navigationService.navigateToPageClear(
       path: RouteConstants.HOME_PAGE,
       data: response["userCredential"]
     );
     }
    }
    else isLoadingChange();

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
