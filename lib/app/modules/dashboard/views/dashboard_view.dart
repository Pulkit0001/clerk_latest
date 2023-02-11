import 'package:clerk/app/modules/group/views/group_detail_view.dart';
import 'package:clerk/app/modules/home/views/home_view.dart';
import 'package:clerk/app/modules/profile_tab/views/profile_tab_view.dart';
import 'package:clerk/app/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';
import '../cubit/dashboard_cubit.dart';
import '../cubit/dashboard_state.dart';

var tabs = <Widget>[GroupDetailView(), HomeView(), ProfileTabView.getWidget()];

class DashboardView extends StatelessWidget {

  static Route<dynamic> getRoute() {
    return MaterialPageRoute(
      builder: (context) => BlocProvider<DashboardCubit>(
        create: (context) => DashboardCubit(),
        child: DashboardView(),
      ),
    );
  }

  static Widget getWidget() {
    return BlocProvider<DashboardCubit>(
        create: (context) => DashboardCubit(),
        child: DashboardView(),
      );
  }

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<DashboardCubit>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: BlocBuilder<DashboardCubit, DashboardState>(
            builder: (context, state) {
          return tabs[state.pageIndex];
        }),
        bottomNavigationBar: Container(
          // clipBehavior: Clip.antiAliasWithSaveLayer,
          margin: EdgeInsets.symmetric(horizontal: 12.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.w)),
          ),
          child: MotionTabBar(
            initialSelectedTab: "Home",
            labels: const ["Groups", "Home", "Profile"],
            icons: const [Icons.groups, Icons.home, Icons.person],
            tabSize: 36.w,
            tabBarHeight: 46.w,
            textStyle: const TextStyle(
              fontSize: 12,
              color: backgroundColor,
              fontWeight: FontWeight.w500,
            ),
            tabIconColor: backgroundColor,
            tabIconSize: 24.w,
            tabIconSelectedSize: 24.w,
            tabSelectedColor: backgroundColor,
            tabIconSelectedColor: primaryColor,
            tabBarColor: primaryColor,
            onTabItemSelected: (int value) {
              cubit.changePageIndex(value);
            },
          ),
        ),
      ),
    );
  }
}
