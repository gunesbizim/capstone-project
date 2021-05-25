// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drone_connection_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DroneConnectionViewModel on _DroneConnectionViewModelBase, Store {
  Computed<bool>? _$loadingStateComputed;

  @override
  bool get loadingState =>
      (_$loadingStateComputed ??= Computed<bool>(() => super.loadingState,
              name: '_DroneConnectionViewModelBase.loadingState'))
          .value;

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

  final _$isLoadingAtom = Atom(name: '_DroneConnectionViewModelBase.isLoading');

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

  final _$isConnectedAtom =
      Atom(name: '_DroneConnectionViewModelBase.isConnected');

  @override
  bool get isConnected {
    _$isConnectedAtom.reportRead();
    return super.isConnected;
  }

  @override
  set isConnected(bool value) {
    _$isConnectedAtom.reportWrite(value, super.isConnected, () {
      super.isConnected = value;
    });
  }

  final _$checkConnectionAsyncAction =
      AsyncAction('_DroneConnectionViewModelBase.checkConnection');

  @override
  Future<dynamic> checkConnection() {
    return _$checkConnectionAsyncAction.run(() => super.checkConnection());
  }

  final _$_DroneConnectionViewModelBaseActionController =
      ActionController(name: '_DroneConnectionViewModelBase');

  @override
  void setStatus(
      DroneConnectionStatusTypeEnum statusTypesEnum, String message) {
    final _$actionInfo = _$_DroneConnectionViewModelBaseActionController
        .startAction(name: '_DroneConnectionViewModelBase.setStatus');
    try {
      return super.setStatus(statusTypesEnum, message);
    } finally {
      _$_DroneConnectionViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoading() {
    final _$actionInfo = _$_DroneConnectionViewModelBaseActionController
        .startAction(name: '_DroneConnectionViewModelBase.setLoading');
    try {
      return super.setLoading();
    } finally {
      _$_DroneConnectionViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
status: ${status},
isLoading: ${isLoading},
isConnected: ${isConnected},
loadingState: ${loadingState}
    ''';
  }
}
