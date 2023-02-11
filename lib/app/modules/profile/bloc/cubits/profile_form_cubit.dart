import 'dart:io';

import 'package:clerk/app/modules/dashboard/views/dashboard_view.dart';
import 'package:clerk/app/modules/profile/bloc/states/profile_form_state.dart';
import 'package:clerk/app/modules/profile/views/personal_form_view.dart';
import 'package:clerk/app/repository/user_profile_repo/user_profile_repo.dart';
import 'package:clerk/app/utils/enums/payment_cycle.dart';
import 'package:clerk/app/utils/enums/view_state_enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../main.dart';
import '../../../../data/models/user_profile_data_model.dart';
import '../../../../data/services/image_picker.dart';
import '../../views/business_form_view.dart';

List<Widget> profileFormPages = [
  PersonalFormView(),
  BusinessFormView(),
  Container(),
];

class UserProfileFormCubit extends Cubit<UserProfileFormState> {
  UserProfileFormCubit(
      {required this.repo, UserProfile? profile, this.initialFormStep = 0})
      : super(UserProfileFormState.initial(
            userProfile: profile, initialStep: initialFormStep)) {
    if (profile == null) {
      toCreate = true;
    } else {
      firstNameController.text = profile.firstName;
      lastNameController.text = profile.lastName;
      occupationController.text = profile.occupation;
      businessEmailController.text = profile.businessEmail;
      businessPhoneController.text = profile.businessContact;
      businessNameController.text = profile.businessName;
      businessAddressController.text = profile.businessAddress;
      toCreate = false;
    }
  }

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController occupationController = TextEditingController();
  TextEditingController businessEmailController = TextEditingController();
  TextEditingController businessPhoneController = TextEditingController();
  TextEditingController businessNameController = TextEditingController();
  TextEditingController businessAddressController = TextEditingController();

  final GlobalKey<FormState> personalFormState = GlobalKey<FormState>();
  final GlobalKey<FormState> businessFormState = GlobalKey<FormState>();

  final UserProfileRepo repo;

  late bool toCreate;
  final int initialFormStep;

  File? pickedImage;
  bool isImagePicked = false;

  void changeFormStep(int index) {
    emit(state.copyWith(formStep: index));
  }

  bool validateForm() {
    emit(state.copyWith(formState: CustomFormState.idle));
    if (toCreate) {
      if (state.formState == CustomFormState.idle && state.formStep == 0) {
        return personalFormState.currentState!.validate();
      } else if (state.formState == CustomFormState.idle &&
          state.formStep == 1) {
        return businessFormState.currentState!.validate();
      } else {
        return false;
      }
    } else if (state.formState == CustomFormState.idle &&
        initialFormStep == 0) {
      return personalFormState.currentState!.validate();
    } else if (state.formState == CustomFormState.idle &&
        initialFormStep == 1) {
      return businessFormState.currentState!.validate();
    } else {
      return false;
    }
  }

  void setPaymentCycle(PaymentCycle cycle) {
    emit(state.copyWith(
        userProfile: state.userProfile.copyWith(paymentCycle: cycle)));
  }

  void pickImageFromCamera() async {
    var res = await CustomImagePicker.pickFromCamera();
    if (res != null) {
      isImagePicked = true;
      pickedImage = File(res.path);
      emit(
        state.copyWith(),
      );
    }
  }

  void pickImageFromGallery() async {
    var res = await CustomImagePicker.pickFromGallery();
    if (res != null) {
      isImagePicked = true;
      pickedImage = File(res.path);
      emit(
        state.copyWith(formState: CustomFormState.idle),
      );
    }
  }

  void saveUserProfile() async {
    emit(state.copyWith(formState: CustomFormState.uploading));

    if (pickedImage != null) {
      var uploadRes =
          await repo.uploadFile(pickedImage!, onFileUpload: (res) {});
      uploadRes.fold((l) async {
        UserProfile profile;
        profile = state.userProfile.copyWith(
            firstName: firstNameController.text,
            lastName: lastNameController.text,
            occupation: occupationController.text,
            businessName: businessNameController.text,
            businessEmail: businessEmailController.text,
            businessContact: businessPhoneController.text,
            businessAddress: businessAddressController.text,
            businessLogo: l);
        var res = await repo.createUserProfile(profile: profile);
        res.fold(
          (l) {
            emit(state.copyWith(
                formState: CustomFormState.success, successMessage: l));
            if (toCreate) {
              navigatorKey.currentState
                  ?.pushAndRemoveUntil(DashboardView.getRoute(), (_) => false);
            } else {
              navigatorKey.currentState?.pop();
            }
          },
          (r) {
            emit(state.copyWith(
                formState: CustomFormState.idle, errorMessage: r));
          },
        );
      }, (r) {
        emit(state.copyWith(formState: CustomFormState.idle, errorMessage: r));
      });
    } else {
      UserProfile profile;
      profile = state.userProfile.copyWith(
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          occupation: occupationController.text,
          businessName: businessNameController.text,
          businessEmail: businessEmailController.text,
          businessContact: businessPhoneController.text,
          businessAddress: businessAddressController.text,
          businessLogo: '');
      var res = await repo.createUserProfile(profile: profile);
      res.fold(
        (l) {
          emit(state.copyWith(
              formState: CustomFormState.success, successMessage: l));
          if (toCreate) {
            navigatorKey.currentState
                ?.pushAndRemoveUntil(DashboardView.getRoute(), (_) => false);
          } else {
            navigatorKey.currentState?.pop();
          }
        },
        (r) {
          emit(
              state.copyWith(formState: CustomFormState.idle, errorMessage: r));
        },
      );
    }
  }
}
