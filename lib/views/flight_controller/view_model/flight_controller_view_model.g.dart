// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flight_controller_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FlightControllerViewModel on _FlightControllerViewModelBase, Store {
  final _$leftXAtom = Atom(name: '_FlightControllerViewModelBase.leftX');

  @override
  double get leftX {
    _$leftXAtom.reportRead();
    return super.leftX;
  }

  @override
  set leftX(double value) {
    _$leftXAtom.reportWrite(value, super.leftX, () {
      super.leftX = value;
    });
  }

  final _$leftYAtom = Atom(name: '_FlightControllerViewModelBase.leftY');

  @override
  double get leftY {
    _$leftYAtom.reportRead();
    return super.leftY;
  }

  @override
  set leftY(double value) {
    _$leftYAtom.reportWrite(value, super.leftY, () {
      super.leftY = value;
    });
  }

  final _$rightXAtom = Atom(name: '_FlightControllerViewModelBase.rightX');

  @override
  double get rightX {
    _$rightXAtom.reportRead();
    return super.rightX;
  }

  @override
  set rightX(double value) {
    _$rightXAtom.reportWrite(value, super.rightX, () {
      super.rightX = value;
    });
  }

  final _$rightYAtom = Atom(name: '_FlightControllerViewModelBase.rightY');

  @override
  double get rightY {
    _$rightYAtom.reportRead();
    return super.rightY;
  }

  @override
  set rightY(double value) {
    _$rightYAtom.reportWrite(value, super.rightY, () {
      super.rightY = value;
    });
  }

  final _$onDirectionChangedLeftAsyncAction =
      AsyncAction('_FlightControllerViewModelBase.onDirectionChangedLeft');

  @override
  Future<void> onDirectionChangedLeft(double degrees, double distance) {
    return _$onDirectionChangedLeftAsyncAction
        .run(() => super.onDirectionChangedLeft(degrees, distance));
  }

  final _$_FlightControllerViewModelBaseActionController =
      ActionController(name: '_FlightControllerViewModelBase');

  @override
  Offset setPositionLeft(RenderBox box, Offset globalPosition) {
    final _$actionInfo = _$_FlightControllerViewModelBaseActionController
        .startAction(name: '_FlightControllerViewModelBase.setPositionLeft');
    try {
      return super.setPositionLeft(box, globalPosition);
    } finally {
      _$_FlightControllerViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setPositionToNormalLeft() {
    final _$actionInfo =
        _$_FlightControllerViewModelBaseActionController.startAction(
            name: '_FlightControllerViewModelBase.setPositionToNormalLeft');
    try {
      return super.setPositionToNormalLeft();
    } finally {
      _$_FlightControllerViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
leftX: ${leftX},
leftY: ${leftY},
rightX: ${rightX},
rightY: ${rightY}
    ''';
  }
}
