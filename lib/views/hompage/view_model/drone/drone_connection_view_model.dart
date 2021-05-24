import 'package:capstone_project/core/base/model/base_view_model.dart';
import 'package:mobx/mobx.dart';
part 'drone_connection_view_model.g.dart';

class DroneConnectionViewModel = _DroneConnectionViewModelBase with _$DroneConnectionViewModel;

abstract class _DroneConnectionViewModelBase with Store, BaseViewModel{
    @observable
  String status = "Connected";

  @override
  void setContext(context) => this.context = context;

  @override 
  void init(){

  }
  
  @action
  void isConnected(){
    
  }

  
  @action
  void checkConnection(){
    
    if(status == "Not Connected" ){
      status = "Connected";
    }else if(status == "Connected"){
      status ="Not Connected";
    }
    print(status);
  }
  
}