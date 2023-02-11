import 'package:clerk/app/custom_widgets/custom_stepper.dart';
import 'package:clerk/app/utils/extensions.dart';
import 'package:clerk/app/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../modules/profile_tab/views/profile_tab_view.dart';

class OthersPage extends StatelessWidget {
  const OthersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Card(
                          clipBehavior: Clip.hardEdge,
                          color: primaryColor,
                          margin: EdgeInsets.zero,
                          elevation: 6,
                          shadowColor: primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(24.w))),
                          child: Container(
                            decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.vertical(
                                    bottom: Radius.circular(24.w))),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 12.w,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    context.navigate.pop();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(8.w),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: backgroundColor,
                                    ),
                                    child: Icon(
                                      Icons.arrow_back_ios_rounded,
                                      color: primaryColor,
                                      size: 24.w,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 12.w,
                                ),
                                Text("Others",
                                    style: GoogleFonts.nunito(
                                        color: backgroundColor,
                                        fontSize: 24.sp,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1))
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: Container(
                            color: Colors.transparent,
                          ))
                    ],
                  ),
                ),
                flex: 1,
              ),
              Expanded(
                flex: 5,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 6.h,
                    ),
                    child: ListView(
                      children: [
                        ProfileListItem(
                          onPressed: () {},
                          title: "About us",
                          icon: Icons.monetization_on_rounded,
                        ),
                        ProfileListItem(
                          onPressed: () {},
                          title: "Customer Support",
                          icon: Icons.person,
                        ),
                        ProfileListItem(
                          onPressed: () {},
                          title: "Terms of Use",
                          icon: Icons.person,
                        ),
                        ProfileListItem(
                          onPressed: () {},
                          title: "Privacy Policy",
                          icon: Icons.business_center_rounded,
                        ),
                        SizedBox(
                          height: 18.h,
                        )
                      ],
                    ),
                  ),
                  color: Colors.transparent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
