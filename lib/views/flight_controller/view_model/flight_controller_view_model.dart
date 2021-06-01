import 'package:capstone_project/core/base/model/base_view_model.dart';
import 'package:capstone_project/views/flight_controller/services/flight_data_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
part 'flight_controller_view_model.g.dart';

class FlightControllerViewModel = _FlightControllerViewModelBase with _$FlightControllerViewModel;

abstract class _FlightControllerViewModelBase with Store, BaseViewModel {
  
  @observable
  double leftX = 160;
  @observable
  double leftY = 400;

  @observable
  double rightX = 80;
  @observable
  double rightY = 80;

  late final double _normalLeftX;
  late final double _normalLeftY;

  @override
  void setContext(context) => this.context = context;

  late final FlightDataService flightDataService;

  @override
  void init(){
    flightDataService = FlightDataService.instance;
    MediaQueryData queryData = MediaQuery.of(this.context!);
    double screenWidth = queryData.size.width;
    double screenHeight = queryData.size.height;
    _normalLeftX = screenWidth*0.13;
    _normalLeftY = screenHeight*0.70;
    print("_normalLeftX: $_normalLeftX");
    print("_normalLeftY: $_normalLeftY");
    leftX = _normalLeftX;
    leftY = _normalLeftY;    
  }

  @action 
  Offset setPositionLeft( Offset localPosition){
    //Offset localPosition = box.globalToLocal(globalPosition);
    leftX = localPosition.dx;
    leftY= localPosition.dy;
    return Offset(leftX,leftY);
  }

  @action
  setPositionToNormalLeft(){
    leftX = _normalLeftX;
    leftY = _normalLeftY;
  }

  @action 
  Offset setPositionRight( Offset localPosition){
    //Offset localPosition = box.globalToLocal(globalPosition);
    rightX = localPosition.dx;
    rightY= localPosition.dy;
    return Offset(rightX,rightY);
  }

  @action
  Future<void> onDirectionChangedLeft(double degrees, double distance) async{
    if(degrees==0.0&& distance==0.0){
      setPositionToNormalLeft();
    }
    print("directionChanged degrees $degrees");
    print("directionChanged distance $distance");
    
  }

}


enum JojystrickPosition{
  left,
  rigth
}