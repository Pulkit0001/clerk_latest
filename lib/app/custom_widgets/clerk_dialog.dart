import 'package:clerk/app/custom_widgets/custom_filled_button.dart';
import 'package:clerk/app/utils/extensions.dart';
import 'package:clerk/app/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ClerkDialog extends StatelessWidget {
  const ClerkDialog(
      {Key? key,
      this.title,
      required this.body,
      this.assetImage,
      required this.positiveLabel,
      this.negativeLabel,
      required this.onPositivePressed,
      this.onNegativePressed})
      : super(key: key);

  final String? title;
  final Widget body;
  final String? assetImage;
  final String positiveLabel;
  final String? negativeLabel;
  final Function onPositivePressed;
  final Function? onNegativePressed;

  @override
  Widget build(BuildContext context) {
    return
      Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        runAlignment: WrapAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.w),
          ),
          // height: double.minPositive,
          margin: EdgeInsets.symmetric(horizontal: 24.w),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (title != null) ...[
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  title!,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunito(
                    color: primaryColor,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Divider(
                  color: primaryColor,
                  height: 4,
                  thickness: 1,
                )
              ],
              if (assetImage != null) ...[
                Image.asset(
                  assetImage!,
                  height: 50.w,
                  width: 50.w,
                ),
                SizedBox(
                  height: 12.h,
                )
              ],
              SizedBox(
                height: 18.h,
              ),
              body,
              SizedBox(
                height: 18.h,
              ),
              CustomFilledButton(
                  label: positiveLabel,
                  onPressed: () async {
                    context.navigate.pop();
                    await onPositivePressed.call();
                  }),
              if (negativeLabel != null) ...[
                SizedBox(
                  height: 12.h,
                ),
                CustomFilledButton(
                    label: negativeLabel!,
                    btnColor: Colors.grey,
                    onPressed: () async {
                      context.navigate.pop();
                      await onNegativePressed!.call();
                    })
              ],
              SizedBox(
                height: 12.h,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
