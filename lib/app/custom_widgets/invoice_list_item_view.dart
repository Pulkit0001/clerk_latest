import 'package:cached_network_image/cached_network_image.dart';
import 'package:clerk/app/data/models/invoice_data_model.dart';
import 'package:clerk/app/utils/enums/invoice_status.dart';
import 'package:clerk/app/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../modules/candidate/views/candidte_detail_view.dart';
import '../values/colors.dart';

class InvoiceListItem extends StatelessWidget {
  const InvoiceListItem({Key? key, required this.invoice}) : super(key: key);

  final Invoice invoice;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.h))),
      shadowColor: primaryColor,
      elevation: 2,
      margin: EdgeInsets.symmetric(
        vertical: 8.h,
      ),
      child: Container(
        foregroundDecoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12.h)),
            color: Colors.transparent),
        width: double.infinity,
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.only(top: 8.h, bottom: 8.h),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Container(
                    height: 48,
                    width: 48,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4.h)),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: invoice.candidate?.profilePic ?? "",
                      fit: BoxFit.fill,
                      errorWidget: (a, b, c) =>
                          Image.asset('assets/images/avator.png'),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "${invoice.candidate?.name}, ${invoice.candidate?.age}",
                        maxLines: 2,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: GoogleFonts.nunito(
                          color: primaryColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500
                          // fontStyle: FontStyle.italic
                        ),
                      ),
                      Text(
                        invoice.candidate?.address.toString() ?? "",
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.nunito(
                          color: primaryColor,
                          fontSize: 12.sp,
                          // fontStyle: FontStyle.italic
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 6.w,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "\u20b9 ${invoice.totalAmount.toStringAsFixed(2)}",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunito(
                          color: textColor,
                          fontSize: 14.sp,
                          fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "${invoice.invoiceStatus.heading(invoice.dateToShow)}${DateFormat('MMM dd').format(invoice.dateToShow)}",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunito(
                          color: textColor,
                          fontSize: 11.sp,
                          fontStyle: FontStyle.normal),
                    ),
                  ],
                ),
                SizedBox(
                  width: 12,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
