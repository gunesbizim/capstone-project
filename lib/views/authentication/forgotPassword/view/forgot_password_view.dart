import 'package:capstone_project/core/components/logo.dart';
import 'package:capstone_project/core/constants/values/app_colors.dart';
import 'package:capstone_project/core/base/view/base_widget.dart';
import 'package:capstone_project/views/authentication/forgotPassword/view_model/forgot_password_view_model.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:capstone_project/core/constants/values/text_constants.dart';

class ForgotPasswordView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //TODO: connect it with an upper widget
    MediaQueryData data = MediaQuery.of(context);
    double height = data.size.height;
    double width = data.size.width;
    return BaseView<ForgotPasswordViewModel>(
        viewModel: ForgotPasswordViewModel(),
        onPageBuilder: (BuildContext context, ForgotPasswordViewModel value) =>
            Container(
              decoration: BoxDecoration(gradient: AppColors.backgroundGradient),
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
                        ZettLogo(height: height * 0.30),
                        SizedBox(
                            height: height * 0.03,
                            child: Text(
                              "FLY HIGH",
                              style: TextStyle(
                                  color: AppColors.primaryBlue, fontSize: 16),
                            )),
                        SizedBox(height: height * 0.01),
                        Container(
                          width: data.size.width * 0.75,
                          child: Column(
                            children: [
                              buildGeneralForm(value),
                              buildLoginButton(data, value),
                              buildDontHaveAnAccount(value),
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
              alignment: Alignment.center,
            ),
        onModelReady: (model) {
          model.setContext(context);
          model.init();
        });
  }

  Observer buildLoginButton(
      MediaQueryData data, ForgotPasswordViewModel forgotPasswordViewModel) {
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
                  child: Text("SUBMIT",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ))),
              onTap: () {
                forgotPasswordViewModel.sendEmail();
              },
            ),
          ),
        );
      },
    );
  }

  Form buildGeneralForm(ForgotPasswordViewModel forgotPasswordViewModel) {
    return Form(
      key: forgotPasswordViewModel.globalFormState,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: buildEmailField(forgotPasswordViewModel),
          ),
        ],
      ),
    );
  }

  Column buildDontHaveAnAccount(ForgotPasswordViewModel value) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        RichText(
          text: TextSpan(
            style: TextConstants.home_screen_14_bold,
            children: <TextSpan>[
              TextSpan(
                text: "Don't have an account ?",
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    value.navigateToSignUp();
                  },
              ),
            ],
          ),
        ),
      ],
    );
  }

  TextFormField buildEmailField(
      ForgotPasswordViewModel forgotPasswordViewModel) {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      controller: forgotPasswordViewModel.emailController,
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
