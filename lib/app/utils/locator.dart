import 'package:clerk/app/data/services/cloud_firestore_services/candidates_service.dart';
import 'package:clerk/app/data/services/cloud_firestore_services/charges_service.dart';
import 'package:clerk/app/data/services/cloud_firestore_services/groups_service.dart';
import 'package:clerk/app/data/services/cloud_firestore_services/invoice_service.dart';
import 'package:clerk/app/data/services/cloud_firestore_services/user_profile_service.dart';
import 'package:clerk/app/data/services/storage_service/firebase_storage_service.dart';
import 'package:clerk/app/repository/auth_repo/auth_repo.dart';
import 'package:clerk/app/repository/auth_repo/auth_repo_impl.dart';
import 'package:clerk/app/repository/candidate_repo/candidate_repo_impl.dart';
import 'package:clerk/app/repository/charge_repo/charge_repo.dart';
import 'package:clerk/app/repository/charge_repo/charge_repo_impl.dart';
import 'package:clerk/app/repository/group_repo/group_repo.dart';
import 'package:clerk/app/repository/group_repo/group_repo_impl.dart';
import 'package:clerk/app/repository/invoice_repo/invoice_repo.dart';
import 'package:clerk/app/repository/invoice_repo/invoice_repo_impl.dart';
import 'package:clerk/app/repository/user_profile_repo/user_profile_repo.dart';
import 'package:clerk/app/repository/user_profile_repo/user_profile_repo_impl.dart';
import 'package:clerk/app/services/auth/firebase_auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

import '../data/services/session_service.dart';
import '../repository/candidate_repo/candidate_repo.dart';

var getIt = GetIt.instance;
final logger = Logger();

void setupDependency() {
  getIt
    ..registerSingleton<Session>(
      Session(),
    )
    ..registerSingleton<FirebaseAuthService>(
      FirebaseAuthService(
        FirebaseAuth.instance,
        FirebaseFirestore.instance,
      ),
    )
    ..registerSingleton<FirebaseStorageService>(
      FirebaseStorageService(FirebaseStorage.instance),
    )
    ..registerSingleton<CandidatesService>(
      CandidatesService(
        getIt<Session>(),
        FirebaseFirestore.instance,
      ),
    )
    ..registerSingleton<GroupsService>(
      GroupsService(
        getIt<Session>(),
        FirebaseFirestore.instance,
      ),
    )
    ..registerSingleton<UserProfileService>(
      UserProfileService(
        getIt<Session>(),
        FirebaseFirestore.instance,
      ),
    )
    ..registerSingleton<ChargesService>(
      ChargesService(
        getIt<Session>(),
        FirebaseFirestore.instance,
      ),
    )
    ..registerSingleton<InvoiceService>(
      InvoiceService(getIt<Session>(), FirebaseFirestore.instance,
          FirebaseFunctions.instance),
    )
    ..registerSingleton<AuthRepo>(
      AuthRepoImpl(
        getIt<FirebaseAuthService>(),
        getIt<Session>(),
      ),
    )
    ..registerSingleton<UserProfileRepo>(
      UserProfileRepoImpl(
        getIt<UserProfileService>(),
        getIt<FirebaseStorageService>(),
      ),
    )
    ..registerSingleton<CandidateRepo>(
      CandidateRepoImpl(
          getIt<CandidatesService>(),
          getIt<GroupsService>(),
          getIt<FirebaseStorageService>(),
          FirebaseFunctions.instance,
          getIt<InvoiceService>()),
    )
    ..registerSingleton<GroupRepo>(
      GroupRepoImpl(
        getIt<GroupsService>(),
      ),
    )
    ..registerSingleton<ChargeRepo>(
      ChargesRepoImpl(
        getIt<ChargesService>(),
        getIt<GroupsService>(),
        getIt<CandidatesService>(),
      ),
    )
    ..registerSingleton<InvoiceRepo>(
      InvoiceRepoImpl(
        getIt<InvoiceService>(),
      ),
    );
}
