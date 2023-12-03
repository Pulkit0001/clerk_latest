import 'package:clerk/app/custom_widgets/clerk_dialog.dart';
import 'package:clerk/app/custom_widgets/custom_snack_bar.dart';
import 'package:clerk/app/custom_widgets/empty_state_view.dart';
import 'package:clerk/app/data/models/group_data_model.dart';
import 'package:clerk/app/modules/candidate/bloc/cubits/candidate_list_cubit.dart';
import 'package:clerk/app/modules/candidate/bloc/states/candidate_list_state.dart';
import 'package:clerk/app/modules/candidate/views/candidate_form_page.dart';
import 'package:clerk/app/repository/candidate_repo/candidate_repo.dart';
import 'package:clerk/app/utils/enums/view_state_enums.dart';
import 'package:clerk/app/utils/extensions.dart';
import 'package:clerk/app/utils/locator.dart';
import 'package:clerk/app/values/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../custom_widgets/candidate_vertical_list_tile_view.dart';
import '../../../custom_widgets/clerk_progress_indicator.dart';
import '../../../values/colors.dart';

class CandidateVerticalListView extends StatelessWidget {
  const CandidateVerticalListView({Key? key, this.candidates, this.group})
      : super(key: key);

  final List<String>? candidates;
  final Group? group;

  static Widget getWidget(List<String>? candidates, [Group? group]) {
    return BlocProvider<CandidateListCubit>(
      create: (context) => CandidateListCubit(
        repo: getIt<CandidateRepo>(),
        candidates: candidates,
      ),
      child: CandidateVerticalListView(
        candidates: candidates,
        group: group,
      ),
    );
  }

  final String candidateTag = "candidateTag";
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CandidateListCubit, CandidatesListState>(
      builder: (context, state) {
        if (state.viewState == ViewState.loading) {
          return ClerkProgressIndicator();
        } else if (state.viewState == ViewState.empty) {
          return EmptyStateWidget(
              image: '',
              message: "Don't you have added any Candidates yet",
              onActionPressed: () async {
                await context.navigate
                    .push(CandidateFormPage.getRoute(group: group));
              });
        } else if (state.viewState == ViewState.error) {
          return ErrorStateWidget(
              message: "OOPS!! Something went wrong. Please retry.",
              onActionPressed: () async {
                context.read<CandidateListCubit>().loadCandidates(candidates);
              });
        } else {
          return Container(
            child: Stack(
              children: [
                SlidableAutoCloseBehavior(
                  child: ListView.builder(
                    padding: EdgeInsets.only(bottom: 56),
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: state.candidates.length,
                    itemBuilder: (context, index) => Container(
                      child: Slidable(
                        groupTag: candidateTag,
                        endActionPane: ActionPane(
                          extentRatio: 0.20,
                          motion: ScrollMotion(),
                          children: [
                            SlidableAction(
                              padding: EdgeInsets.only(right: 20),
                              borderRadius: BorderRadius.horizontal(
                                  right: Radius.circular(12.w)),
                              onPressed: (context) {
                                var cubit = context.read<CandidateListCubit>();
                                showDialog(
                                  context: context,
                                  builder: (_) => ClerkDialog(
                                    body: Text(
                                      "Are you sure that you want to delete this candidate?",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.nunito(
                                        color: textColor,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    positiveLabel: "Delete",
                                    onPositivePressed: () async {
                                      var res = await cubit.deleteCandidate(
                                          state.candidates[index].id);
                                      if (res) {
                                        CustomSnackBar.show(
                                            title: defaultSuccessTitle,
                                            body: "Candidate deleted successfully");
                                      } else {
                                        if (state.errorMessage != null) {
                                          CustomSnackBar.show(
                                              title: defaultErrorTitle,
                                              body: defaultErrorBody);
                                        }
                                      }
                                    },
                                    negativeLabel: 'Cancel',
                                    onNegativePressed: () {},
                                  ),
                                );
                              },
                              backgroundColor: Colors.transparent,
                              foregroundColor: primaryColor,
                              icon: Icons.delete_rounded,
                            ),
                          ],
                        ),
                        child: CandidateVerticalListTile(
                          candidate: state.candidates[index],
                          onPressed: (String value) {},
                          selected: false,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 12,
                  bottom: 16,
                  child: SizedBox(
                    height: 32.h,
                    width: 156.w,
                    child: FloatingActionButton.extended(
                      onPressed: () async {
                        await context.navigate
                            .push(CandidateFormPage.getRoute(group: group));
                        // context.read<CandidateListCubit>().loadCandidate(null);
                      },
                      backgroundColor: backgroundColor,
                      label: Text(
                        "Add Candidate",
                        style: GoogleFonts.nunito(
                          color: primaryColor,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      icon: Icon(
                        Icons.add_rounded,
                        color: primaryColor,
                        size: 20.w,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
