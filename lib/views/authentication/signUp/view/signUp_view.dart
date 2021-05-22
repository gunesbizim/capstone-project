import 'package:capstone_project/core/components/logo.dart';
import 'package:capstone_project/core/base/view/base_widget.dart';
import 'package:capstone_project/core/constants/app_colors.dart';
import 'package:capstone_project/views/authentication/validation.dart';
import 'package:capstone_project/views/authentication/signUp/view_model/signUp_view_model.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignupView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MediaQueryData data = MediaQuery.of(context);
    double height = data.size.height;
    return BaseView(
        viewModel: SignUpViewModel(),
        onPageBuilder: (BuildContext context, SignUpViewModel value) =>
            Container(
                decoration: BoxDecoration(
                  gradient: AppColors.backgroundGradient,
                ),
                child: Scaffold(
                    backgroundColor: Colors.transparent,
                    body: SingleChildScrollView(
                        child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: height * 0.13,
                          ),
                          ZettLogo(height: height * 0.3),
                          SizedBox(
                            height: height * 0.03,
                            child: Text("FLY HIGH"),
                          ),
                          Column(
                            children: [
                              Container(
                                height: 75,
                                child: buildForm(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )))),
        onModelReady: (model) {});
  }

  Form buildForm() {
    return Form(
      // ignore: deprecated_member_use
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          buildFullNameField(),
          buildEmailField(),
          buildPasswordField()
        ],
      ),
    );
  }

  TextFormField buildEmailField() {
    return TextFormField(
      decoration: buildInputDecoration("Email", "example@example.com"),
      validator: (value) {
        if (value == null || value.isEmpty) return "Email can not be empty!";
        return EmailValidator.validate(value)
            ? null
            : "Please enter a valid email";
      },
    );
  }

  TextFormField buildFullNameField() {
    return TextFormField(
      obscureText: true,
      decoration: buildInputDecoration("Full Name", "Zett Flies"),
      validator: (value) {
        if (value == null || value.isEmpty)
          return "Full name can not be empty !";
      },
    );
  }

  Column buildPasswordField() {
    return Column(
      children: [
        TextFormField(
          obscureText: true,
          decoration: buildInputDecoration("Password", "Zett123!"),
          validator: (value) {
            if (value == null || value.isEmpty)
              return "Password can not be empty!";
            return PasswordValidator.validate(value)
                ? null
                : "Invalid Password";
          },
        ),
        TextFormField(
          obscureText: true,
          decoration: buildInputDecoration("Confirm Password", "Zett123!"),
          validator: (value) {
            if (value == null || value.isEmpty)
              return "Confirm password can not be empty!";
            return PasswordValidator.validate(value)
                ? null
                : "Invalid confirm password";
          },
        )
      ],
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
