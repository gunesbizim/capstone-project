// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flight_controller_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FlightControllerViewModel on _FlightControllerViewModelBase, Store {
  final _$xAtom = Atom(name: '_FlightControllerViewModelBase.x');

  @override
  double get x {
    _$xAtom.reportRead();
    return super.x;
  }

  @override
  set x(double value) {
    _$xAtom.reportWrite(value, super.x, () {
      super.x = value;
    });
  }

  final _$yAtom = Atom(name: '_FlightControllerViewModelBase.y');

  @override
  double get y {
    _$yAtom.reportRead();
    return super.y;
  }

  @override
  set y(double value) {
    _$yAtom.reportWrite(value, super.y, () {
      super.y = value;
    });
  }

  final _$_FlightControllerViewModelBaseActionController =
      ActionController(name: '_FlightControllerViewModelBase');

  @override
  void setPosition(RenderBox box, Offset globalPosition) {
    final _$actionInfo = _$_FlightControllerViewModelBaseActionController
        .startAction(name: '_FlightControllerViewModelBase.setPosition');
    try {
      return super.setPosition(box, globalPosition);
    } finally {
      _$_FlightControllerViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
x: ${x},
y: ${y}
    ''';
  }
}
