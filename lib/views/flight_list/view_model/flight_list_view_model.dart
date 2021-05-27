
import 'package:capstone_project/core/base/model/base_view_model.dart';
import 'package:capstone_project/core/constants/sorting_constants.dart';
import 'package:capstone_project/views/flight_list/Model/flight_log_item_model.dart';
import 'package:capstone_project/views/flight_list/services/flight_list_load_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
part 'flight_list_view_model.g.dart';

class FlightListViewModel = _FlightListViewModelBase with _$FlightListViewModel;

abstract class _FlightListViewModelBase with BaseViewModel, Store {
  late FlightListLoadService flightListLoadService;
  ScrollController scrollController = new ScrollController();
  

  late final List<DropdownMenuItem> dropdownWidgetList;

  @observable
  String dropDownValue = SortingConstants.FLIGHT_DATE_ASCENDING.name;

  late ObservableList<FlightLogItemModel> flights;

  @override 
  setContext(context) => this.context = context;

  @override
  void init(){
    print("list view model init");
    flights = ObservableList<FlightLogItemModel>();
     dropdownWidgetList = <SortingConstants>[
       SortingConstants.FLIGHT_DATE_ASCENDING,
       SortingConstants.FLIGHT_DATE_DESCENDING,
       SortingConstants.FLIGHT_DURATION_ASCENDING,
       SortingConstants.FLIGHT_DURATION_DESCENDING,
       
       ]
          .map<DropdownMenuItem<String>>((SortingConstants value) {
        return DropdownMenuItem<String>(
          value: value.name,
          child: value.getChild,
        );
      }).toList();
    flightListLoadService = FlightListLoadService(flights: flights);
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels == 0)
          print('ListView scroll at top');
        else {
          print('ListView scroll at bottom');
          getDocumentsNext(); // Load next documents
        }
      }
    });
    getDocuments();
  }


  @action
  Future<void> getDocumentsNext() => flightListLoadService.getDocumentsNext(dropDownValue);

  @action
  Future<void> getDocuments() => flightListLoadService.getDocuments(dropDownValue);

  @action 
  void dropDownValueChanged(var value){
    print("------------------------------------------");
    print("dropdown value: $value");
    dropDownValue = value;
    getDocuments();

  }
 }