// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flightlog_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FlightLogViewModel on _FlightLogViewModelBase, Store {
  final _$lastFlightAtom = Atom(name: '_FlightLogViewModelBase.lastFlight');

  @override
  String get lastFlight {
    _$lastFlightAtom.reportRead();
    return super.lastFlight;
  }

  @override
  set lastFlight(String value) {
    _$lastFlightAtom.reportWrite(value, super.lastFlight, () {
      super.lastFlight = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_FlightLogViewModelBase.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$_FlightLogViewModelBaseActionController =
      ActionController(name: '_FlightLogViewModelBase');

  @override
  void getLastDate() {
    final _$actionInfo = _$_FlightLogViewModelBaseActionController.startAction(
        name: '_FlightLogViewModelBase.getLastDate');
    try {
      return super.getLastDate();
    } finally {
      _$_FlightLogViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeDate(String date) {
    final _$actionInfo = _$_FlightLogViewModelBaseActionController.startAction(
        name: '_FlightLogViewModelBase.changeDate');
    try {
      return super.changeDate(date);
    } finally {
      _$_FlightLogViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void loadList() {
    final _$actionInfo = _$_FlightLogViewModelBaseActionController.startAction(
        name: '_FlightLogViewModelBase.loadList');
    try {
      return super.loadList();
    } finally {
      _$_FlightLogViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLastFlight(String lf) {
    final _$actionInfo = _$_FlightLogViewModelBaseActionController.startAction(
        name: '_FlightLogViewModelBase.setLastFlight');
    try {
      return super.setLastFlight(lf);
    } finally {
      _$_FlightLogViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
lastFlight: ${lastFlight},
isLoading: ${isLoading}
    ''';
  }
}
