import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../values/colors.dart';





class CustomDivider extends StatelessWidget {
  const CustomDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          Expanded(child: Divider(
            color: backgroundColor,
            thickness: 1,
          )),
          Text(
            "  or  ",
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    color: backgroundColor,
                    fontSize: 15.sp,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w300
                  // height: 2
                )
            ),
          ),
          Expanded(child: Divider(
            color: backgroundColor,
            thickness: 1,

          ))
        ],
      ),
    );
  }
}
