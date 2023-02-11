import 'package:clerk/app/custom_widgets/custom_text_field.dart';
import 'package:clerk/app/modules/candidate/bloc/cubits/candidate_form_cubit.dart';
import 'package:clerk/app/utils/validators.dart';
import 'package:clerk/app/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bloc/cubits/profile_form_cubit.dart';

class PersonalFormView extends StatelessWidget {
  const PersonalFormView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<UserProfileFormCubit>();
    return Form(
      key: cubit.personalFormState,
      child: Column(
        children: [
          Text(
            "Personal Details",
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
              controller: cubit.firstNameController,
              label: "First Name",
              validator: (String? value) {
                return value?.validateAsName();
              },
              helperText: "Harnaaz",
              leading: Icons.person_rounded),
          SizedBox(
            height: 20.h,
          ),
          CustomTextField(
              isOutlined: true,
              controller: cubit.lastNameController,
              label: "Last Name",
              validator: (String? value) {
                return value?.validateAsName();
              },
              helperText: "Sandhu",
              leading: Icons.person_rounded),
          SizedBox(
            height: 20.h,
          ),
          CustomTextField(
              isOutlined: true,
              controller: cubit.occupationController,
              maxLength: 20,
              label: "Occupation",
              validator: (String? value) {
                return value?.validateAsName();
              },
              inputType: TextInputType.name,
              helperText: "Managing Director",
              leading: Icons.person),
          SizedBox(
            height: 20.h,
          ),
        ],
      ),
    );
  }
}
