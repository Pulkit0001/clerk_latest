import 'package:clerk/app/modules/app/cubit/app_cubit.dart';
import 'package:clerk/app/modules/dashboard/views/dashboard_view.dart';
import 'package:clerk/app/modules/onboarding/views/onboarding_view.dart';
import 'package:clerk/app/modules/onboarding/views/splash_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app/modules/auth/views/auth_view.dart';
import 'app/repository/auth_repo/auth_repo.dart';
import 'app/repository/user_profile_repo/user_profile_repo.dart';
import 'app/utils/locator.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupDependency();
  const bool USE_EMULATOR = false;

  if (USE_EMULATOR) {
    // [Firestore | localhost:8080]
    FirebaseFirestore.instance.settings = const Settings(
      host: '0.0.0.0:8080',
      sslEnabled: false,
      persistenceEnabled: false,
    );

    // [Authentication | localhost:9099]
    await FirebaseAuth.instance.useEmulator('http://localhost:9099');

    // [Storage | localhost:9199]
    await FirebaseStorage.instance.useEmulator(
      host: 'localhost',
      port: 9199,
    );
  }

  void listener(BuildContext context, AppState state) {

  }
  runApp(
    ScreenUtilInit(
      designSize: Size(360, 690),
      builder: (context, _) => BlocProvider<AppCubit>(
        create: (_) => AppCubit(
          getIt<AuthRepo>(),
          getIt<UserProfileRepo>(),
        )..checkAuthentication(),
        child: Builder(
          builder: (context) {
            return BlocConsumer<AppCubit, AppState>(
              listener: listener,
              builder: (context, state) {
                return MaterialApp(
                  title: "Application",
                  navigatorKey: navigatorKey,
                  home: BlocBuilder<AppCubit, AppState>(
                    builder: (context, state) {
                      return state.estate.mayBeWhen(
                        loggedOut: AuthPage.getWidget,
                        loggedIn: DashboardView.getWidget,
                        notDetermined: SplashView.new,
                        elseMaybe: OnBoardingView.getWidget,
                      );
                    },
                  ),
                );
              },
            );
          }
        ),
      ),
    ),
  );
}
