import 'dart:typed_data';

import 'package:efficacy_user/pages/signup/widgets/edit_form/credentials_step.dart';
import 'package:efficacy_user/pages/signup/widgets/edit_form/misc_step.dart';
import 'package:efficacy_user/pages/signup/widgets/edit_form/personal_info_step.dart';
import 'package:efficacy_user/pages/signup/widgets/edit_form/verification_code.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/phone_number.dart';

class EditForm extends StatelessWidget {
  final int step;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController verificationCodeController;
  final TextEditingController nameController;
  final TextEditingController scholarIDController;
  final void Function(PhoneNumber) onPhoneChanged;
  final void Function(Uint8List? img) onImageChanged;
  final String selectedDegree;
  final Uint8List? imageData;
  final void Function(String? newDegree) onDegreeChanged;
  final String selectedBranch;
  final void Function(String? newBranch) onBranchChanged;
  final List<String> institutes;
  final String selectedInstitute;
  final void Function(String? newInstitutions) onInstituteChanged;

  final Future<void> Function() resendVerificationCode;
  final bool verificationCodeVerified;
  const EditForm({
    super.key,
    required this.step,
    required this.emailController,
    required this.passwordController,
    required this.verificationCodeVerified,
    required this.confirmPasswordController,
    required this.verificationCodeController,
    required this.nameController,
    required this.scholarIDController,
    this.imageData,
    required this.onPhoneChanged,
    required this.onImageChanged,
    required this.selectedDegree,
    required this.onDegreeChanged,
    required this.selectedBranch,
    required this.onBranchChanged,
    required this.institutes,
    required this.selectedInstitute,
    required this.onInstituteChanged,
    required this.resendVerificationCode,
  });

  @override
  Widget build(BuildContext context) {
    if (step == 0) {
      return CredentialsStep(
        emailController: emailController,
        passwordController: passwordController,
        confirmPasswordController: confirmPasswordController,
        verificationCodeVerified: verificationCodeVerified,
      );
    } else if (step == 1) {
      return VerificationStep(
        verificationCodeController: verificationCodeController,
        resendVerificationCode: resendVerificationCode,
        verificationCodeVerified: verificationCodeVerified,
      );
    } else if (step == 2) {
      return PersonalInfoStep(
        nameController: nameController,
        scholarIDController: scholarIDController,
        onPhoneChanged: onPhoneChanged,
      );
    } else {
      return MiscStep(
        onImageChanged: onImageChanged,
        selectedDegree: selectedDegree,
        onDegreeChanged: onDegreeChanged,
        imageData: imageData,
        selectedBranch: selectedBranch,
        onBranchChanged: onBranchChanged,
        institutes: institutes,
        selectedInstitute: selectedInstitute,
        onInstituteChanged: onInstituteChanged,
      );
    }
  }
}
