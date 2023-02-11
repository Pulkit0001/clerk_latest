import 'package:clerk/app/data/models/charge_data_model.dart';
import 'package:clerk/app/modules/candidate/views/candidte_detail_view.dart';
import 'package:clerk/app/utils/extensions.dart';
import 'package:clerk/app/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/models/candidate_data_model.dart';

class CandidateVerticalListTile extends StatelessWidget {
  const CandidateVerticalListTile(
      {required this.candidate,
      Key? key,
      required this.selected,
      required this.onPressed})
      : super(key: key);

  final Candidate candidate;
  final bool selected;
  final Function(String) onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.navigate.push(CandidateDetailView.getRoute(candidate.id));
      },
      child: Card(
        color: backgroundColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.h))),
        shadowColor: primaryColor,
        elevation: 2,
        margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.h),
        child: Container(
            foregroundDecoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12.h)),
                color: selected
                    ? Colors.black.withOpacity(0.3)
                    : Colors.transparent),
            width: double.infinity,
            alignment: Alignment.center,
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 8.h, bottom: 16.h),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: CircleAvatar(
                          foregroundImage: NetworkImage(
                            candidate.profilePic,
                          ),
                          child: Container(
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.h)),
                            ),
                            child: Image.network(
                              candidate.profilePic,
                              fit: BoxFit.fill,
                            ),
                          ),
                          radius: 20.w,
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            "${candidate.name}, ${candidate.age}",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.nunito(
                              color: primaryColor,
                              fontSize: 16.sp,
                              // fontStyle: FontStyle.italic
                            ),
                          ),
                          Text(
                            candidate.address.toString(),
                            textAlign: TextAlign.center,
                            style: GoogleFonts.nunito(
                              color: primaryColor,
                              fontSize: 14.sp,
                              // fontStyle: FontStyle.italic
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    margin: EdgeInsets.only(right: 10.w, bottom: 8.h),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(.7),
                      borderRadius: BorderRadius.all(Radius.circular(4.h)),
                    ),
                    child: Text(
                      "\u20b9 ${'0'}",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunito(
                          color: backgroundColor,
                          fontSize: 16.sp,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
