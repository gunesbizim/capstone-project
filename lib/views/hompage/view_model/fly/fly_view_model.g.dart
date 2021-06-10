// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fly_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FlyViewModel on _FlyViewModelBase, Store {
  Computed<bool>? _$isConnectedComputed;

  @override
  bool get isConnected =>
      (_$isConnectedComputed ??= Computed<bool>(() => super.isConnected,
              name: '_FlyViewModelBase.isConnected'))
          .value;

  final _$flyButtonTextAtom = Atom(name: '_FlyViewModelBase.flyButtonText');

  @override
  String get flyButtonText {
    _$flyButtonTextAtom.reportRead();
    return super.flyButtonText;
  }

  @override
  set flyButtonText(String value) {
    _$flyButtonTextAtom.reportWrite(value, super.flyButtonText, () {
      super.flyButtonText = value;
    });
  }

  final _$isStartingAtom = Atom(name: '_FlyViewModelBase.isStarting');

  @override
  bool get isStarting {
    _$isStartingAtom.reportRead();
    return super.isStarting;
  }

  @override
  set isStarting(bool value) {
    _$isStartingAtom.reportWrite(value, super.isStarting, () {
      super.isStarting = value;
    });
  }

  final _$startAtom = Atom(name: '_FlyViewModelBase.start');

  @override
  int get start {
    _$startAtom.reportRead();
    return super.start;
  }

  @override
  set start(int value) {
    _$startAtom.reportWrite(value, super.start, () {
      super.start = value;
    });
  }

  final _$_FlyViewModelBaseActionController =
      ActionController(name: '_FlyViewModelBase');

  @override
  void startFlight() {
    final _$actionInfo = _$_FlyViewModelBaseActionController.startAction(
        name: '_FlyViewModelBase.startFlight');
    try {
      return super.startFlight();
    } finally {
      _$_FlyViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFlightButtonText(String text) {
    final _$actionInfo = _$_FlyViewModelBaseActionController.startAction(
        name: '_FlyViewModelBase.setFlightButtonText');
    try {
      return super.setFlightButtonText(text);
    } finally {
      _$_FlyViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIsStarting() {
    final _$actionInfo = _$_FlyViewModelBaseActionController.startAction(
        name: '_FlyViewModelBase.setIsStarting');
    try {
      return super.setIsStarting();
    } finally {
      _$_FlyViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void startTimer() {
    final _$actionInfo = _$_FlyViewModelBaseActionController.startAction(
        name: '_FlyViewModelBase.startTimer');
    try {
      return super.startTimer();
    } finally {
      _$_FlyViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
flyButtonText: ${flyButtonText},
isStarting: ${isStarting},
start: ${start},
isConnected: ${isConnected}
    ''';
  }
}
