import 'package:clerk/app/custom_widgets/custom_text_field.dart';
import 'package:clerk/app/modules/profile/bloc/states/profile_form_state.dart';
import 'package:clerk/app/utils/enums/payment_cycle.dart';
import 'package:clerk/app/utils/validators.dart';
import 'package:clerk/app/values/colors.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_validator/form_validator.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bloc/cubits/profile_form_cubit.dart';

class BusinessFormView extends StatelessWidget {
  BusinessFormView({Key? key}) : super(key: key);

  final businessNameValidator =
      ValidationBuilder().minLength(2).maxLength(30).build();
  final businessAddressValidator =
      ValidationBuilder().minLength(2).maxLength(30).build();
  final emailValidator = ValidationBuilder()
      .email("Please provide valid email.")
      .maxLength(50)
      .build();
  final phoneValidator = ValidationBuilder(
    optional: true,
  ).build();

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<UserProfileFormCubit>();
    return Form(
      key: cubit.businessFormState,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Business Details",
              textAlign: TextAlign.center,
              style: GoogleFonts.nunito(
                  color: backgroundColor,
                  // color: backgroundColor,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1),
            ),
            SizedBox(
              height: 12.h,
            ),
            CustomTextField(
                isOutlined: true,
                maxLength: 30,
                controller: cubit.businessNameController,
                label: "Business Name",
                validator: businessNameValidator,
                helperText: "Tata pvt. Ltd.",
                leading: Icons.person_rounded,textCapitalization: TextCapitalization.words,),
            SizedBox(
              height: 12.h,
            ),
            CustomTextField(
                isOutlined: true,
                controller: cubit.businessAddressController,
                label: "Business Address",
                validator: businessAddressValidator,
                helperText: "Delhi, India",
                leading: Icons.person_rounded),
            SizedBox(
              height: 12.h,
            ),
            CustomTextField(
                isOutlined: true,
                controller: cubit.businessEmailController,
                maxLength: 20,
                label: "Business Email",
                validator: emailValidator,
                textCapitalization: TextCapitalization.none,
                inputType: TextInputType.emailAddress,
                helperText: "abc@example.com",
                leading: Icons.person),
            SizedBox(
              height: 12.h,
            ),
            CustomTextField(
              isOutlined: true,
              controller: cubit.businessPhoneController,
              inputType: TextInputType.phone,
              label: 'Business Contact',
              leadingWidget: _dropdown(context),
              inputFormatters: [
                FilteringTextInputFormatter.deny(
                  RegExp('[^0-9]'),
                ),
                LengthLimitingTextInputFormatter(10)
              ],
              validator: phoneValidator,
              helperText: '9876345678',
              leading: null,
            ),
            SizedBox(
              height: 12.h,
            ),
            Text(
              "  Payment Cycle",
              textAlign: TextAlign.start,
              style: GoogleFonts.nunito(
                fontSize: 14.sp,
                color: textColor,
                fontWeight: FontWeight.normal,
              ),
            ),
            BlocBuilder<UserProfileFormCubit, UserProfileFormState>(
                builder: (context, state) {
              return Row(
                mainAxisSize: MainAxisSize.max,
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Radio<PaymentCycle>(
                    activeColor: primaryColor,
                    value: PaymentCycle.joiningDate,
                    groupValue: cubit.state.userProfile.paymentCycle,
                    onChanged: (value) {
                      cubit.setPaymentCycle(value!);
                    },
                  ),
                  Text(PaymentCycle.joiningDate.label),
                  Radio<PaymentCycle>(
                    activeColor: primaryColor,
                    value: PaymentCycle.firstOfEachMonth,
                    groupValue: cubit.state.userProfile.paymentCycle,
                    onChanged: (value) {
                      cubit.setPaymentCycle(value!);
                    },
                  ),
                  Text(PaymentCycle.firstOfEachMonth.label),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _dropdown(BuildContext context) {
    return CountryCodePicker(
      onChanged: (countryCode) {
        // context.read<SignupMobileCubit>().setCountryCode(countryCode);
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
