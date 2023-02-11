import 'package:clerk/app/custom_widgets/clerk_progress_indicator.dart';
import 'package:clerk/app/custom_widgets/group_grid_tile_view.dart';
import 'package:clerk/app/modules/candidate/bloc/cubits/candidate_form_cubit.dart';
import 'package:clerk/app/modules/candidate/bloc/states/candidate_form_state.dart';
import 'package:clerk/app/modules/group/bloc/cubits/group_list_cubit.dart';
import 'package:clerk/app/modules/group/bloc/states/group_list_state.dart';
import 'package:clerk/app/modules/group/views/group_form_view.dart';
import 'package:clerk/app/repository/group_repo/group_repo.dart';
import 'package:clerk/app/utils/enums/view_state_enums.dart';
import 'package:clerk/app/utils/extensions.dart';
import 'package:clerk/app/utils/locator.dart';
import 'package:clerk/app/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../custom_widgets/empty_state_view.dart';

class SelectGroupView extends StatelessWidget {
  const SelectGroupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<CandidatesFormCubit>();

    return Container(
      child: BlocBuilder<CandidatesFormCubit, CandidateFormState>(
        builder: (context, state) => Column(
          children: [
            Text(
              "Select Group",
              style: GoogleFonts.nunito(
                  color: backgroundColor,
                  // color: backgroundColor,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2),
            ),
            SizedBox(
              height: 4.h,
            ),
            Expanded(
              child: BlocProvider<GroupListCubit>(
                create: (context) => GroupListCubit(repo: getIt<GroupRepo>()),
                child: Builder(builder: (context) {
                  return BlocBuilder<GroupListCubit, GroupsListState>(
                    builder: (context, state) {
                      switch (state.viewState) {
                        case ViewState.loading:
                          {
                            return ClerkProgressIndicator();
                          }
                        case ViewState.empty:
                          {
                            return EmptyStateWidget(
                              message:
                                  "Don't you have created \n  any groups yet?",
                              image: '',
                              onActionPressed: () async {
                                await context.navigate.push(GroupFormPage.getRoute());
                                context.read<GroupListCubit>().loadGroup(null);
                              },
                            );
                          }
                        case ViewState.idle:
                          {
                            return Column(
                              children: [
                                Row(
                                  children: [
                                    Spacer(),
                                    OutlinedButton(
                                        onPressed: () async {
                                          await context.navigate
                                              .push(GroupFormPage.getRoute());
                                          context.read<GroupListCubit>().loadGroup(null);
                                        },
                                        style: ButtonStyle(
                                          side: MaterialStateProperty.all(
                                            BorderSide(
                                              width: 2,
                                              color: backgroundColor,
                                            ),
                                          ),
                                          shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(30),
                                              ),
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          "Create New",
                                          style: GoogleFonts.poppins(
                                              color: backgroundColor,
                                              letterSpacing: 1,
                                              fontWeight: FontWeight.bold),
                                        )),
                                    SizedBox(
                                      width: 10.w,
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 4.h,
                                ),
                                Container(
                                  // height: 200.h,
                                  child: GridView.builder(
                                    // physics: ,
                                    // primary: false,
                                    shrinkWrap: true,
                                    itemCount: state.groups.length,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisSpacing: 12.h,
                                            mainAxisSpacing: 12.w,
                                            crossAxisCount: 2),
                                    itemBuilder: (context, index) {
                                      return GroupGridTile(
                                        group: state.groups[index],
                                        selected: cubit.state.candidate.group ==
                                            state.groups[index].id,
                                        onPressed: (String value) {
                                          cubit.setGroup(state.groups[index]);
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            );
                          }
                        default:
                          {
                            return Container();
                          }
                      }
                    },
                  );
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
