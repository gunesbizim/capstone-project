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
    print("init2");
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
    print("Sign Up Test123123");
    print(globalFormState);
    if (globalFormState.currentState!.validate()) {
      print('2');
      if ((pwCntrl!.text != "" && pw2Cntrl!.text != "") &&
          (pwCntrl!.text == pw2Cntrl!.text)) {
        print('3');
        final response = await signUpService.signUp(
            email: emailCntrl!.text, password: pwCntrl!.text);
        print('4');
        if (response["userCredential"] != null) {

          fireStoreService.setUserData(
              id:_authService.user!.uid, 
              name: nameCntrl!.text,
              email: emailCntrl!.text, 
              lastFlightId: "No flight yet");
          //TODO: Sow snackbar
          //isLoadingChange(); zett@zett.com
          print("5");
          _authService.user!.sendEmailVerification();
          navigationService.navigateToPageClear(
              path: RouteConstants.VERIFICATION,
              data: response["userCredential"]);
        }
      }
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