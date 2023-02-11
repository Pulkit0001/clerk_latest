import 'package:clerk/app/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClerkProgressIndicator extends StatelessWidget {
  const ClerkProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Center(
          child: Container(
            height: constraints.maxHeight * 0.12,
            width: constraints.maxHeight * 0.12,
            child: CircularProgressIndicator(
              color: primaryColor,
            ),
          ),
        );
      }
    );
  }
}
