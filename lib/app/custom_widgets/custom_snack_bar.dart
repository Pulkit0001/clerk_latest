import 'package:clerk/app/values/colors.dart';
import 'package:clerk/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSnackBar {
  static void show(
      {required String title, required String body, int duration = 2000}) {
    ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
      SnackBar(
        backgroundColor: primaryColor,
        margin: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
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
  }
}
