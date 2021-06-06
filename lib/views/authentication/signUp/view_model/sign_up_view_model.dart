import 'package:capstone_project/core/base/model/base_view_model.dart';
import 'package:capstone_project/core/constants/values/route_constants.dart';
import 'package:capstone_project/services/fire_store_service.dart';
import 'package:capstone_project/services/authentication_service.dart';
import 'package:capstone_project/services/navigation/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'sign_up_view_model.g.dart';

class SignupViewModel = _SignupViewModelBase with _$SignupViewModel;

abstract class _SignupViewModelBase with Store, BaseViewModel {
  String name = "SignupViewModel";
  GlobalKey<FormState> globalFormState = GlobalKey();
  GlobalKey<ScaffoldState> globalScaffoldState = GlobalKey();
  late AuthenticationService signUpService;
  late FireStoreService fireStoreService;
  late NavigationService navigationService;
  TextEditingController? emailCntrl;
  TextEditingController? pwCntrl;
  TextEditingController? pw2Cntrl;
  TextEditingController? nameCntrl;
  AuthenticationService _authService = AuthenticationService.instance;
  @override
  void setContext(BuildContext context) => this.context = context;
  @override
  void init() {
    print("$name init()");
    signUpService = AuthenticationService.instance;
    fireStoreService = FireStoreService.instance;
    navigationService = NavigationService.instance;
    emailCntrl = TextEditingController();
    pwCntrl = TextEditingController();
    pw2Cntrl = TextEditingController();
    nameCntrl = TextEditingController();
  }

  @observable
  bool isLoading = false;

  @observable
  bool isLockOpen = false;

  @action
  Future<void> signUp() async {
    isLoadingChange();
    print("$name Signing up");
    print(globalFormState);
    if (globalFormState.currentState!.validate()) {
      print("$name globalFormState.currentState is validated");
      
      if ((pwCntrl!.text != "" && pw2Cntrl!.text != "") &&
          (pwCntrl!.text == pw2Cntrl!.text)) {
        print("$name Fields are validated");
        final response = await signUpService.signUp(
            email: emailCntrl!.text,
            password: pwCntrl!.text,
            fullName: nameCntrl!.text);
        print('4');
        if (response["userCredential"] != null) {
          isLoadingChange();
          print("Here");
          _authService.user!.sendEmailVerification();
          navigationService.navigateToPageClear(
              path: RouteConstants.VERIFICATION,
              data: response["userCredential"]);
        } else {
          print('Loggin error');
          isLoadingChange();
        }
      } //TODO: add show snackbar
    } else 
      isLoadingChange();
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
