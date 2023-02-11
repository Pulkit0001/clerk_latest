import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(DashboardState(0));
  final PageController pageController = PageController();

  changePageIndex(int index) {
    emit(DashboardState(index));
  }
}
