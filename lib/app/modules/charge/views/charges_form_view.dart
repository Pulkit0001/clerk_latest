import 'package:clerk/app/custom_widgets/custom_stepper.dart';
import 'package:clerk/app/modules/charge/bloc/cubits/charge_form_cubit.dart';
import 'package:clerk/app/modules/charge/bloc/states/charge_form_state.dart';
import 'package:clerk/app/modules/charge/widgets/charges_general_form_widget.dart';
import 'package:clerk/app/modules/charge/widgets/charges_pricing_form_widget.dart';
import 'package:clerk/app/repository/charge_repo/charge_repo.dart';
import 'package:clerk/app/utils/extensions.dart';
import 'package:clerk/app/utils/locator.dart';
import 'package:clerk/app/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

List<Widget> chargeFormPages = [
  ChargeGeneralDetails(),
  ChargesPricingFormWidget(),
  Container(),
];

class ChargesFormView extends StatelessWidget {
  static Route<dynamic> getRoute() {
    return MaterialPageRoute(builder: (context) => ChargesFormView());
  }

  final int nbSteps = 2;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChargesFormCubit>(
      create: (BuildContext context) => ChargesFormCubit(
        repo: getIt<ChargeRepo>(),
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: backgroundColor,
          body: Builder(
            builder: (context) {
              return BlocBuilder<ChargesFormCubit, ChargeFormState>(
                builder: (context, state) {
                  return Container(
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
                                          Text("Charge",
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
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: 8.h, bottom: 20.h),
                                  child: CustomStepper(
                                      steps: 2, currentStep: state.formStep),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12.w, vertical: 16.h),
                                    decoration: BoxDecoration(
                                      color: lightPrimaryColor,
                                      gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            lightPrimaryColor,
                                            backgroundColor
                                          ]),
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(24.w)),
                                    ),
                                    child: Column(
                                      children: [
                                        Expanded(
                                            child: chargeFormPages[
                                                state.formStep]),
                                        // Spacer(),
                                        Padding(
                                          padding: EdgeInsets.all(12.w),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              if (state.formStep > 0) ...[
                                                FloatingActionButton(
                                                  onPressed: () {
                                                    if (state.formStep > 0) {
                                                      var cubit = context.read<
                                                          ChargesFormCubit>();
                                                      cubit.changeFormStep(
                                                          state.formStep - 1);
                                                    }
                                                  },
                                                  elevation: 6,
                                                  materialTapTargetSize:
                                                      MaterialTapTargetSize
                                                          .padded,
                                                  backgroundColor:
                                                      backgroundColor,
                                                  child: Icon(
                                                    Icons.arrow_back_rounded,
                                                    color: primaryColor,
                                                    size: 36.w,
                                                  ),
                                                )
                                              ],
                                              Spacer(),
                                              FloatingActionButton(
                                                onPressed: () {
                                                  var cubit = context
                                                      .read<ChargesFormCubit>();
                                                  if (cubit.validateForm()) {
                                                    if (state.formStep <
                                                        nbSteps - 1) {
                                                      cubit.changeFormStep(
                                                          state.formStep + 1);
                                                    } else {
                                                      if (state.formStep ==
                                                          nbSteps - 1) {
                                                        cubit.createCharge();
                                                      }
                                                    }
                                                  }
                                                },
                                                elevation: 6,
                                                materialTapTargetSize:
                                                    MaterialTapTargetSize
                                                        .padded,
                                                backgroundColor:
                                                    backgroundColor,
                                                child: Icon(
                                                  state.formStep >= nbSteps - 1
                                                      ? Icons.check_rounded
                                                      : Icons
                                                          .arrow_forward_rounded,
                                                  color: primaryColor,
                                                  size: 36.w,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            color: Colors.transparent,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

// class AddCandidate extends StatelessWidget {
//   const AddCandidate({Key? key}) : super(key: key);
//
// }
