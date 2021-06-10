
import 'dart:ffi';

import 'package:capstone_project/core/base/model/base_view_model.dart';
import 'package:capstone_project/core/constants/values/route_constants.dart';
import 'package:capstone_project/services/fire_store_service.dart';
import 'package:capstone_project/services/navigation/navigation_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'flightlog_view_model.g.dart';

class FlightLogViewModel = _FlightLogViewModelBase with _$FlightLogViewModel;

abstract class _FlightLogViewModelBase with Store, BaseViewModel{
  late FireStoreService fireStoreService;

  @observable
  String lastFlight = "No Flight";

  
  @observable
  bool isLoading = false;

  @override
  void setContext(BuildContext context) => this.context = context;

  @override
  void init() {
    fireStoreService = FireStoreService.instance;
    getLastDate();
  }
  @action
  void getLastDate(){
    fireStoreService.getLastFlight(changeDate);
  }
  @action
  void changeDate(String date){
    lastFlight = date;
  }

  @action
  void loadList() {
    NavigationService.instance.navigateToPage(path: RouteConstants.LOGS,data: []);
  }

  @action
  void setLastFlight(String lf) => lastFlight = lf;
}