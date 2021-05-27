import 'package:capstone_project/core/base/model/base_view_model.dart';
import 'package:capstone_project/services/authentication_service.dart';
import 'package:mobx/mobx.dart';
part 'app_bar_view_model.g.dart';

class AppBarViewModel = _AppBarViewModelBase with _$AppBarViewModel;

abstract class _AppBarViewModelBase with Store, BaseViewModel {
  @override 
  void setContext(context) => this.context = context;

  late final AuthenticationService authService;

  @override
  void init(){
    authService = AuthenticationService.instance;
  } 
  
  void logOut(){
    authService.logOut();
  }

}