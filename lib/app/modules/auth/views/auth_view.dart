import 'dart:io';

import 'package:clerk/app/custom_widgets/clerk_logo.dart';
import 'package:clerk/app/custom_widgets/custom_divider.dart';
import 'package:clerk/app/custom_widgets/custom_filled_button.dart';
import 'package:clerk/app/custom_widgets/custom_text_field.dart';
import 'package:clerk/app/data/services/session_service.dart';
import 'package:clerk/app/modules/dashboard/views/dashboard_view.dart';
import 'package:clerk/app/modules/profile/views/profile_form_view.dart';
import 'package:clerk/app/repository/auth_repo/auth_repo.dart';
import 'package:clerk/app/utils/extensions.dart';
import 'package:clerk/app/utils/locator.dart';
import 'package:clerk/app/values/colors.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../services/utility_service.dart';
import '../../app/cubit/app_cubit.dart';
import '../cubit/signup_mobile_cubit.dart';
import 'otp_verification_page.dart';

class AuthPage extends StatelessWidget {
  static Route<dynamic> getRoute() {
    return MaterialPageRoute(
      builder: (context) => BlocProvider<SignupMobileCubit>(
        create: (context) => SignupMobileCubit(
          getIt<AuthRepo>(),
        ),
        child: AuthPage(),
      ),
    );
  }

  static Widget getWidget() {
    return BlocProvider<SignupMobileCubit>(
      create: (context) => SignupMobileCubit(
        getIt<AuthRepo>(),
      ),
      child: AuthPage(),
    );
  }

  Future<void> listener(BuildContext context, SignUpMobileState state) async {
    final message = state.message;
    switch (state.estate) {
      case EVerifyMobileState.OtpSent:
        {
          context.loaderOverlay.hide();
          await Navigator.push(
            context,
            OtpVerificationPage.getRoute(
              onSubmit: (otp) async => submitOTP(context, otp),
              resendSms: () async => resendSms(context),
            ),
          );
          break;
        }

      /// Code [MobileAlreadyInUse] means user exists with provided mobile no.
      /// This means we can give access to app
      case EVerifyMobileState.MobileAlreadyInUse:
        {
          context.read<AppCubit>().checkAuthentication();
          break;
        }
      case EVerifyMobileState.OtpVerified:
        {
          await context
              .read<SignupMobileCubit>()
              .checkMobileAvailability(context);
          break;
        }
      case EVerifyMobileState.VerificationFailed:
        {
          context.loaderOverlay.hide();
          UtilityService.showMessage(
            context,
            UtilityService.decodeStateMessage(message),
          );
          UtilityService.cprint(message);
          break;
        }
      case EVerifyMobileState.MobileNotRegistered:
        {
          UtilityService.showMessage(
              context, UtilityService.decodeStateMessage(message));
          UtilityService.cprint(message);
          getIt<Session>().setFirebaseUser(FirebaseAuth.instance.currentUser!);
          await Navigator.pushReplacement(
            context,
            UserProfileFormPage.getRoute(),
          );
          break;
        }
      case EVerifyMobileState.initial:
      case EVerifyMobileState.Other:
      case EVerifyMobileState.Timeout:
      case EVerifyMobileState.Created:
        break;
      case EVerifyMobileState.sendingOtp:
      case EVerifyMobileState.OtpVerifying:
      case EVerifyMobileState.Loading:
        {
          context.loaderOverlay.show();
        }
        break;
    }
    UtilityService.cprint(message);
  }

  Future<void> submitOTP(BuildContext context, String otp) async {
    await context.read<SignupMobileCubit>().verifyOTP(context, otp);
  }

  Future<void> resendSms(BuildContext context) async {
    await context.read<SignupMobileCubit>().continueWithPhone(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupMobileCubit, SignUpMobileState>(
        listener: listener,
        builder: (context, state) {
          return Scaffold(
            body: Container(
              height: double.infinity,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              decoration: BoxDecoration(
                  gradient: RadialGradient(
                center: Alignment(0.0, 0.0), // near the top right
                radius: 2.0,
                colors: <Color>[
                  primaryColor.withOpacity(0.5), // yellow sun

                  primaryColor, // blue sky
                ],
                stops: <double>[0.4, 0.4],
              )),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Spacer(
                    flex: 5,
                  ),
                  ClerkLogo(),
                  Spacer(
                    flex: 1,
                  ),
                  Text(
                    "Lorem ipsum dolor sit amet,\n consectetuer adipiscing \n",
                    style: TextStyle(
                        color: backgroundColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        height: 1.4,
                        letterSpacing: 1.5),
                    textAlign: TextAlign.center,
                  ),
                  Spacer(
                    flex: 2,
                  ),
                  Form(
                    key: context.read<SignupMobileCubit>().formKey,
                    child: CustomTextField(
                      controller: context.watch<SignupMobileCubit>().phone,
                      inputType: TextInputType.phone,
                      leadingWidget: _dropdown(context),
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(
                          RegExp('[^0-9]'),
                        ),
                        LengthLimitingTextInputFormatter(10)
                      ],
                      helperText: 'Enter your phone number',
                      leading: null,
                    ),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  CustomFilledButton(
                    label: "CONTINUE",
                    onPressed: () async {
                      final mobile =
                          context.read<SignupMobileCubit>().phone.text.trim();
                      if (mobile.isEmpty || mobile.length < 10) {
                        UtilityService.showError(
                          context,
                          'Please enter a valid phone number',
                        );
                        return;
                      } else {
                        FocusManager.instance.primaryFocus!.unfocus();
                      }

                      await context
                          .read<SignupMobileCubit>()
                          .continueWithPhone(context);
                    },
                  ),
                  // CustomDivider(),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     if (Platform.isIOS)
                  //       CustomFilledButton(
                  //           label: "Apple",
                  //           onPressed: () {
                  //             // context.read<AuthCubit>().continueWithGoogle();
                  //           }),
                  //     CustomFilledButton(
                  //         label: "Facebook",
                  //         onPressed: () {
                  //           // context.read<AuthCubit>().continueWithGoogle();
                  //         }),
                  //     CustomFilledButton(
                  //         label: "Google",
                  //         onPressed: () {
                  //           // context.read<AuthCubit>().continueWithGoogle();
                  //         }),
                  //   ],
                  // ),
                  Spacer(
                    flex: 5,
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget _dropdown(BuildContext context) {
    return CountryCodePicker(
      onChanged: (countryCode) {
        context.read<SignupMobileCubit>().setCountryCode(countryCode);
      },
      initialSelection: 'IN',
      favorite: const ['+91', 'IN'],
      showCountryOnly: true,
      // dialogTextStyle: TextStyles.bodyText15(context),
      showFlag: false,
      showFlagDialog: true,
      // textStyle: TextStyles.bodyText14(context),
    );
  }
}
