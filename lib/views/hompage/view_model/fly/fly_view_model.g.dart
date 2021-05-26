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

  @override
  String toString() {
    return '''
isConnected: ${isConnected}
    ''';
  }
}
