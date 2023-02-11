import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:clerk/app/modules/onboarding/cubit/on_boarding_cubit.dart';
import 'package:clerk/app/modules/onboarding/views/onboarding_view.dart';
import 'package:clerk/app/values/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../main.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // Future.delayed(Duration(milliseconds: 3000)).then(
    //   (value) {
    //     navigatorKey.currentState?.pushReplacement(OnBoardingView.getRoute());
    //   },
    // );

    return Scaffold(
      body: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              gradient: RadialGradient(
            center: Alignment(0.0, 0.0), // near the top right
            radius: 2.0,
            colors: <Color>[
              primaryColor, // blue sky
              lightPrimaryColor, // yellow sun
            ],
            stops: <double>[0.3, 0.8],
          )),
          child: Text("CLERK",
              style: GoogleFonts.kalam(
                textStyle: TextStyle(
                  fontSize: 56.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  color: backgroundColor,
                ),
              ))),
    );
  }
}
