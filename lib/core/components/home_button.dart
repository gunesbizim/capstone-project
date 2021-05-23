
import 'package:capstone_project/core/constants/app_colors.dart';
import 'package:capstone_project/services/navigation/navigation_service.dart';
import 'package:flutter/material.dart';
//TODO: Solve the Inkwell Problem
class HomeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Material(
                color: Colors.transparent,
                child:  Container(
                    height: 50,
                    width: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: AppColors.homeButtonGradient,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(42),topRight: Radius.circular(42)),
                    ),
                    child: InkWell(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(42),topRight: Radius.circular(42)),
                  splashColor: Colors.white,
                  onTap: (){
                    print("what the damn hell");
                    if(Navigator.of(context).canPop())
                      Navigator.of(context).pop();
                  }
                  ),
                ),
              ),
      ],
    );
  }
}