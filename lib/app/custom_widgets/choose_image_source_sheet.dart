import 'package:clerk/app/utils/extensions.dart';
import 'package:clerk/app/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class ChooseImageSource extends StatelessWidget {
  const ChooseImageSource({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          clipBehavior: Clip.hardEdge,
          // margin: EdgeInsets.symmetric(horizontal: 12.w),
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 18.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.w),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: context.navigate.pop,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.arrow_back_ios_new_rounded, size: 18.sp, color: primaryColor,),
                    ),
                  ),
                  SizedBox(width: 12.w,),
                  Text(
                    'Choose Image From',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.nunito(
                      color: textColor,
                      fontWeight: FontWeight.w800,
                      fontSize: 18.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.of(context).pop(ImageSource.camera);
                    },
                    child: Column(
                      children: [
                        Icon(
                          Icons.camera,
                          color: primaryColor,
                          size: 36.sp,
                        ),
                        SizedBox(height: 6.h,),
                        Text('Camera', style: GoogleFonts.nunito(color: primaryColor, fontWeight: FontWeight.w600, fontSize: 16.sp),)
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.of(context).pop(ImageSource.gallery);
                    },
                    child: Column(
                      children: [
                        Icon(
                          Icons.perm_media_rounded,
                          color: primaryColor,
                          size: 36.sp,
                        ),
                        SizedBox(height: 6.h,),
                        Text('Gallery', style: GoogleFonts.nunito(color: primaryColor, fontWeight: FontWeight.w600, fontSize: 16.sp),)
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 18.h,),
            ],
          ),
        ),
      ],
    );
  }
}
