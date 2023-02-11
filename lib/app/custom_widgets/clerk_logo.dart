



import 'package:clerk/app/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ClerkLogo extends StatelessWidget {
  const ClerkLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      // runAlignment: WrapAlignment.center,
      // crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.center,
      children: [
        Card(
          elevation: 4,
          shadowColor: primaryColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(24.w))

          ),
          margin: EdgeInsets.zero,
          color: Colors.transparent,
          child: Container(
            height: 72.w,
            width: 72.w,
            decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.all(Radius.circular(24.w))
            ),
            margin: EdgeInsets.zero,
            // padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: Text(
                "C",
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(
                  textStyle: TextStyle(
                    fontSize: 56.sp,
                    fontWeight: FontWeight.bold,
                    // letterSpacing: 6,
                    // height: 1.3,
                    color: primaryColor,
                  ),
                )
            ),
          ),
        ),
      ],
    );
  }
}
