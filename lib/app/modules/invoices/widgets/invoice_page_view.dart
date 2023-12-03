import 'package:clerk/app/custom_widgets/custom_filled_button.dart';
import 'package:clerk/app/custom_widgets/floating_expandable_button.dart';
import 'package:clerk/app/data/models/invoice_data_model.dart';
import 'package:clerk/app/data/services/session_service.dart';
import 'package:clerk/app/modules/invoices/widgets/invoice_cancel_sheet.dart';
import 'package:clerk/app/utils/enums/invoice_status.dart';
import 'package:clerk/app/utils/extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:clerk/app/utils/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../values/colors.dart';
import 'payment_collection_sheet.dart';

class InvoicePageView extends StatelessWidget {
  const InvoicePageView({Key? key, required this.invoice}) : super(key: key);

  final Invoice invoice;
  static Widget getWidget(Invoice invoice) => InvoicePageView(invoice: invoice,);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Container(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Card(
                  clipBehavior: Clip.hardEdge,
                  color: primaryColor,
                  margin: EdgeInsets.zero,
                  elevation: 6,
                  shadowColor: primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(12.w))),
                  child: SafeArea(
                    child: Container(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 16.h,
                          ),
                          Row(
                            children: [
                              Spacer(),
                              Text(
                                "\u20b9 ${invoice.totalAmount.toStringAsFixed(2)}",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.nunito(
                                  color: backgroundColor,
                                  letterSpacing: 2,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 24.sp,
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                          SizedBox(
                            height: 6.h,
                          ),
                          Text(
                            invoice.invoiceStatus.label,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.nunito(
                              color: backgroundColor,
                              letterSpacing: 1,
                              fontSize: 20.sp,
                            ),
                          ),
                          Text(
                            "${invoice.invoiceStatus.heading(invoice.dateToShow)}${DateFormat('MMM dd, yyyy').format(invoice.dateToShow)}",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.nunito(
                              color: backgroundColor,
                              fontSize: 18.sp,
                            ),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(24.w))),
                    ),
                  ),
                ),
              ),
              flex: 2,
            ),
            Expanded(
              flex: 9,
              child: Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(12.w),
                    )),
                padding: EdgeInsets.only(top: 12.h, left: 12.w, right: 12.w),
                child: Stack(
                  children: [
                    (invoice.candidate?.profilePic).isNotNullEmpty
                        ? Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(12.w),
                          )),
                      child: CachedNetworkImage(
                          imageUrl:
                          invoice.candidate!.profilePic),
                    )
                        : Image.asset('assets/images/avator.png'),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        padding: EdgeInsets.symmetric(
                            vertical: 16.h, horizontal: 16.w),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              lightPrimaryColor.withOpacity(0.5),
                              lightPrimaryColor.withOpacity(0.0),
                            ],
                          ),
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(12.w)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              '${invoice.candidate?.name ?? ""}, ${invoice.candidate?.age ?? ""}',
                              style: GoogleFonts.nunito(
                                color: textColor,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.5,
                                fontSize: 22.sp,
                              ),
                            ),
                            Text(
                              invoice.candidate?.address ?? "",
                              style: GoogleFonts.nunito(
                                color: textColor,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.7,
                                fontSize: 18.sp,
                              ),
                            ),
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      'See More ...',
                                      style: GoogleFonts.nunito(
                                        color: primaryColor,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FontStyle.italic,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: InvoiceActionsWidget(
                                        invoice: invoice,
                                        userProfile:
                                        getIt<Session>().userProfile!),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 12.h, horizontal: 12.w),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: CustomFilledButton(
                                      label: 'Cancel',
                                      onPressed: () {
                                        showBottomSheet(
                                          context: context,
                                          backgroundColor: Colors.transparent,
                                          builder: (_) =>
                                              InvoiceCancelSheet(),
                                        );
                                      },
                                      btnColor: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 12.w,
                                  ),
                                  Expanded(
                                    child: CustomFilledButton(
                                      label: 'Accept',
                                      onPressed: () {
                                        showBottomSheet(
                                          backgroundColor: Colors.transparent,
                                          context: context,
                                          builder: (_) =>
                                              PaymentCollectionSheet.getWidget(invoice),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
