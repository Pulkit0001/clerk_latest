
import 'package:clerk/app/values/colors.dart';
import 'package:clerk/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSnackBar {
  static void show(
      {required String title, required String body, int duration = 2000}) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
        SnackBar(
          dismissDirection: DismissDirection.up,
          behavior: SnackBarBehavior.floating,
          backgroundColor: primaryColor,
          margin: EdgeInsets.fromLTRB(12.w,0, 12.w, 12.h),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
              ),
              Text(body),
            ],
          ),
        ),
      );
    });
  }
}
