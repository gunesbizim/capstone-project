import 'package:capstone_project/core/base/model/base_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
part 'flight_controller_view_model.g.dart';

class FlightControllerViewModel = _FlightControllerViewModelBase with _$FlightControllerViewModel;

abstract class _FlightControllerViewModelBase with Store, BaseViewModel {
  
  @observable
  double x = 80;
  @observable
  double y = 80;


  @override
  void setContext(context) => this.context = context;
  @override
  void init(){

  }

  @action 
  void setPosition(RenderBox box, Offset globalPosition){
    Offset pos = box.globalToLocal(globalPosition);
    x = pos.dx;
    y= pos.dy;
    print("($x,$y");
  }
}