import 'package:clerk/app/custom_widgets/custom_filled_button.dart';
import 'package:clerk/app/data/models/invoice_data_model.dart';
import 'package:clerk/app/modules/invoices/bloc/cubit/invoice_detail_cubit.dart';
import 'package:clerk/app/repository/invoice_repo/invoice_repo.dart';
import 'package:clerk/app/services/utility_service.dart';
import 'package:clerk/app/utils/extensions.dart';
import 'package:clerk/app/utils/locator.dart';
import 'package:clerk/app/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class InvoiceCancelSheet extends StatefulWidget {
  const InvoiceCancelSheet({Key? key}) : super(key: key);

  static Widget getWidget(Invoice invoice) => BlocProvider<InvoiceDetailCubit>(
        child: InvoiceCancelSheet(),
        create: (_) => InvoiceDetailCubit(
          invoice: invoice,
          repo: getIt<InvoiceRepo>(),
        ),
      );

  @override
  State<InvoiceCancelSheet> createState() => _InvoiceCancelSheetState();
}

class _InvoiceCancelSheetState extends State<InvoiceCancelSheet> {
  InvoiceCancelReason? cancelReason;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 12.w),
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
                  Spacer(),
                  InkWell(
                      onTap: () {
                        context.navigate.pop();
                      },
                      child: Icon(Icons.clear)),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                "Cancel Invoice",
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(
                    fontWeight: FontWeight.w700,
                    fontSize: 24.sp,
                    color: textColor),
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                'Do you really want to \n cancel this invoice',
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(
                    fontSize: 14.sp,
                    color: textColor,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 24.h,
              ),
              SvgPicture.asset(
                'assets/illustrations/error_illustration.svg',
                height: 120.w,
                width: 120.w,
              ),
              SizedBox(
                height: 24.h,
              ),
              Text("  Reason ",
                  style: GoogleFonts.nunito(
                    fontSize: 14.sp,
                    color: primaryColor,
                    fontWeight: FontWeight.normal,
                  )),
              SizedBox(
                height: 4.h,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: lightPrimaryColor),
                  borderRadius: BorderRadius.circular(12.w),
                ),
                padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 12.w),
                child: DropdownButton<InvoiceCancelReason>(
                  alignment: Alignment.topCenter,
                  value: cancelReason,
                  items: InvoiceCancelReason.values
                      .map((e) => DropdownMenuItem<InvoiceCancelReason>(
                          value: e, child: Text(e.label)))
                      .toList(),
                  iconEnabledColor: primaryColor,
                  isExpanded: true,
                  isDense: true,
                  underline: Offstage(),
                  onChanged: (value) {
                    setState(() {
                      cancelReason = value;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 54.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomFilledButton(
                      btnColor: Colors.grey,
                      label: "No, I'm Not",
                      onPressed: () {
                        context.navigate.pop();
                      },
                    ),
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  Expanded(
                    child: CustomFilledButton(
                      label: 'Yes, Sure',
                      onPressed: () async {
                        if (cancelReason != null) {
                          context
                              .read<InvoiceDetailCubit>()
                              .cancelPayment(cancelReason!)
                              .then((value) =>
                                  UtilityService.showMessage(context, value));
                        } else {
                          UtilityService.showError(context,
                              'Please choose an appropriate cancel reason.');
                        }
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

enum InvoiceCancelReason {
  incorrectBillingInformation('Incorrect Billing Information'),
  duplicateInvoices('Duplicate Invoices'),
  pricingOrQuantityErrors('Pricing Or Quantity Errors'),
  membershipCancelled('Membership Cancelled'),
  membershipChanged('Membership Changed'),
  billingDispute('Billing Dispute'),
  others('Others');

  const InvoiceCancelReason(this.label);

  final String label;
}
