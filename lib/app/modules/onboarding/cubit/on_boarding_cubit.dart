import 'package:clerk/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../views/onboarding_view.dart';
import 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit() : super(OnBoardingState(0)) ;

  final PageController pageController = PageController();

  changePageIndex(int index) {
    emit(OnBoardingState(index));
    pageController.animateToPage(index,
        duration: Duration(seconds: 1), curve: Curves.easeIn);
  }
}
