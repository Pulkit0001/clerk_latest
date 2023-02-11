



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../values/colors.dart';

class CheckMarkSplash extends StatelessWidget {
  const CheckMarkSplash({required this.message, Key? key}) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.2),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/check_mark.gif', height: 92.h , width: 92.h),
          SizedBox(height: 50.h,),
          Text(message,textAlign: TextAlign.center,style: GoogleFonts.poppins(
            color: backgroundColor,
            fontSize: 20.sp
          ),),
        ],
      ),

    );
  }
}
