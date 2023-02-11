import 'package:clerk/app/utils/extensions.dart';
import 'package:clerk/app/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:steps_indicator/steps_indicator.dart';

class CustomStepper extends StatelessWidget {
  const CustomStepper(
      {Key? key, required this.steps, required this.currentStep})
      : super(key: key);

  final int steps;
  final int currentStep;

  @override
  Widget build(BuildContext context) {
    return StepsIndicator(
      selectedStep: currentStep,
      nbSteps: steps,
      doneLineColor: primaryColor,
      doneStepColor: primaryColor,
      doneLineThickness: 4.w,
      doneStepSize: 24.w,
      undoneLineColor: Colors.black12,
      undoneLineThickness: 4.w,
      selectedStepBorderSize: 1,
      selectedStepSize: 24.w,
      selectedStepColorIn: lightPrimaryColor,
      selectedStepColorOut: primaryColor,
      doneStepWidget: Container(
        height: 28.w,
        width: 28.w,
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(color: primaryColor, shape: BoxShape.circle),
        child: Icon(
          Icons.check_rounded,
          color: backgroundColor,
          size: 20.w,
        ),
      ),
      unselectedStepWidget: Container(
        height: 28.w,
        width: 28.w,
        padding: EdgeInsets.all(4.w),
        decoration:
            BoxDecoration(color: Colors.black12, shape: BoxShape.circle),
        child: Icon(
          Icons.check_rounded,
          color: Colors.black26,
          size: 20.w,
        ),
      ),
      selectedStepWidget: Container(
        height: 28.w,
        width: 28.w,
        padding: EdgeInsets.all(4.w),
        decoration:
            BoxDecoration(color: lightPrimaryColor, shape: BoxShape.circle),
        child: Icon(
          Icons.check_rounded,
          color: backgroundColor,
          size: 20.w,
        ),
      ),
      lineLength: (context.width - 28 - steps * (28.w)) / steps,
      // lineLengthCustomStep: [
      //   StepsIndicatorCustomLine(nbStep: currentStep+2, length: (Get.size.width - 28 - 140.w) / 5 + 40.w)
      // ],
      enableLineAnimation: true,
      enableStepAnimation: true,
    );
  }
}
