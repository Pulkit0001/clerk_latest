import 'package:clerk/app/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../values/colors.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({
    Key? key,
    this.image,
    required this.message,
    this.actionBtnLabel,
    this.imageHeight,
    this.onActionPressed,
  }) : super(key: key);

  final String? image;
  final double? imageHeight;
  final String message;
  final String? actionBtnLabel;
  final Function? onActionPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Container(
            height: imageHeight ?? 100.h,
            child: SvgPicture.asset(image?.isEmpty ?? true
                ? 'assets/illustrations/no_data.svg'
                : image!),
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            message,
            textAlign: TextAlign.center,
            style: GoogleFonts.nunitoSans(
                color: textColor, fontWeight: FontWeight.w400, fontSize: 18.sp),
          ),
          SizedBox(
            height: 12.h,
          ),
          if (onActionPressed != null)
            OutlinedButton(
                onPressed: () {
                  onActionPressed!();
                },
                style: ButtonStyle(
                  side: MaterialStateProperty.all(
                      BorderSide(width: 1.5, color: textColor)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)))),
                ),
                child: Text(
                  actionBtnLabel ?? "Let's Create Now",
                  style: GoogleFonts.poppins(
                      color: textColor,
                      letterSpacing: .5,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400),
                )),
          Spacer(
            flex: 2,
          ),
        ],
      ),
    );
  }
}

class ErrorStateWidget extends StatelessWidget {
  const ErrorStateWidget({
    Key? key,
    this.image,
    required this.message,
    this.onActionPressed,
  }) : super(key: key);

  final String? image;
  final String message;
  final Function? onActionPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(
            flex: 5,
          ),
          Container(
            height: 100.h,
            child: image.isNotNullEmpty
                ? Image.asset(image!)
                : SvgPicture.asset(
                    'assets/illustrations/error_illustration.svg'),
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            message,
            textAlign: TextAlign.center,
            style: GoogleFonts.nunitoSans(
                color: textColor, fontWeight: FontWeight.w400, fontSize: 18.sp),
          ),
          SizedBox(
            height: 12.h,
          ),
          if (onActionPressed != null)
            OutlinedButton(
                onPressed: () {
                  onActionPressed?.call();
                },
                style: ButtonStyle(
                  side: MaterialStateProperty.all(
                      BorderSide(width: 1.5, color: textColor)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)))),
                ),
                child: Text(
                  "Retry",
                  style: GoogleFonts.poppins(
                      color: textColor,
                      letterSpacing: .5,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400),
                )),
          Spacer(
            flex: 6,
          ),
        ],
      ),
    );
  }
}
