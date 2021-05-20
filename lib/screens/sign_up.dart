import 'package:flutter/material.dart';
import '../constant_data/app_colors.dart';
import 'package:gradient_input_border/gradient_input_border.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  var emailCntrl = TextEditingController();
  var nameCntrl = TextEditingController();
  var pwCntrl = TextEditingController();
  var pw2Cntrl = TextEditingController();
  Widget build(BuildContext context) {
    return Container(
      padding: new EdgeInsets.symmetric(horizontal: 60),
      decoration: BoxDecoration(
        gradient: AppColors.backgroundGradient,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 200,
                  width: 200,
                ),
                TextField(
                  controller: emailCntrl,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  decoration: new InputDecoration(
                    prefixIcon: Icon(Icons.atm),
                    border: GradientOutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(30),
                      ),
                      focusedGradient: AppColors.inputBoxGradient,
                      unfocusedGradient: AppColors.inputBoxGradient,
                    ),
                    filled: true,
                    fillColor: const Color(0xffffff).withOpacity(0.15),
                    hintText: 'E-Mail',
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 5,
                    ),
                    hintStyle: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: nameCntrl,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  decoration: new InputDecoration(
                    border: GradientOutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(30),
                      ),
                      focusedGradient: AppColors.inputBoxGradient,
                      unfocusedGradient: AppColors.inputBoxGradient,
                    ),
                    filled: true,
                    fillColor: const Color(0xffffff).withOpacity(0.15),
                    hintText: 'Full Name',
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 5,
                    ),
                    hintStyle: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: pwCntrl,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  decoration: new InputDecoration(
                    border: GradientOutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(30),
                      ),
                      focusedGradient: AppColors.inputBoxGradient,
                      unfocusedGradient: AppColors.inputBoxGradient,
                    ),
                    filled: true,
                    fillColor: const Color(0xffffff).withOpacity(0.15),
                    hintText: 'Password',
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 5,
                    ),
                    hintStyle: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: pw2Cntrl,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  decoration: new InputDecoration(
                    border: GradientOutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(30),
                      ),
                      focusedGradient: AppColors.inputBoxGradient,
                      unfocusedGradient: AppColors.inputBoxGradient,
                    ),
                    filled: true,
                    hintText: 'Confirm Password',
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 5,
                    ),
                    fillColor: const Color(0xffffff).withOpacity(0.15),
                    hintStyle: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 35),
                  decoration: BoxDecoration(
                    color: Color(0xff13ABCD),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Text(
                    "SIGN UP",
                    style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 0.5,
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Text("Have an account ?",
                    style: TextStyle(
                        color: Colors.white, letterSpacing: 0.5, fontSize: 18))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
