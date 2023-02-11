import 'package:clerk/app/custom_widgets/empty_state_view.dart';
import 'package:clerk/app/modules/candidate/bloc/cubits/candidate_list_cubit.dart';
import 'package:clerk/app/modules/candidate/bloc/states/candidate_list_state.dart';
import 'package:clerk/app/modules/candidate/views/candidate_form_page.dart';
import 'package:clerk/app/repository/candidate_repo/candidate_repo.dart';
import 'package:clerk/app/utils/enums/view_state_enums.dart';
import 'package:clerk/app/utils/extensions.dart';
import 'package:clerk/app/utils/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../custom_widgets/candidate_vertical_list_tile_view.dart';
import '../../../custom_widgets/clerk_progress_indicator.dart';

class CandidateVerticalListView extends StatelessWidget {
  const CandidateVerticalListView({Key? key, this.candidates})
      : super(key: key);

  final List<String>? candidates;

  static Widget getWidget(List<String>? candidates) {
    return BlocProvider<CandidateListCubit>(
      create: (context) => CandidateListCubit(
        repo: getIt<CandidateRepo>(),
        candidates: candidates,
      ),
      child: CandidateVerticalListView(
        candidates: candidates,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    context.read<CandidateListCubit>().loadCandidate(candidates);
    return BlocBuilder<CandidateListCubit, CandidatesListState>(
      builder: (context, state) {
        if (state.viewState == ViewState.loading) {
          return ClerkProgressIndicator();
        } else if (state.viewState == ViewState.empty) {
          return EmptyStateWidget(
              image: '',
              message: "Don't you have added any Candidates yet",
              onActionPressed: () async {
                await context.navigate.push(CandidateFormPage.getRoute());
              });
        } else {
          return Container(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: state.candidates.length,
              itemBuilder: (context, index) => Container(
                child: CandidateVerticalListTile(
                  candidate: state.candidates[index],
                  onPressed: (String value) {},
                  selected: false,
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
