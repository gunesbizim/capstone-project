import 'package:capstone_project/core/base/model/base_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
part 'flight_controller_view_model.g.dart';

class FlightControllerViewModel = _FlightControllerViewModelBase with _$FlightControllerViewModel;

abstract class _FlightControllerViewModelBase with Store, BaseViewModel {
  
  @observable
  double leftX = 160;
  @observable
  double leftY = 160;

  @observable
  double rightX = 80;
  @observable
  double rightY = 80;

  @override
  void setContext(context) => this.context = context;
  @override
  void init(){

  }

  @action 
  Offset setPositionLeft(RenderBox box, Offset globalPosition){
    Offset pos = box.globalToLocal(globalPosition);
    leftX = pos.dx;
    leftY= pos.dy;
    return Offset(leftX,leftY);
  }

  @action
  setPositionToNormalLeft(){
    leftX = 80;
    leftY = 80;
  }

  @action
  Future<void> onDirectionChangedLeft(double degrees, double distance) async{
    if(degrees==0.0&& distance==0.0){
      setPositionToNormalLeft();
    }
  }

}


enum JojystrickPosition{
  left,
  rigth
}