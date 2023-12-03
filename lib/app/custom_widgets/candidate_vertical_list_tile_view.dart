import 'package:cached_network_image/cached_network_image.dart';
import 'package:clerk/app/custom_widgets/invoice_status_chip.dart';
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
      child: Container(
          margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.h),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.all(Radius.circular(8.h)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: Offset(4, 4),
                  blurRadius: 10)
            ],
          ),
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
                      child: Container(
                        height: 56,
                        width: 56,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(4.h)),
                        ),
                        child: candidate.profilePic.isEmpty
                            ? Image.asset('assets/images/avator.png')
                            : CachedNetworkImage(
                                imageUrl: candidate.profilePic,
                                fit: BoxFit.fill,
                                errorWidget: (a, b, c) =>
                                    Image.asset('assets/images/avator.png'),
                              ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: 56.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${candidate.name}, ${candidate.age}",
                              textAlign: TextAlign.start,
                              style: GoogleFonts.nunito(
                                color: textColor,
                                fontSize: 16.sp,
                                // fontStyle: FontStyle.italic
                              ),
                            ),
                            Text(
                              candidate.address.capitalizeWords(),
                              textAlign: TextAlign.start,
                              maxLines: 2,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.nunito(
                                color: textColor,
                                fontSize: 14.sp,
                                // fontStyle: FontStyle.italic
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  margin: EdgeInsets.only(right: 10.w, bottom: 8),
                  decoration: BoxDecoration(
                    color: candidate.pendingAmount <= 0
                        ? Colors.green.withOpacity(.7)
                        : Colors.red.withOpacity(.7),
                    borderRadius: BorderRadius.all(Radius.circular(4.h)),
                  ),
                  child: Text(
                    candidate.pendingAmount <= 0
                        ? "RECEIVED"
                        : "\u20b9 ${candidate.pendingAmount}",
                    textAlign: TextAlign.center,
                    textHeightBehavior: TextHeightBehavior(
                        leadingDistribution: TextLeadingDistribution.even),
                    style: GoogleFonts.nunito(
                        color: backgroundColor,
                        fontSize: 14.sp,
                        fontStyle: FontStyle.italic),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
