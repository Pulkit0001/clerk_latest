import 'package:clerk/app/data/models/charge_data_model.dart';
import 'package:clerk/app/modules/candidate/views/candidte_detail_view.dart';
import 'package:clerk/app/utils/enums/payment_interval_enums.dart';
import 'package:clerk/app/utils/enums/payment_type.dart';
import 'package:clerk/app/utils/extensions.dart';
import 'package:clerk/app/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/models/candidate_data_model.dart';

class ChargeVerticalListTile extends StatelessWidget {
  const ChargeVerticalListTile({
    required this.charge,
    Key? key,
  }) : super(key: key);

  final Charge charge;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.h))),
      shadowColor: primaryColor,
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        foregroundDecoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8.h)),
            color: Colors.transparent),
        width: double.infinity,
        alignment: Alignment.center,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 8.h, bottom: 16.h),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          charge.name,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.nunito(
                            color: primaryColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          charge.description,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.nunito(
                            color: textColor,
                            fontSize: 14.sp,
                            // fontStyle: FontStyle.italic
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(charge.paymentType == PaymentType.oneTime ? charge.paymentType.label : charge.interval.label,
                        style: GoogleFonts.nunito(
                          color: primaryColor,
                          fontSize: 14.sp,
                          // fontStyle: FontStyle.italic
                        ),
                      ),
                      Text('\u20b9 ${charge.amount.toStringAsFixed(2)}',

                        style: GoogleFonts.nunito(
                            color: primaryColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold
                          // fontStyle: FontStyle.italic
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
