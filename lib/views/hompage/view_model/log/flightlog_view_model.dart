
import 'dart:ffi';

import 'package:capstone_project/core/base/model/base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'flightlog_view_model.g.dart';

class FlightLogViewModel = _FlightLogViewModelBase with _$FlightLogViewModel;

abstract class _FlightLogViewModelBase with Store, BaseViewModel{
  @observable
  String lastFlight = "No Flight";

  @override
  void setContext(BuildContext context) => this.context = context;
  @override
  void init() {
    print("init");
  }
  @action
  void getLastDate(){
    changeDate("dsfdgfh");
  }
  @action
  void changeDate(String date){
    lastFlight = date;
  }

}