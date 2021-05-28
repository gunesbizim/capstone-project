import 'package:capstone_project/core/base/model/base_view_model.dart';
import 'package:mobx/mobx.dart';
part 'flight_controller_view_model.g.dart';

class FlightControllerViewModel = _FlightControllerViewModelBase with _$FlightControllerViewModel;

abstract class _FlightControllerViewModelBase with Store, BaseViewModel {
  
  @override
  void setContext(context) => this.context = context;
  @override
  void init(){
    
  }
}