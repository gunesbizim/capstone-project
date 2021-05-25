import 'package:capstone_project/core/base/view/base_widget.dart';
import 'package:capstone_project/core/components/logo.dart';
import 'package:capstone_project/core/constants/app_colors.dart';
import 'package:capstone_project/services/navigation/navigation_service.dart';
import 'package:capstone_project/views/authentication/emailVerification/view_model/email_verification_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class EmailVerificationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    MediaQueryData data = MediaQuery.of(context);
    double width = data.size.width;
    double height = data.size.height;
    return BaseView<EmailVerificationViewModel>(
        viewModel: EmailVerificationViewModel(),
        onPageBuilder:
            (BuildContext context, EmailVerificationViewModel value) =>
                Container(
                    decoration: BoxDecoration(
                      gradient: AppColors.backgroundGradient,
                    ),
                    child: Scaffold(
                        backgroundColor: Colors.transparent,
                        body: Center(
                          child: Column(
                            children: [
                              SizedBox(
                                height: height * 0.13,
                              ),
                              ZettLogo(height: height * 0.3),
                              SizedBox(
                                height: height * 0.05,
                                child: Text(
                                  "FLY HIGH",
                                  style: TextStyle(
                                      color: AppColors.primaryBlue,
                                      fontSize: 16),
                                ),
                              ),
                              Container(
                                width: width * 0.75,
                                child: buildForm(value, data),
                              )
                            ],
                          ),
                        ))),
        onModelReady: (model) {
          model.setContext(context);
          model.init();
        });
  }

  Column buildForm(EmailVerificationViewModel model, MediaQueryData data) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Observer(
          builder: (_) => Container(
            child: Text(
              "Verification email sent to ${model.email}",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w300,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          child: Text(
            "You will be automaticly redirected to home page once verification is complete.",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w300,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
            height: data.size.height * 0.05,
            width: data.size.width * 0.3,
            child: Material(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              color: AppColors.primaryBlue,
              child: InkWell(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                child: Center(
                  child: Text(
                    "RESEND",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                ),
                onTap: () {
                  final FirebaseAuth auth = FirebaseAuth.instance;
                  final User? user = auth.currentUser;
                  user!.sendEmailVerification();
                },
              ),
            )),
      ],
    );
  }
}
