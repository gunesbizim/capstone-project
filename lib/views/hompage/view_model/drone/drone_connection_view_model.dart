
import 'dart:io';

import 'package:capstone_project/core/base/model/base_view_model.dart';
import 'package:capstone_project/core/enums/drone_connection_status_type_enum.dart';
import 'package:capstone_project/views/hompage/services/drone_connection_status_service.dart';
import 'package:mobx/mobx.dart';
part 'drone_connection_view_model.g.dart';

class DroneConnectionViewModel = _DroneConnectionViewModelBase with _$DroneConnectionViewModel;

abstract class _DroneConnectionViewModelBase with Store, BaseViewModel{
  late final DroneConnectionStatusService dcss;

  @observable
  String status = "Not Connected";

  @observable
  bool isLoading = true;


  @override
  void setContext(context) => this.context = context;

  @override 
  void init(){
    dcss = DroneConnectionStatusService(setStatus: setStatus);
    dcss.checkStatus();
  }
  
  @observable
  bool isConnected = false;

  

  @action
  void setStatus(DroneConnectionStatusTypeEnum statusTypesEnum, String message ){
    if(statusTypesEnum == DroneConnectionStatusTypeEnum.SUCCESS) 
    {
        isLoading = false;
        status = message;
        isConnected= true;
    }
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