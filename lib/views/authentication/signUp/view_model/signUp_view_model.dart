import 'package:capstone_project/core/base/model/base_view_model.dart';
import 'package:capstone_project/core/constants/route_constants.dart';
import 'package:capstone_project/services/FireStore.dart';
import 'package:capstone_project/services/FirebaseAuth.dart';
import 'package:capstone_project/services/navigation/navigation_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'signup_view_model.g.dart';

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

  @override
  void setContext(BuildContext context) => this.context = context;
  @override
  void init() {
    print("init2");
    signUpService = AuthenticationService(FirebaseAuth.instance);
    fireStoreService = FireStoreService(FirebaseFirestore.instance);
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
          final FirebaseAuth auth = FirebaseAuth.instance;
          final User? user = auth.currentUser;
          final uid = user!.uid;
          fireStoreService.setUserData(
              uid, nameCntrl!.text, emailCntrl!.text, "No flight yet");
          //TODO: Sow snackbar
          //isLoadingChange(); zett@zett.com
          print("5");
          user.sendEmailVerification();
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
