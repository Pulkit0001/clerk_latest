import 'dart:io';

import 'package:clerk/app/custom_widgets/custom_snack_bar.dart';
import 'package:clerk/app/repository/invoice_repo/invoice_repo.dart';
import 'package:clerk/app/utils/enums/entity_status.dart';
import 'package:clerk/app/utils/enums/view_state_enums.dart';
import 'package:clerk/app/utils/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../main.dart';
import '../../../../data/models/candidate_data_model.dart';
import '../../../../data/models/group_data_model.dart';
import '../../../../data/services/image_picker.dart';
import '../../../../repository/candidate_repo/candidate_repo.dart';
import '../../views/apply_charges_view.dart';
import '../../views/candidate_contact_details_form_view.dart';
import '../../views/candidate_personal_details_form_view.dart';
import '../../views/select_groups_view.dart';
import '../../views/upload_image_view.dart';
import '../states/candidate_form_state.dart';

List<Widget> CandidateFormPages = [
  CandidatePersonalDetails(),
  CandidateContactDetails(),
  SelectGroupView(),
  ApplyExtraChargeView(),
  UploadImageView(),
  Container(),
];

class CandidatesFormCubit extends Cubit<CandidateFormState> {
  CandidatesFormCubit({required this.repo, this.oldCandidate, Group? group})
      : super(CandidateFormState.initial(
            candidate: oldCandidate ??
                (group != null
                    ? Candidate.empty()
                        .copyWith(group: group.id, groupCharges: group.charges)
                    : null))) {
    if (oldCandidate == null) {
      nameController = TextEditingController();
      ageController = TextEditingController();
      addressController = TextEditingController();
      phoneController = TextEditingController();
      optionalPhoneController = TextEditingController();
      emailController = TextEditingController();
      toCreate = true;
    } else {
      toCreate = false;
      nameController = TextEditingController(text: oldCandidate!.name);
      ageController = TextEditingController(text: oldCandidate!.age.toString());
      addressController =
          TextEditingController(text: oldCandidate!.address.toString());
      phoneController = TextEditingController(text: oldCandidate!.contact);
      optionalPhoneController =
          TextEditingController(text: oldCandidate!.optionalContact);
      emailController = TextEditingController(text: oldCandidate!.email);
    }
  }
  final Candidate? oldCandidate;
  late TextEditingController nameController;
  late TextEditingController ageController;
  late TextEditingController addressController;
  late TextEditingController phoneController;
  late TextEditingController optionalPhoneController;
  late TextEditingController emailController;

  final GlobalKey<FormState> personalFormState = GlobalKey<FormState>();
  final GlobalKey<FormState> contactFormState = GlobalKey<FormState>();

  final CandidateRepo repo;

  late bool toCreate;

  File? pickedImage;
  bool isImagePicked = false;

  void changeFormStep(int index) {
    emit(state.copyWith(formStep: index));
  }

  void removeCharge(String value) {
    var charges = <String>[];
    charges.addAll(state.candidate.extraCharges);
    charges.remove(value);
    emit(
      state.copyWith(
        candidate: state.candidate.copyWith(
          extraCharges: charges,
        ),
      ),
    );
  }

  void addCharge(String value) {
    var charges = <String>[];
    charges.addAll(state.candidate.extraCharges);
    charges.add(value);
    emit(
      state.copyWith(
        candidate: state.candidate.copyWith(
          extraCharges: charges,
        ),
      ),
    );
  }

  void setGroup(Group group) {
    emit(
      state.copyWith(
        candidate: state.candidate.copyWith(
          group: group.id,
          groupCharges: group.charges,
        ),
      ),
    );
  }

  bool validateForm() {
    if (toCreate) {
      if (state.formState == CustomFormState.idle && state.formStep == 0) {
        return personalFormState.currentState!.validate();
      } else if (state.formState == CustomFormState.idle &&
          state.formStep == 1) {
        return contactFormState.currentState!.validate();
      } else if (state.formState == CustomFormState.idle &&
          state.formStep == 2) {
        if (state.candidate.group.isNotNullEmpty) {
          return true;
        } else {
          CustomSnackBar.show(title: "Oops!", body: "Please select a group");
          return false;
        }
      } else if (state.formState == CustomFormState.idle &&
          state.formStep == 3) {
        // if (state.candidate.extraCharges != null) {
        return true;
        // } else {
        //   CustomSnackBar.show(title: "Oops!", body: "Please select a charge");
        //   return false;
        // }
      } else if (state.formState == CustomFormState.idle &&
          state.formStep == 4) {
        return true;
      } else {
        return false;
      }
    } else if (state.formState == CustomFormState.idle) {
      return personalFormState.currentState!.validate() &&
          contactFormState.currentState!.validate();
    } else {
      return false;
    }
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

  void createCandidate() async {
    emit(state.copyWith(formState: CustomFormState.uploading));

    if (pickedImage != null) {
      var uploadRes =
          await repo.uploadFile(pickedImage!, onFileUpload: (res) {});
      await uploadRes.fold((l) async {
        await saveDetails(l);
      }, (r) {
        emit(state.copyWith(formState: CustomFormState.idle, errorMessage: r));
      });
    } else {
      await saveDetails();
    }
  }

  Future<void> saveDetails([String? imageUrl]) async {
    Candidate candidate;
    candidate = state.candidate.copyWith(
        name: nameController.text,
        address: addressController.text,
        age: int.parse(ageController.text),
        contact: phoneController.text,
        optionalContact: optionalPhoneController.text,
        email: emailController.text,
        profilePic: imageUrl,
        status: EntityStatus.active);
    var res = await repo.addCandidate(candidate: candidate);
    res.fold(
      (l) {
        emit(state.copyWith(
            formState: CustomFormState.success,
            successMessage: "Candidate created successfully"));
      },
      (r) {
        emit(state.copyWith(formState: CustomFormState.idle, errorMessage: r));
      },
    );
  }

  void updateCandidateDetails() async {
    emit(state.copyWith(formState: CustomFormState.uploading));
    late Candidate candidate;
    candidate = state.candidate.copyWith(
        name: nameController.text,
        address: addressController.text,
        age: int.parse(ageController.text),
        contact: phoneController.text,
        optionalContact: optionalPhoneController.text,
        email: emailController.text,
        status: EntityStatus.active);
    if (pickedImage != null) {
      var uploadRes =
          await repo.uploadFile(pickedImage!, onFileUpload: (res) {});
      uploadRes.fold((l) async {
        candidate = candidate.copyWith(
          profilePic: l,
        );
      }, (r) {
        emit(state.copyWith(formState: CustomFormState.idle, errorMessage: r));
      });
    }
    var res = await repo.updateCandidate(candidate: candidate);
    res.fold(
      (l) {
        emit(state.copyWith(
            formState: CustomFormState.success,
            successMessage: "Candidate details updated successfully"));
      },
      (r) {
        emit(state.copyWith(formState: CustomFormState.idle, errorMessage: r));
      },
    );
  }

  Future<void> changeGroup() async {
    emit(state.copyWith(formState: CustomFormState.uploading));

    var res = await repo.changeGroup(
        candidateId: state.candidate.id, groupId: state.candidate.group);
    res.fold(
      (l) {
        emit(state.copyWith(
            formState: CustomFormState.success,
            successMessage: "Candidate's group updated successfully"));
      },
      (r) {
        emit(state.copyWith(formState: CustomFormState.error, errorMessage: r));
      },
    );
  }

  Future<void> updateExtraCharges() async {
    emit(state.copyWith(formState: CustomFormState.uploading));

    var res = await repo.updateExtraCharges(
        candidateId: state.candidate.id,
        extraCharges: state.candidate.extraCharges,
        oldExtraCharges: oldCandidate!.extraCharges);
    res.fold(
      (l) {
        emit(state.copyWith(
            formState: CustomFormState.success,
            successMessage: "Candidate charges updated successfully"));
      },
      (r) {
        emit(state.copyWith(formState: CustomFormState.error, errorMessage: r));
      },
    );
  }
}
