import 'package:clerk/app/custom_widgets/custom_filled_button.dart';
import 'package:clerk/app/custom_widgets/custom_text_field.dart';
import 'package:clerk/app/data/models/invoice_data_model.dart';
import 'package:clerk/app/modules/invoices/bloc/cubit/invoice_detail_cubit.dart';
import 'package:clerk/app/repository/invoice_repo/invoice_repo.dart';
import 'package:clerk/app/utils/enums/pay_mode.dart';
import 'package:clerk/app/utils/extensions.dart';
import 'package:clerk/app/utils/locator.dart';
import 'package:clerk/app/utils/validators.dart';
import 'package:clerk/app/values/colors.dart';
import 'package:cupertino_tabbar/cupertino_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentCollectionSheet extends StatefulWidget {
  const PaymentCollectionSheet({Key? key}) : super(key: key);

  static Widget getWidget(Invoice invoice) => BlocProvider<InvoiceDetailCubit>(
        child: PaymentCollectionSheet(),
        create: (_) =>
            InvoiceDetailCubit(invoice: invoice, repo: getIt<InvoiceRepo>()),
      );
  @override
  State<PaymentCollectionSheet> createState() => _PaymentCollectionSheetState();
}

class _PaymentCollectionSheetState extends State<PaymentCollectionSheet> {
  late final TextEditingController amountController;
  InvoicePayMode payMode = InvoicePayMode.cash;
  @override
  void initState() {
    amountController = TextEditingController(
        text: context
            .read<InvoiceDetailCubit>()
            .state
            .invoice
            .totalAmount
            .toStringAsFixed(2));
    super.initState();
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(12.w)),
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 18.h),
          margin: EdgeInsets.symmetric(horizontal: 12.w),
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
                "Accept Payment",
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(
                    fontWeight: FontWeight.w700,
                    fontSize: 24.sp,
                    color: textColor),
              ),
              SizedBox(
                height: 16,
              ),
              SvgPicture.asset(
                'assets/illustrations/accept_payment.svg',
                height: 120.w,
                width: 120.w,
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                isOutlined: true,
                label: "Amount Received",
                validator: (String? value) {
                  return value?.validateAsAmount();
                },
                inputType: TextInputType.numberWithOptions(decimal: true),
                controller: amountController,
                helperText: '800',
                leading: Icons.monetization_on_rounded,
              ),
              SizedBox(
                height: 12,
              ),
              Text("  Payment Mode ",
                  style: GoogleFonts.nunito(
                    fontSize: 14.sp,
                    color: primaryColor,
                    fontWeight: FontWeight.normal,
                  )),
              SizedBox(
                height: 4.h,
              ),
              CupertinoTabBar(
                primaryColor,
                backgroundColor,
                [
                  Text(
                    "Online",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunito(
                      fontSize: 14.sp,
                      color: payMode == InvoicePayMode.online
                          ? primaryColor
                          : backgroundColor,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Text(
                    "Cash",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunito(
                      fontSize: 14.sp,
                      color: payMode == InvoicePayMode.cash
                          ? primaryColor
                          : backgroundColor,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
                () {
                  return payMode.index;
                },
                (index) {
                  setState(() {
                    payMode = InvoicePayMode.values[index];
                  });
                },
                useShadow: false,
                allowExpand: true,
                borderRadius: BorderRadius.circular(12.w),
              ),
              SizedBox(height: 56),
              Row(
                children: [
                  Expanded(
                    child: CustomFilledButton(
                        label: 'Cancel',
                        btnColor: Colors.grey,
                        onPressed: () {
                          context.navigate.pop();
                        }),
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  Expanded(
                    child: CustomFilledButton(
                      label: 'Confirm',
                      onPressed: () {
                        context.read<InvoiceDetailCubit>().acceptPayment(
                            payMode, double.parse(amountController.text));
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
