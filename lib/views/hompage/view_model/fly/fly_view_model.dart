import 'package:capstone_project/core/base/model/base_view_model.dart';
import 'package:capstone_project/views/hompage/view_model/drone/drone_connection_view_model.dart';

import 'package:mobx/mobx.dart';
part 'fly_view_model.g.dart';

class FlyViewModel = _FlyViewModelBase with _$FlyViewModel;

abstract class _FlyViewModelBase  with BaseViewModel, Store {  
  late final DroneConnectionViewModel droneConnectionViewModel;
  @override
  void setContext(context) => this.context = context;

  @override
  void init() {
  }


  void setDroneConnectionViewModel(DroneConnectionViewModel droneConnectionViewModel){
    this.droneConnectionViewModel = droneConnectionViewModel;
  }

  @computed
  bool get isConnected => droneConnectionViewModel.isConnected;
  
  
}