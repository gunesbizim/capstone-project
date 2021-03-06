// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProfileViewModel on _ProfileViewModelBase, Store {
  final _$imageAtom = Atom(name: '_ProfileViewModelBase.image');

  @override
  dynamic get image {
    _$imageAtom.reportRead();
    return super.image;
  }

  @override
  set image(dynamic value) {
    _$imageAtom.reportWrite(value, super.image, () {
      super.image = value;
    });
  }

  final _$isLoadedAtom = Atom(name: '_ProfileViewModelBase.isLoaded');

  @override
  bool get isLoaded {
    _$isLoadedAtom.reportRead();
    return super.isLoaded;
  }

  @override
  set isLoaded(bool value) {
    _$isLoadedAtom.reportWrite(value, super.isLoaded, () {
      super.isLoaded = value;
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

  final _$getUserDetailsAsyncAction =
      AsyncAction('_ProfileViewModelBase.getUserDetails');

  @override
  Future<dynamic> getUserDetails() {
    return _$getUserDetailsAsyncAction.run(() => super.getUserDetails());
  }

  final _$selectImageAsyncAction =
      AsyncAction('_ProfileViewModelBase.selectImage');

  @override
  Future<dynamic> selectImage(ProfilePictureEnums mode) {
    return _$selectImageAsyncAction.run(() => super.selectImage(mode));
  }

  @override
  String toString() {
    return '''
image: ${image},
isLoaded: ${isLoaded},
ppURL: ${ppURL},
userName: ${userName},
flightTime: ${flightTime}
    ''';
  }
}
