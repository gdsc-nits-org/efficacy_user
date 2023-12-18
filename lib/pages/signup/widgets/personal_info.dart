import 'dart:typed_data';

import 'package:efficacy_user/controllers/services/image/image_controller.dart';
import 'package:efficacy_user/dialogs/loading_overlay/loading_overlay.dart';
import 'package:efficacy_user/pages/signup/widgets/infopass.dart';
import 'package:efficacy_user/widgets/profile_image_viewer/profile_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:efficacy_user/controllers/services/user/user_controller.dart';
import 'package:efficacy_user/models/user/user_model.dart';
import 'package:efficacy_user/utils/validator.dart';
import 'package:efficacy_user/widgets/custom_text_field/custom_text_field.dart';
import 'package:gap/gap.dart';
import 'package:efficacy_user/config/config.dart';
import 'package:efficacy_user/pages/pages.dart';
import 'package:efficacy_user/utils/exit_program.dart';
import 'package:intl_phone_field/phone_number.dart';

class PersonalInfoPage extends StatefulWidget {
  // TextEditingController? emailController;
  // TextEditingController? passwordController;
  // PhoneNumber? phoneNumber;
  static const String routeName = '/PersonalInfoPage';
  const PersonalInfoPage({
    super.key,
    // this.emailController,
    // this.passwordController,
    // this.phoneNumber,
  });

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController scholarIDController = TextEditingController();
  bool hidePassword = true;
  IconData passVisibility = Icons.visibility;
  final _formKey = GlobalKey<FormState>();
  Uint8List? _image;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    double gap = height * 0.01;
    double bodyHeightPercentage = 0.7;
    return WillPopScope(
      onWillPop: () async {
        final quitCondition = await showExitWarning(context);
        return quitCondition ?? false;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: height * (1 - bodyHeightPercentage),
                padding: EdgeInsets.symmetric(vertical: height * 0.08),
                width: width,
                decoration: const BoxDecoration(color: Color(0xFF213F8D)),
                child: ProfileImageViewer(
                  height: 90,
                  onImageChange: (Uint8List? newImage) {
                    _image = newImage;
                  },
                )
              ),
              Container(
                height: height * bodyHeightPercentage,
                width: width,
                color: dark,
                child: Container(
                  padding: EdgeInsets.symmetric(
                      vertical: height * 0.03, horizontal: width * 0.05),
                  height: height * 0.65,
                  width: width,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Personal Info",
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge
                                ?.copyWith(color: dark),
                          ),
                        ),
                        Column(
                          children: [
                            CustomTextField(
                              controller: nameController,
                              label: "Name",
                              validator: Validator.isNameValid,
                              borderRadius: 50,
                              height: 79,
                              prefixIcon: Icons.person,
                            ),
                            CustomTextField(
                              controller: scholarIDController,
                              label: "Scholar Id",
                              validator: Validator.isScholarIDValid,
                              borderRadius: 50,
                              height: 79,
                              prefixIcon: Icons.numbers,
                            )
                          ].separate(height * 0.01),
                        ),
                        Column(
                          children: [
                            Container(
                              alignment: Alignment.topCenter,
                              height: 50,
                              width: 150,
                              child: ElevatedButton(
                                onPressed: () async {
                                  UserModel? user;
                                  showLoadingOverlay(
                                    context: context,
                                    asyncTask: () async {
                                      UploadInformation? info;
                                      if (_image != null) {
                                        info =
                                            await ImageController.uploadImage(
                                          img: _image!,
                                          userName: nameController.text,
                                          folder: ImageFolder.userImage,
                                        );
                                      }
                                      user = await UserController.create(
                                        UserModel(
                                          name: nameController.text,
                                          email: args.email.text,
                                          password: args.password.text,
                                          scholarID: scholarIDController.text,
                                          userPhoto: info?.url,
                                          userPhotoPublicID: info?.publicID,
                                          phoneNumber: args.phoneNumber,
                                        ),
                                      );
                                    },
                                    onCompleted: () {
                                      if (user != null && mounted) {
                                        Navigator.of(context)
                                            .pushNamedAndRemoveUntil(
                                          Homepage.routeName,
                                          (_) => false,
                                        );
                                      }
                                    });
                                },
                                child: Text(
                                  "Sign Up",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        fontWeight: Theme.of(context)
                                            .textTheme
                                            .labelLarge
                                            ?.fontWeight,
                                      ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Already have an account?",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(
                                        color: Theme.of(context).disabledColor,
                                      ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      LoginPage.routeName,
                                      (Route<dynamic> route) => false,
                                    );
                                  },
                                  child: Text(
                                    "Sign in",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium
                                        ?.copyWith(
                                          color: dark,
                                          decoration: TextDecoration.underline,
                                        ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
