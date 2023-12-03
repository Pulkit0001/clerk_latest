import 'package:clerk/app/custom_widgets/custom_filled_button.dart';
import 'package:clerk/app/utils/extensions.dart';
import 'package:clerk/app/values/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../services/utility_service.dart';
import '../../app/cubit/app_cubit.dart';

class OtpVerificationPage extends StatefulWidget {
  const OtpVerificationPage({
    super.key,
    required this.onSubmit,
    required this.resendSms,
  });
  final Future<void> Function(String otp) onSubmit;
  final Future<void> Function() resendSms;

  static Route<T> getRoute<T>({
    required Future<void> Function(String otp) onSubmit,
    required Future<void> Function() resendSms,
  }) {
    return MaterialPageRoute(
      builder: (_) {
        return OtpVerificationPage(onSubmit: onSubmit, resendSms: resendSms);
      },
    );
  }

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  late TextEditingController otpController;

  @override
  void initState() {
    otpController = TextEditingController();
    super.initState();
  }

  Future<void> appStateListener(BuildContext context, AppState state) async {
    if (state.estate == EAppState.loggedIn) {
      context.loaderOverlay.hide();
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppCubit, AppState>(
      listener: appStateListener,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            foregroundColor: primaryColor,
          ),
          extendBodyBehindAppBar: true,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
                        Text(
                          'Login with Phone',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.nunito(
                            color: primaryColor,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          height: context.width * 0.64,
                          width: context.width * 0.64,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: lightPrimaryColor,
                          ),
                        ),
                        const SizedBox(height: 40),
                        Text(
                          '''
    We sent a verification code to your mobile. Please enter the code below.''',
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 30),
                        PinCodeTextField(
                          appContext: context,
                          length: 6,
                          animationType: AnimationType.fade,
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(5),
                            fieldHeight: 50,
                            fieldWidth: 40,
                            activeFillColor: Colors.white,
                            activeColor: primaryColor,
                            selectedColor: primaryColor,
                            disabledColor: const Color(0xffC9C7B3),
                            inactiveColor: lightPrimaryColor,
                          ),
                          animationDuration: const Duration(milliseconds: 300),
                          controller: otpController,
                          onChanged: (value) {
                            if (kDebugMode) {
                              print(otpController.text);
                            }
                          },
                          beforeTextPaste: (text) {
                            if (kDebugMode) {
                              print('Allowing to paste $text');
                            }
                            return true;
                          },
                        ),
                        const SizedBox(height: 20),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: "Didn't receive the code? ",
                            style: GoogleFonts.nunito(
                                color: primaryColor,
                                fontWeight: FontWeight.w500),
                            children: [
                              TextSpan(
                                text: 'Resend',
                                style: GoogleFonts.nunito(
                                    color: primaryColor,
                                    fontWeight: FontWeight.w700),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    await widget.resendSms();
                                  },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: CustomFilledButton(
                    onPressed: () async {
                      if (otpController.text.length != 6) {
                        UtilityService.showError(
                          context,
                          'Enter valid OTP',
                        );
                        return;
                      } else {
                        FocusManager.instance.primaryFocus!.unfocus();
                        await widget.onSubmit(otpController.text);
                      }
                    },
                    label: 'Verify',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
