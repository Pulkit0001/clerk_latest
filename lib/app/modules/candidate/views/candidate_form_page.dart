import 'package:cached_network_image/cached_network_image.dart';
import 'package:clerk/app/custom_widgets/choose_image_source_sheet.dart';
import 'package:clerk/app/custom_widgets/custom_filled_button.dart';
import 'package:clerk/app/custom_widgets/custom_snack_bar.dart';
import 'package:clerk/app/custom_widgets/custom_stepper.dart';
import 'package:clerk/app/data/models/candidate_data_model.dart';
import 'package:clerk/app/data/models/group_data_model.dart';
import 'package:clerk/app/modules/candidate/bloc/cubits/candidate_form_cubit.dart';
import 'package:clerk/app/modules/candidate/bloc/states/candidate_form_state.dart';
import 'package:clerk/app/repository/candidate_repo/candidate_repo.dart';
import 'package:clerk/app/utils/enums/view_state_enums.dart';
import 'package:clerk/app/utils/extensions.dart';
import 'package:clerk/app/utils/locator.dart';
import 'package:clerk/app/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';

class CandidateFormPage extends StatelessWidget {
  const CandidateFormPage({super.key, this.group});

  static Route<dynamic> getRoute({Candidate? candidate, Group? group}) {
    return MaterialPageRoute(
      builder: (context) => BlocProvider<CandidatesFormCubit>(
        create: (context) => CandidatesFormCubit(
            repo: getIt<CandidateRepo>(),
            oldCandidate: candidate,
            group: group),
        child: CandidateFormPage(
          group: group,
        ),
      ),
    );
  }

  final int nbSteps = 5;
  final Group? group;
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<CandidatesFormCubit>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        resizeToAvoidBottomInset: true,
        body: BlocConsumer<CandidatesFormCubit, CandidateFormState>(
            listener: (context, state) {
          if (state.formState == CustomFormState.uploading) {
            context.loaderOverlay.show();
          } else {
            context.loaderOverlay.hide();
          }
          if (state.formState == CustomFormState.success) {
            context.navigate.pop(true);
            CustomSnackBar.show(
                title: "Yeah!!", body: state.successMessage ?? '');
          } else if (state.formState == CustomFormState.error) {
            CustomSnackBar.show(
                title: "OOPS!!", body: state.errorMessage ?? '');
          }
        }, builder: (context, state) {
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
                                  Text(
                                    "Candidate",
                                    style: GoogleFonts.nunito(
                                        color: backgroundColor,
                                        fontSize: 24.sp,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1),
                                  )
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
                        if (context.read<CandidatesFormCubit>().toCreate)
                          Padding(
                            padding: EdgeInsets.only(top: 8.h, bottom: 20.h),
                            child: CustomStepper(
                                steps: 5, currentStep: state.formStep),
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
                                  colors: [lightPrimaryColor, backgroundColor]),
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(24.w)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  child: !context
                                          .read<CandidatesFormCubit>()
                                          .toCreate
                                      ? SingleChildScrollView(
                                          child: _buildCandidateUpdateForm())
                                      : CandidateFormPages[state.formStep],
                                ),
                                // Spacer(),
                                !context.read<CandidatesFormCubit>().toCreate
                                    ? CustomFilledButton(
                                        label: "UPDATE",
                                        onPressed: () {
                                          context
                                              .read<CandidatesFormCubit>()
                                              .updateCandidateDetails();
                                        })
                                    : Padding(
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
                                                if (cubit.validateForm()) {
                                                  if (state.formStep <
                                                      nbSteps - 1) {
                                                    cubit.changeFormStep(
                                                        state.formStep + 1);
                                                  } else {
                                                    if (state.formStep ==
                                                        nbSteps - 1) {
                                                      cubit.createCandidate();
                                                    }
                                                  }
                                                }
                                              },
                                              elevation: 6,
                                              materialTapTargetSize:
                                                  MaterialTapTargetSize.padded,
                                              backgroundColor: backgroundColor,
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
        }),
      ),
    );
  }

  Widget _buildCandidateUpdateForm() {
    return BlocBuilder<CandidatesFormCubit, CandidateFormState>(
      builder: (context, state) {
        return Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 96,
                  width: 96,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: context.read<CandidatesFormCubit>().isImagePicked
                      ? Image.file(
                          context.read<CandidatesFormCubit>().pickedImage!)
                      : CachedNetworkImage(
                          progressIndicatorBuilder: (context, widget, chunk) =>
                              Container(
                            color: Colors.grey,
                          ),
                          fit: BoxFit.cover,
                          imageUrl: state.candidate.profilePic,
                          errorWidget: (a, b, c) =>
                              Image.asset('assets/images/avator.png'),
                        ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: InkWell(
                    onTap: () async {
                      ImageSource? imgSource = await showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (_) => ChooseImageSource(),
                      );
                      if (imgSource == ImageSource.camera) {
                        context
                            .read<CandidatesFormCubit>()
                            .pickImageFromCamera();
                      } else if (imgSource == ImageSource.gallery) {
                        context
                            .read<CandidatesFormCubit>()
                            .pickImageFromGallery();
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.edit,
                        color: primaryColor,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            ...CandidateFormPages.sublist(0, 2)
          ],
        );
      },
    );
  }
}
