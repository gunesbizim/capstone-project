
import 'dart:io';

import 'package:capstone_project/core/base/model/base_view_model.dart';
import 'package:mobx/mobx.dart';
part 'drone_connection_view_model.g.dart';

class DroneConnectionViewModel = _DroneConnectionViewModelBase with _$DroneConnectionViewModel;

abstract class _DroneConnectionViewModelBase with Store, BaseViewModel{
  @observable
  String status = "Connected";

  @observable
  bool isLoading = false;


  @override
  void setContext(context) => this.context = context;

  @override 
  void init(){

  }
  
  @action
  void isConnected(){
    
  }

  
  @action
  Future checkConnection() async {
    setLoading();
    print(isLoading);
    if(status == "Not Connected" ){
       await Future.delayed(
      Duration(seconds:4),
      () => 'Connected',
      ).then((value) => status = value);
    }else if(status == "Connected"){
      await Future.delayed(
      Duration(seconds: 2),
      () => "Not Connected",
      ).then((value) => status =value);
    }
    setLoading();

  }
  
  @action
  void setLoading() => isLoading = !isLoading;

  @computed 
  bool get loadingState => isLoading;
}