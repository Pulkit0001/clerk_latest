import 'package:clerk/app/custom_widgets/custom_filled_button.dart';
import 'package:clerk/app/modules/candidate/bloc/cubits/candidate_form_cubit.dart';
import 'package:clerk/app/modules/candidate/bloc/states/candidate_form_state.dart';
import 'package:clerk/app/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class UploadImageView extends StatelessWidget {
  const UploadImageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<CandidatesFormCubit>();
    return Container(
      child: BlocBuilder<CandidatesFormCubit, CandidateFormState>(
        builder: (context, state) => Column(
          children: [
            Text(
              "Upload Image",
              style: GoogleFonts.nunito(
                  color: backgroundColor,
                  // color: backgroundColor,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2),
            ),
            Spacer(),
            Container(
              height: 230.h,
              width: 230.h,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(12.w),
              ),
              child: cubit.isImagePicked
                  ? Image.file(cubit.pickedImage!)
                  : Icon(
                Icons.person,
                color: textColor.withOpacity(0.5),
                size: 230.h,
              ),
            ),
            Spacer(),
            Row(
              children: [
                Expanded(
                  child: CustomFilledButton(
                    textSize: 16.sp,
                    label: "Camera",
                    onPressed: () {
                      cubit.pickImageFromCamera();
                    },
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: CustomFilledButton(
                    textSize: 16.sp,
                    label: "Gallery",
                    onPressed: () {
                      cubit.pickImageFromGallery();
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 18.h,
            )
          ],
        ),
      ),
    );
  }
}
