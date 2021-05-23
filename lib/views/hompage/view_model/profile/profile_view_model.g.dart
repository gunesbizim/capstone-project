// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProfileViewModel on _ProfileViewModelBase, Store {
  final _$hasPPAtom = Atom(name: '_ProfileViewModelBase.hasPP');

  @override
  bool get hasPP {
    _$hasPPAtom.reportRead();
    return super.hasPP;
  }

  @override
  set hasPP(bool value) {
    _$hasPPAtom.reportWrite(value, super.hasPP, () {
      super.hasPP = value;
    });
  }

  final _$ppURLAtom = Atom(name: '_ProfileViewModelBase.ppURL');

  @override
  String get ppURL {
    _$ppURLAtom.reportRead();
    return super.ppURL;
  }

  @override
  set ppURL(String value) {
    _$ppURLAtom.reportWrite(value, super.ppURL, () {
      super.ppURL = value;
    });
  }

  final _$userNameAtom = Atom(name: '_ProfileViewModelBase.userName');

  @override
  String get userName {
    _$userNameAtom.reportRead();
    return super.userName;
  }

  @override
  set userName(String value) {
    _$userNameAtom.reportWrite(value, super.userName, () {
      super.userName = value;
    });
  }

  final _$flightTimeAtom = Atom(name: '_ProfileViewModelBase.flightTime');

  @override
  String get flightTime {
    _$flightTimeAtom.reportRead();
    return super.flightTime;
  }

  @override
  set flightTime(String value) {
    _$flightTimeAtom.reportWrite(value, super.flightTime, () {
      super.flightTime = value;
    });
  }

  @override
  String toString() {
    return '''
hasPP: ${hasPP},
ppURL: ${ppURL},
userName: ${userName},
flightTime: ${flightTime}
    ''';
  }
}
