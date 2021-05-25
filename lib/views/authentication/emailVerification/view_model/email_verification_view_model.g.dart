// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_verification_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$EmailVerificationViewModel on _EmailVerificationViewModelBase, Store {
  final _$emailAtom = Atom(name: '_EmailVerificationViewModelBase.email');

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  final _$_EmailVerificationViewModelBaseActionController =
      ActionController(name: '_EmailVerificationViewModelBase');

  @override
  void updateEmail() {
    final _$actionInfo = _$_EmailVerificationViewModelBaseActionController
        .startAction(name: '_EmailVerificationViewModelBase.updateEmail');
    try {
      return super.updateEmail();
    } finally {
      _$_EmailVerificationViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
email: ${email}
    ''';
  }
}
