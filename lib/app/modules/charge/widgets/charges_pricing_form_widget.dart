import 'dart:math';

import 'package:clerk/app/custom_widgets/custom_text_field.dart';
import 'package:clerk/app/modules/charge/bloc/cubits/charge_form_cubit.dart';
import 'package:clerk/app/modules/charge/bloc/states/charge_form_state.dart';
import 'package:clerk/app/utils/enums/payment_interval_enums.dart';
import 'package:clerk/app/utils/enums/payment_type.dart';
import 'package:clerk/app/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cupertino_tabbar/cupertino_tabbar.dart';
import 'package:google_fonts/google_fonts.dart';

class ChargesPricingFormWidget extends StatelessWidget {
  const ChargesPricingFormWidget({Key? key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ChargesFormCubit>();
    return Form(
      key: cubit.pricingFormState,
      child: SingleChildScrollView(
        child: BlocBuilder<ChargesFormCubit, ChargeFormState>(
          builder : (context, state) => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Pricing",
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(
                    color: backgroundColor,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1),
              ),
              SizedBox(
                height: 12.h,
              ),
              Text("  Amount",
                  style: GoogleFonts.nunito(
                    fontSize: 14.sp,
                    color: primaryColor,
                    fontWeight: FontWeight.normal,
                  )),
              SizedBox(height: 4.h),
              PriceInputWidget(
                controller: cubit.amountController,
                offset: 50,
              ),
              SizedBox(
                height: 36.h,
              ),
              Text("  Payment Type ",
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
                  Text("One Time",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunito(
                        fontSize: 14.sp,
                        color:
                            cubit.state.charge.paymentType == PaymentType.oneTime
                                ? primaryColor
                                : backgroundColor,
                        fontWeight: FontWeight.normal,
                      ),),
                  Text(
                    "Repeating",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunito(
                      fontSize: 14.sp,
                      color:
                          cubit.state.charge.paymentType == PaymentType.repeating
                              ? primaryColor
                              : backgroundColor,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
                () {
                  return cubit.state.charge.paymentType.index;
                },
                (index) {
                  cubit.setPaymentType(PaymentType.values[index]);
                },
                useShadow: false,
                allowExpand: true,
                borderRadius: BorderRadius.circular(12.w),
              ),
              if (cubit.state.charge.paymentType == PaymentType.repeating) ...[
                SizedBox(
                  height: 24.h,
                ),
                Text("  Interval (Tell us when to renew this Charge)",
                    style: GoogleFonts.nunito(
                      fontSize: 14.sp,
                      color: primaryColor,
                      fontWeight: FontWeight.normal,
                    )),
                SizedBox(
                  height: 4.h,
                ),
                CustomSlider(
                  value: 5,
                  onChanged: (value) {
                    context.read<ChargesFormCubit>().timeValue = value;
                    context.read<ChargesFormCubit>().setPaymentInterval(
                        PaymentInterval.values[(value ~/ 16.666666) + 1]);
                  },
                  timeValue: context.read<ChargesFormCubit>().timeValue,
                  steps: ["7d", "15d", "1m", "3m", "6m", "1yr", "2yr"],
                ),
                SizedBox(height: 4.h),
              ]
            ],
          ),
        ),
      ),
    );
  }
}

class PriceInputWidget extends StatelessWidget {
  const PriceInputWidget(
      {Key? key, required this.controller, required this.offset})
      : super(key: key);

  final TextEditingController controller;
  final double offset;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
          color: backgroundColor, borderRadius: BorderRadius.circular(12.w)),
      child: Flex(
        direction: Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                decrement();
              },
              child: Container(
                height: 44.h,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius:
                      BorderRadius.horizontal(left: Radius.circular(12.w)),
                ),
                child: Icon(
                  Icons.remove,
                  color: backgroundColor,
                ),
              ),
            ),
          ),
          Expanded(
              child: Container(
                height: 44.h,
                margin: EdgeInsets.zero,
                padding: EdgeInsets.zero,
                child: CustomTextField(
                  inputType:
                      const TextInputType.numberWithOptions(decimal: true),
                  isOutlined: false,
                  autovalidateMode: AutovalidateMode.always,
                  validator: (value) {
                    return validate(value);
                  },

                  textAlign: TextAlign.center,
                  inputFormatters: [DecimalTextInputFormatter(decimalRange: 2)],
                  // onChanged: (value){
                  //   if(validate(value.trim()) == null) {
                  //
                  //     priceStream.sink.add( "Rs. ${controller.text.isEmpty || validate(controller.text) != null ? 0 * tariff : (double.parse(controller.text) * tariff).toStringAsFixed(2)}");
                  //   }
                  //
                  // },

                  maxLength: 6,
                  controller: controller,
                  obscure: false,
                  helperText: '500.00',
                  leading: null,
                ),
              ),
              flex: 2),
          Expanded(
            child: InkWell(
              onTap: () {
                increment();
              },
              child: Container(
                height: 44.h,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius:
                      BorderRadius.horizontal(right: Radius.circular(12.w)),
                ),
                child: Icon(
                  Icons.add,
                  color: backgroundColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String? validate(String? value) {
    try {
      return value != null && double.parse(value) >= 0 ? null : "  ";
    } catch (e) {
      return "  ";
    }
  }

  increment() {
    try {
      var amount = double.parse(controller.text.trim());
      if (amount <= 100000 - offset) {
        controller.text = (amount + offset).toStringAsFixed(2);
      }
    } catch (e) {
      controller.text = offset.toStringAsFixed(2);
    }
  }

  decrement() {
    try {
      var amount = double.parse(controller.text.trim());
      if (amount >= offset) {
        controller.text = (amount - offset).toStringAsFixed(2);
      }
    } catch (e) {
      controller.text = "0.00";
    }
  }
}

class CustomSlider extends StatelessWidget {
  final double value;
  final Function(double)? onChanged;
  final Color? activeColor;
  final Color? inactiveColor;
  final int labelValuePrecision;
  final int tickValuePrecision;
  final bool linearStep;
  final List<String> steps;
  final double timeValue;

  CustomSlider({
    required this.value,
    required this.onChanged,
    required this.timeValue,
    this.activeColor,
    this.inactiveColor,
    this.labelValuePrecision = 2,
    this.tickValuePrecision = 1,
    this.linearStep = true,
    required this.steps,
  });

  @override
  Widget build(BuildContext context) {
    final allocatedHeight = MediaQuery.of(context).size.height;
    final allocatedWidth = MediaQuery.of(context).size.width;

    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.w),
        child: Column(
          children: [
            Row(
              children: List.generate(
                7,
                (index) => Expanded(
                  child: Column(
                    children: [
                      Container(
                          alignment: Alignment.bottomCenter,
                          height: 18.h,
                          child: Text(
                            steps[index],
                          )),
                      Container(
                        alignment: Alignment.bottomCenter,
                        height: 32.h,
                        child: VerticalDivider(
                            indent: 8.h,
                            endIndent: 8.h,
                            thickness: 1.0,
                            color: primaryColor //,,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: SliderTheme(
                data: SliderThemeData(
                  trackHeight: 28.w,
                  activeTickMarkColor: backgroundColor,
                  inactiveTickMarkColor: backgroundColor,
                  activeTrackColor: primaryColor,
                  inactiveTrackColor: lightPrimaryColor,
                  thumbColor: backgroundColor,
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 14.w),
                  //trackShape: CustomTrackShape(),
                  showValueIndicator: ShowValueIndicator.never,
                  valueIndicatorTextStyle: TextStyle(
                    fontSize: 12,
                  ),
                ),
                child: Slider(
                  value: timeValue,
                  min: 0,
                  max: 100,
                  divisions: 6,
                  onChanged: onChanged,
                  label: value.toStringAsFixed(labelValuePrecision),
                ),
              ),
            ),
          ],
        ));
  }
}

class DecimalTextInputFormatter extends TextInputFormatter {
  DecimalTextInputFormatter({required this.decimalRange})
      : assert(decimalRange == null || decimalRange > 0);

  final int decimalRange;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue, // unused.
    TextEditingValue newValue,
  ) {
    TextSelection newSelection = newValue.selection;
    String truncated = newValue.text;

    if (decimalRange != null) {
      String value = newValue.text;

      if (value.contains(".") &&
          value.substring(value.indexOf(".") + 1).length > decimalRange) {
        truncated = oldValue.text;
        newSelection = oldValue.selection;
      } else if (value == ".") {
        truncated = "0.";

        newSelection = newValue.selection.copyWith(
          baseOffset: min(truncated.length, truncated.length + 1),
          extentOffset: min(truncated.length, truncated.length + 1),
        );
      }
      return TextEditingValue(
        text: truncated,
        selection: newSelection,
        composing: TextRange.empty,
      );
    }
    return newValue;
  }
}
