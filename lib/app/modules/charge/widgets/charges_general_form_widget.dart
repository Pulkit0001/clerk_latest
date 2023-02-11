import 'package:clerk/app/custom_widgets/custom_text_field.dart';
import 'package:clerk/app/modules/charge/bloc/cubits/charge_form_cubit.dart';
import 'package:clerk/app/utils/validators.dart';
import 'package:clerk/app/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ChargeGeneralDetails extends StatelessWidget{
  const ChargeGeneralDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<ChargesFormCubit>().generalFormState,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "General Details",
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
                controller: context.read<ChargesFormCubit>().nameController,
                label: "Name",
                helperText: "Charge's name",
                validator: (String? value){
                  return value!.validateAsName();
                },
                leading: Icons.attach_money_rounded),
            SizedBox(
              height: 20.h,
            ),
            CustomTextField(
                isOutlined: true,
                maxLines: null,
                maxLength: 200,
                controller: context.read<ChargesFormCubit>().descController,
                label: "Description (optional)",
                helperText: "Charge's Description",
                validator: null,
                leading: Icons.access_time_rounded),
            SizedBox(
              height: 20.h,
            ),
          ],
        ),
      ),
    );
  }
}
