// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drone_connection_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DroneConnectionViewModel on _DroneConnectionViewModelBase, Store {
  final _$statusAtom = Atom(name: '_DroneConnectionViewModelBase.status');

  @override
  String get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(String value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
    });
  }

  final _$_DroneConnectionViewModelBaseActionController =
      ActionController(name: '_DroneConnectionViewModelBase');

  @override
  void isConnected() {
    final _$actionInfo = _$_DroneConnectionViewModelBaseActionController
        .startAction(name: '_DroneConnectionViewModelBase.isConnected');
    try {
      return super.isConnected();
    } finally {
      _$_DroneConnectionViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void checkConnection() {
    final _$actionInfo = _$_DroneConnectionViewModelBaseActionController
        .startAction(name: '_DroneConnectionViewModelBase.checkConnection');
    try {
      return super.checkConnection();
    } finally {
      _$_DroneConnectionViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
status: ${status}
    ''';
  }
}
