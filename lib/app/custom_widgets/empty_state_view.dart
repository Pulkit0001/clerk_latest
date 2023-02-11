
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../values/colors.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({
    Key? key, required this.image, required this.message, required this.onActionPressed,
  }) : super(key: key);

  final String image;
  final String message;
  final Function onActionPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal:18.w),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),

          Container(
            height: 100.h,
            child: Placeholder(fallbackHeight: 150.h,
              fallbackWidth: 100.h,),
          ),
          Spacer(),
          Text(
            message,
            textAlign: TextAlign.center,
            style: GoogleFonts.nunitoSans(
                color:  textColor,
                fontWeight: FontWeight.w400,
                fontSize: 18.sp
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          OutlinedButton(
              onPressed: () {
                onActionPressed();
              },
              style: ButtonStyle(
                side: MaterialStateProperty.all(
                    BorderSide(width: 1.5, color: textColor)),
                shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(30)))),
              ),
              child: Text(
                "Let's Create Now",
                style: GoogleFonts.poppins(
                    color: textColor,
                    letterSpacing: .5,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400),
              )),
          Spacer(flex: 2,),

        ],
      ),
    );
  }
}
