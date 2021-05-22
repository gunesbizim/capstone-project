import 'package:capstone_project/core/components/logo.dart';
import 'package:capstone_project/core/constants/app_colors.dart';
import 'package:capstone_project/core/base/view/base_widget.dart';
import 'package:capstone_project/views/authentication/login/view_model/login_view_model.dart';
import 'package:capstone_project/views/authentication/validation.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //TODO: connect it with an upper widget
    MediaQueryData data = MediaQuery.of(context);
    double height = data.size.height;
    return BaseView<LoginViewModel>(
        viewModel: LoginViewModel(),
        onPageBuilder: (BuildContext context, LoginViewModel value) =>
            Container(
              decoration: BoxDecoration(gradient: AppColors.backgroundGradient),
              child: Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: height * 0.13,
                      ),
                      ZettLogo(height: height * 0.30),
                      SizedBox(height: height * 0.03, child: Text("FLY HIGH")),
                      Column(
                        children: [
                          Container(height: 75, child: buildEmailForm(value)),
                          buildPasswordForm(value),
                          buildLoginButton(value)
                        ],
                      )
                    ],
                  )),
              alignment: Alignment.center,
            ),
        onModelReady: (model) {});
  }

  Observer buildLoginButton(LoginViewModel loginViewModel) {
    return Observer(
      builder: (_){
        return Container(
                height: 20,
                width: 100,
                child: Material(
                  borderRadius:
                      BorderRadius.all(Radius.circular(30)),
                  color: AppColors.primaryBlue,
                  child: InkWell(
                    borderRadius:
                        BorderRadius.all(Radius.circular(30)),
                    child: Text("LOG IN"),
                    onTap: loginViewModel.isLoading?
                      null:
                      () {
                        loginViewModel.login();
                      },
                  ),
                ),
              );
      },
    );
  }

  Form buildPasswordForm(LoginViewModel loginViewModel) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: buildPasswordField(loginViewModel),
    );
  }

  TextFormField buildPasswordField(LoginViewModel loginViewModel) {
    return TextFormField(
      controller: loginViewModel.emailController,
      obscureText: true,
      decoration: buildInputDecoration("Password", "Zett123!"),
      validator: (value) {
        if (value == null || value.isEmpty) return "Password can not be empty!";
        return PasswordValidator.validate(value) ? null : "Invalid Password";
      },
    );
  }

  Form buildEmailForm(LoginViewModel loginViewModel) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: buildEmailField(loginViewModel),
    );
  }

  TextFormField buildEmailField(LoginViewModel loginViewModel) {
    return TextFormField(
      controller: loginViewModel.emailController,
      decoration: buildInputDecoration("Email", "example@example.com"),
      validator: (value) {
        if (value == null || value.isEmpty) return "Email can not be empty!";
        return EmailValidator.validate(value)
            ? null
            : "Please enter a valid email";
      },
    );
  }

  InputDecoration buildInputDecoration(String labelText, String hintext) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintext,
      alignLabelWithHint: false,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(
            color: AppColors.primaryBlue, width: 2, style: BorderStyle.solid),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide:
            BorderSide(color: Colors.white, width: 1, style: BorderStyle.solid),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(
            color: AppColors.primaryPurple, width: 1, style: BorderStyle.solid),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(
            color: AppColors.primaryPurple, width: 1, style: BorderStyle.solid),
      ),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      filled: true,
      fillColor: Color.fromRGBO(255, 255, 255, 0.15),
      hintStyle: TextStyle(color: Color.fromRGBO(203, 203, 203, 1)),
    );
  }
}
