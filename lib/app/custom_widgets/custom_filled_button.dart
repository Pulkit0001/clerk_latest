import 'package:clerk/app/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomFilledButton extends StatelessWidget {
  const CustomFilledButton(
      {Key? key,
      this.btnColor = primaryColor,
      this.labelColor = backgroundColor,
      this.verticalPadding = 8,
      this.elevation = 4,
      required this.label,
       this.circularRadius,
       this.textSize,
      required this.onPressed})
      : super(key: key);

  final Color btnColor;
  final Color labelColor;
  final double verticalPadding;
  final double? circularRadius;
  final double? textSize;
  final double elevation;
  final String label;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        onPressed();
      },
      elevation: elevation,
      color: btnColor,
      padding: EdgeInsets.symmetric(vertical: verticalPadding.h, horizontal: 12.w),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(circularRadius ?? 12.w))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: GoogleFonts.nunito(
                textStyle: TextStyle(
                    color: labelColor,
                    fontSize: textSize ?? 18.sp,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
