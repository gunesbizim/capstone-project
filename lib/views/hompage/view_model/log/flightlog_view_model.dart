
import 'dart:ffi';

import 'package:capstone_project/core/base/model/base_view_model.dart';
import 'package:capstone_project/core/constants/route_constants.dart';
import 'package:capstone_project/services/FireStore.dart';
import 'package:capstone_project/services/navigation/navigation_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'flightlog_view_model.g.dart';

class FlightLogViewModel = _FlightLogViewModelBase with _$FlightLogViewModel;

abstract class _FlightLogViewModelBase with Store, BaseViewModel{
  late FireStoreService fireStore;

  @observable
  String lastFlight = "No Flight";
  @observable
  bool isLoading = false;

  @override
  void setContext(BuildContext context) => this.context = context;

  @override
  void init() {
    fireStore = FireStoreService(FirebaseFirestore.instance);
    getLastDate();
  }
  @action
  void getLastDate(){
    changeDate("23.05.2020");
  }
  @action
  void changeDate(String date){
    lastFlight = date;
  }

  @action
  void loadList() {
    fireStore.fetchFlightList();
    NavigationService.instance.navigateToPage(path: RouteConstants.LOGS,data: []);

  }
}