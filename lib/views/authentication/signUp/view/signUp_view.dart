import 'package:flutter/cupertino.dart';
import 'package:capstone_project/views/authentication/signUp/view_model/signUp_view_model.dart';
import 'package:capstone_project/core/constants/app_colors.dart';

class SignUpView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    MediaQueryData data = MediaQuery.of(context);
    double height = data.size.height;
    return BaseView<SignUpViewModel>(
      viewModel: SignUpViewModel(),
      onPagebuilder: (BuildContext context, SignUpViewModel value) => Container(
        decoration: BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
      )
    )
  }
}
