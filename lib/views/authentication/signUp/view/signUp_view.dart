import 'package:capstone_project/core/components/logo.dart';
import 'package:capstone_project/core/base/view/base_widget.dart';
import 'package:capstone_project/core/constants/app_colors.dart';
import 'package:capstone_project/views/authentication/validation.dart';
import 'package:capstone_project/views/authentication/signUp/view_model/signUp_view_model.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class SignupView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MediaQueryData data = MediaQuery.of(context);
    double height = data.size.height;
    double width = data.size.width;
    return BaseView<SignupViewModel>(
        viewModel: SignupViewModel(),
        onPageBuilder: (BuildContext context, SignupViewModel value) =>
            Container(
                decoration: BoxDecoration(
                  gradient: AppColors.backgroundGradient,
                ),
                child: Scaffold(
                    backgroundColor: Colors.transparent,
                    body: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: height * 0.13,
                            width: width * 1,
                          ),
                          ZettLogo(height: height * 0.3),
                          SizedBox(
                            height: height * 0.05,
                            child: Text(
                              "FLY HIGH",
                              style: TextStyle(
                                  color: AppColors.primaryBlue, fontSize: 16),
                            ),
                          ),
                          Container(
                            width: data.size.width * 0.75,
                            child: Column(
                              children: [
                                Container(
                                  child: buildForm(value, data),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ))),
        onModelReady: (model) {
          model.setContext(context);
          model.init();
        });
  }

  Form buildForm(SignupViewModel model, MediaQueryData data) {
    return Form(
      key: model.globalFormState,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: buildFullNameField(model),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: buildEmailField(model),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: buildPasswordField(model),
          ),
          Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: buildSignUpButton(model, data)),
        ],
      ),
    );
  }

//  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  TextFormField buildEmailField(SignupViewModel signUpViewModel) {
    return TextFormField(
      controller: signUpViewModel.emailCntrl,
      decoration: buildInputDecoration("Email", "example@example.com"),
      validator: (value) {
        if (value == null || value.isEmpty) return "Email can not be empty!";
        return EmailValidator.validate(value)
            ? null
            : "Please enter a valid email";
      },
    );
  }

  TextFormField buildFullNameField(SignupViewModel signUpViewModel) {
    return TextFormField(
      controller: signUpViewModel.nameCntrl,
      decoration: buildInputDecoration("Full Name", "Zett Flies"),
      validator: (value) {
        if (value == null || value.isEmpty)
          return "Full name can not be empty !";
      },
    );
  }

  Column buildPasswordField(SignupViewModel signUpViewModel) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: TextFormField(
            controller: signUpViewModel.pwCntrl,
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
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: TextFormField(
            controller: signUpViewModel.pw2Cntrl,
            obscureText: true,
            decoration: buildInputDecoration("Confirm Password", "Zett123!"),
            validator: (value) {
              if (value == null || value.isEmpty)
                return "Confirm password can not be empty!";
              return PasswordValidator.validate(value)
                  ? null
                  : "Invalid confirm password";
            },
          ),
        )
      ],
    );
  }

  Observer buildSignUpButton(
      SignupViewModel signUpViewModel, MediaQueryData data) {
    return Observer(
      builder: (_) {
        return Container(
          height: data.size.height * 0.05,
          width: data.size.width * 0.27,
          child: Material(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            color: AppColors.primaryBlue,
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              child: Center(
                  child: Text("SIGN UP",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ))),
              onTap: signUpViewModel.isLoading
                  ? null
                  : () {
                      signUpViewModel.signUp();
                    },
            ),
          ),
        );
      },
    );
  }

  InputDecoration buildInputDecoration(String labelText, String hintext) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintext,
      alignLabelWithHint: false,
      contentPadding: EdgeInsets.symmetric(vertical: 3, horizontal: 16),
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
      labelStyle: TextStyle(color: Color.fromRGBO(203, 203, 203, 1)),
    );
  }
}
