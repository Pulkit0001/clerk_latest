import 'package:clerk/app/custom_widgets/custom_text_field.dart';
import 'package:clerk/app/modules/candidate/bloc/cubits/candidate_form_cubit.dart';
import 'package:clerk/app/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:clerk/app/utils/validators.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CandidateContactDetails extends StatelessWidget {
  const CandidateContactDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<CandidatesFormCubit>();
    return Form(
      key: cubit.contactFormState,
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.stretch,

        children: [
          Text(
            "Contact Details",
            style: GoogleFonts.nunito(
                color: backgroundColor,
                // color: backgroundColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                letterSpacing: 1),
          ),
          SizedBox(
            height: 20.h,
          ),
          CustomTextField(
              isOutlined: true,
              maxLength: 10,
              validator: (value) {
                return value?.validateAsPhone();
              },
              controller: cubit.phoneController,
              label: "Phone",
              helperText: "9999999999",
              leading: Icons.person_rounded),
          SizedBox(
            height: 20.h,
          ),
          CustomTextField(
              maxLength: 10,
              isOutlined: true,
              validator: (value) {
                return value?.validateAsOptionalPhone();
              },
              controller: cubit.optionalPhoneController,
              label: "Phone (optional)",
              helperText: "9999999999",
              leading: Icons.person),
          SizedBox(
            height: 20.h,
          ),
          CustomTextField(
              isOutlined: true,
              validator: (String? value) {
                return value?.validateAsEmail();
              },
              controller: cubit.emailController,
              label: "Email Address (optional)",
              helperText: "abc@example.com",
              leading: Icons.home_rounded),
          SizedBox(
            height: 20.h,
          ),
        ],
      ),
    );
  }
}
