import 'package:clerk/app/modules/onboarding/cubit/on_boarding_cubit.dart';
import 'package:clerk/app/modules/onboarding/cubit/on_boarding_state.dart';
import 'package:clerk/app/modules/onboarding/views/splash_view.dart';
import 'package:clerk/app/utils/extensions.dart';
import 'package:clerk/app/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../auth/views/auth_view.dart';

class OnBoardingView extends StatelessWidget {
  static Route<dynamic> getRoute() {
    return MaterialPageRoute(
      builder: (context) => BlocProvider<OnBoardingCubit>(
        create: (context) => OnBoardingCubit(),
        child: OnBoardingView(),
      ),
    );
  }

  static Widget getWidget() {
    return BlocProvider<OnBoardingCubit>(
      create: (context) => OnBoardingCubit(),
      child: OnBoardingView(),
    );
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<OnBoardingCubit>();
    return SafeArea(
      child: Scaffold(
        body: Builder(builder: (context) {
          return Container(
              decoration: BoxDecoration(
                color: backgroundColor,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Spacer(),
                            Padding(
                              padding: EdgeInsets.all(12.w),
                              child: TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    "SKIP",
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                        color: primaryColor,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1),
                                  )),
                            ),
                          ],
                        ),
                        Spacer(),
                        Container(
                          height: 200.h,
                          width: 200.w,
                          child: PageView.builder(
                            itemCount: 3,
                            controller: cubit.pageController,
                            onPageChanged: (value) {
                              cubit.changePageIndex(value);
                            },
                            itemBuilder: (context, index) => Placeholder(
                              fallbackHeight: 200.h,
                              fallbackWidth: 200.w,
                            ),
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                    flex: 2,
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(24.w)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Spacer(),
                          Text(
                            "Lorem ipsum dolor sit amet,\n consectetuer adipiscing \n elit, sed diam \n",
                            style: TextStyle(
                                color: backgroundColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                height: 1.4,
                                letterSpacing: 1.5),
                            textAlign: TextAlign.center,
                          ),
                          Spacer(
                            flex: 2,
                          ),
                          BlocBuilder<OnBoardingCubit, OnBoardingState>(
                              builder: (context, state) {
                            return AnimatedSmoothIndicator(
                              activeIndex: state.pageIndex,
                              count: 3,
                              effect: ExpandingDotsEffect(
                                  activeDotColor: backgroundColor,
                                  dotColor: backgroundColor),
                            );
                          }),
                          Spacer(
                            flex: 1,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ));
        }),
        floatingActionButton: FloatingActionButton(
          backgroundColor: backgroundColor,
          onPressed: () {
            if (cubit.state.pageIndex < 2) {
              cubit.changePageIndex(cubit.state.pageIndex + 1);
            } else {
              context.navigate.push(AuthPage.getRoute());
            }
          },
          child: Icon(
            Icons.arrow_forward_ios,
            color: primaryColor,
          ),
        ),
      ),
    );
  }
}
