
import 'package:json_annotation/json_annotation.dart';
part 'lohin_model.g.dart';

@JsonSerializable()
class LoginModel{
  final String email;
  final String password;

  LoginModel(
    {
      required this.email,
      required this.password
    }
  )
}