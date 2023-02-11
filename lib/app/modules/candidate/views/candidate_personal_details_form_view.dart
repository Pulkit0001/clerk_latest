import 'package:clerk/app/custom_widgets/custom_text_field.dart';
import 'package:clerk/app/modules/candidate/bloc/cubits/candidate_form_cubit.dart';
import 'package:clerk/app/utils/validators.dart';
import 'package:clerk/app/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CandidatePersonalDetails extends StatelessWidget {
  const CandidatePersonalDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<CandidatesFormCubit>();
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
              controller: cubit.nameController,
              label: "Name",
              validator: (String? value) {
                return value?.validateAsName();
              },
              helperText: "Harnaaz Sandhu",
              leading: Icons.person_rounded),
          SizedBox(
            height: 20.h,
          ),
          CustomTextField(
              isOutlined: true,
              controller: cubit.ageController,
              maxLength: 3,
              label: "Age",
              validator: (String? value) {
                return value?.validateAsAge();
              },
              inputType: TextInputType.number,
              helperText: "22 Yrs.",
              leading: Icons.person),
          SizedBox(
            height: 20.h,
          ),
          CustomTextField(
              isOutlined: true,
              maxLength: 60,
              controller: cubit.addressController,
              label: "Address (optional)",
              helperText: "Connaught Place, New Delhi",
              leading: Icons.home_rounded),
          SizedBox(
            height: 20.h,
          ),
        ],
      ),
    );
  }
}
