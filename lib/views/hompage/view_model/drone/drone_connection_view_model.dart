import 'package:capstone_project/core/base/model/base_view_model.dart';
import 'package:mobx/mobx.dart';
part 'drone_connection_view_model.g.dart';

class DroneConnectionViewModel = _DroneConnectionViewModelBase with _$DroneConnectionViewModel;

abstract class _DroneConnectionViewModelBase with BaseViewModel, Store {
  
  @override
  void setContext(context) => this.context = context;

  @override 
  void init(){

  }
  
  @action
  void isConnected(){
    
  }
}