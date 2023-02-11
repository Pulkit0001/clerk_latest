import 'package:clerk/app/custom_widgets/custom_stepper.dart';
import 'package:clerk/app/modules/group/bloc/cubits/group_form_cubit.dart';
import 'package:clerk/app/modules/group/bloc/states/group_form_state.dart';
import 'package:clerk/app/modules/group/views/select_charges_view.dart';
import 'package:clerk/app/utils/extensions.dart';
import 'package:clerk/app/utils/locator.dart';
import 'package:clerk/app/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../repository/group_repo/group_repo.dart';
import 'group_general_details_form_view.dart';

List<Widget> groupFormPages = [
  GroupGeneralDetails(),
  SelectChargesView(),
  Container(),
];

class GroupFormPage extends StatelessWidget {

  static Route<dynamic> getRoute() =>
      MaterialPageRoute(builder: (context) => GroupFormPage());

  final int nbSteps = 2;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GroupsFormCubit>(
      create: (context) => GroupsFormCubit(repo: getIt<GroupRepo>()),
      child: SafeArea(
        child: Scaffold(
            backgroundColor: backgroundColor,
            body: Builder(builder: (context) {
              return BlocBuilder<GroupsFormCubit, GroupFormState>(
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
                                        Text(
                                          "Group",
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
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: 8.h, bottom: 20.h),
                                  child: CustomStepper(
                                      steps: 2, currentStep: state.formStep),
                                ),
                                Expanded(
                                  child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12.w, vertical: 12.h),
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
                                              child:
                                                  groupFormPages[state.formStep]),
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
                                                        context
                                                            .read<
                                                                GroupsFormCubit>()
                                                            .changeFormStep(
                                                                state.formStep -
                                                                    1);
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
                                                        .read<GroupsFormCubit>();
                                                    if (cubit.validateForm()) {
                                                      if (state.formStep <
                                                          nbSteps - 1) {
                                                        cubit.changeFormStep(
                                                            state.formStep + 1);
                                                      } else {
                                                        if (state.formStep ==
                                                            nbSteps - 1) {
                                                          cubit.createGroup();
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
                                      )),
                                ),
                                // Expanded(
                                //     child: Container(
                                //   color: lightPrimaryColor,
                                //   height: double.infinity,
                                //   width: double.infinity,
                                // )),
                              ],
                            ),
                            color: Colors.transparent,
                          ))
                    ],
                  ),
                );
              });
            })),
      ),
    );
  }
}

// class AddCandidate extends StatelessWidget {
//   const AddCandidate({Key? key}) : super(key: key);
//
// }
