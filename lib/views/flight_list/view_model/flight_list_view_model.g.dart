// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flight_list_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FlightListViewModel on _FlightListViewModelBase, Store {
  final _$dropDownValueAtom =
      Atom(name: '_FlightListViewModelBase.dropDownValue');

  @override
  String get dropDownValue {
    _$dropDownValueAtom.reportRead();
    return super.dropDownValue;
  }

  @override
  set dropDownValue(String value) {
    _$dropDownValueAtom.reportWrite(value, super.dropDownValue, () {
      super.dropDownValue = value;
    });
  }

  final _$_FlightListViewModelBaseActionController =
      ActionController(name: '_FlightListViewModelBase');

  @override
  Future<void> getDocumentsNext() {
    final _$actionInfo = _$_FlightListViewModelBaseActionController.startAction(
        name: '_FlightListViewModelBase.getDocumentsNext');
    try {
      return super.getDocumentsNext();
    } finally {
      _$_FlightListViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<void> getDocuments() {
    final _$actionInfo = _$_FlightListViewModelBaseActionController.startAction(
        name: '_FlightListViewModelBase.getDocuments');
    try {
      return super.getDocuments();
    } finally {
      _$_FlightListViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void dropDownValueChanged(dynamic value) {
    final _$actionInfo = _$_FlightListViewModelBaseActionController.startAction(
        name: '_FlightListViewModelBase.dropDownValueChanged');
    try {
      return super.dropDownValueChanged(value);
    } finally {
      _$_FlightListViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
dropDownValue: ${dropDownValue}
    ''';
  }
}
