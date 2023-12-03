import 'package:clerk/app/custom_widgets/clerk_progress_indicator.dart';
import 'package:clerk/app/custom_widgets/custom_stepper.dart';
import 'package:clerk/app/custom_widgets/custom_text_field.dart';
import 'package:clerk/app/custom_widgets/empty_state_view.dart';
import 'package:clerk/app/modules/candidate/bloc/cubits/candidate_form_cubit.dart';
import 'package:clerk/app/modules/candidate/bloc/states/candidate_form_state.dart';
import 'package:clerk/app/modules/candidate/views/candidate_vertical_list_view.dart';
import 'package:clerk/app/modules/search/bloc/search_state.dart';
import 'package:clerk/app/repository/candidate_repo/candidate_repo.dart';
import 'package:clerk/app/utils/enums/view_state_enums.dart';
import 'package:clerk/app/utils/extensions.dart';
import 'package:clerk/app/utils/locator.dart';
import 'package:clerk/app/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bloc/search_cubit.dart';

class SearchPage extends StatelessWidget {
  final int nbSteps = 5;

  static Route<dynamic> getRoute() => MaterialPageRoute(
      builder: (_) => BlocProvider(
          create: (_) => SearchCubit(repo: getIt<CandidateRepo>()),
          child: SearchPage()));
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<SearchCubit>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        resizeToAvoidBottomInset: false,
        body: Container(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                ),
                child: Card(
                  clipBehavior: Clip.hardEdge,
                  color: primaryColor,
                  margin: EdgeInsets.zero,
                  elevation: 6,
                  shadowColor: primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(24.w))),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
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
                          "Search",
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
                child: Container(
                  decoration: BoxDecoration(
                    color: lightPrimaryColor,
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [lightPrimaryColor, backgroundColor]),
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(24.w)),
                  ),
                  margin:  EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                  child: Column(
                    children: [
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 12.w),
                        child: CustomTextField(
                          controller: cubit.searchController,
                          helperText: "Enter Candidate's Name",
                          leading: null,
                          label: "",
                          isOutlined: true,
                          trailing: Icons.search,
                          onTrailingTapped: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            cubit.searchQuery();
                          },
                        ),
                      ),
                      Expanded(
                        child: BlocBuilder<SearchCubit, SearchState>(
                          builder: (context, state) {
                            if (state.viewState == ViewState.loading) {
                              return ClerkProgressIndicator();
                            } else if (state.viewState == ViewState.idle) {
                              return CandidateVerticalListView.getWidget(
                                  state.searchedItems);
                            } else {
                              return EmptyStateWidget(
                                  image: '',
                                  message: "Didn't find any relevant Results",
                                  onActionPressed: () {});
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
