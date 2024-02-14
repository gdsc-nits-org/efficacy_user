import 'package:efficacy_user/config/config.dart';
import 'package:efficacy_user/controllers/services/mail/mail_controller.dart';
import 'package:efficacy_user/controllers/services/user/user_controller.dart';
import 'package:efficacy_user/controllers/services/verification_code/verification_code_controller.dart';
import 'package:efficacy_user/dialogs/loading_overlay/loading_overlay.dart';
import 'package:efficacy_user/models/verification_code/verification_code_model.dart';
import 'package:efficacy_user/pages/login/login_page.dart';
import 'package:efficacy_user/pages/signup/widgets/infopass.dart';
import 'package:efficacy_user/pages/signup/widgets/personal_info.dart';
import 'package:efficacy_user/utils/validator.dart';
import 'package:efficacy_user/widgets/custom_text_field/custom_text_field.dart';
import 'package:efficacy_user/widgets/snack_bar/error_snack_bar.dart';
import 'package:flutter/material.dart';

class VerificationCodePage extends StatefulWidget {
  static const String routeName = '/VerificationCodePage';
  const VerificationCodePage({super.key});

  @override
  State<VerificationCodePage> createState() => _VerificationCodePageState();
}

class _VerificationCodePageState extends State<VerificationCodePage> {
  Future<void> generateAndSendCode(String email) async {
    showLoadingOverlay(
        context: context,
        asyncTask: () async {
          if (!(await UserController.doesUserExists(email: email))) {
            VerificationCodeModel verificationCode =
                await VerificationCodeController.generateRandomCodeAndSave(
              len: 5,
              email: email,
            );
            await MailController.sendVerificationCodeMail(
              code: verificationCode.code,
              email: verificationCode.email,
              expiresAt: verificationCode.expiresAt,
            );
            showSnackBar(context, "Please check your email for the code");
          } else {
            showSnackBar(context, "User already exists");
          }
        });
  }

  final verificationCodeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    double gap = height * 0.01;
    double bodyHeightPercentage = 0.7;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: height * (1 - bodyHeightPercentage),
                padding: EdgeInsets.symmetric(vertical: height * 0.1),
                width: width,
                decoration: const BoxDecoration(color: dark),
                child: SizedBox(
                  width: width * 0.3,
                  child: Image.asset(
                    Assets.efficacyUserLogoImagePath,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              Container(
                height: height * bodyHeightPercentage,
                width: width,
                color: dark,
                child: Container(
                  padding: EdgeInsets.symmetric(
                      vertical: height * 0.03, horizontal: width * 0.05),
                  height: height * 0.7,
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Verification Code",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge
                                  ?.copyWith(color: dark),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    generateAndSendCode(args.email.text);
                                  },
                                  child: Text(
                                    "Resend verification code",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        ?.copyWith(
                                          decoration: TextDecoration.underline,
                                          color: dark,
                                        ),
                                  ),
                                ),
                                CustomTextField(
                                  controller: verificationCodeController,
                                  label: "Verification Code",
                                  validator: (value) => Validator.nullCheck(
                                      value, "Verification Code"),
                                  borderRadius: 50,
                                  height: 79,
                                  prefixIcon: Icons.verified,
                                ),
                              ].separate(height * 0.01),
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                alignment: Alignment.topCenter,
                                height: 50,
                                width: 150,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      await showLoadingOverlay(
                                          context: context,
                                          asyncTask: () async {
                                            await VerificationCodeController
                                                .verifyCode(
                                              code: verificationCodeController
                                                  .text,
                                              email: args.email.text,
                                            );

                                            Navigator.pushNamed(context,
                                                PersonalInfoPage.routeName,
                                                arguments: ScreenArguments(
                                                    args.email,
                                                    args.password,
                                                    args.phoneNumber));
                                          });
                                    }
                                  },
                                  child: Text(
                                    "Next",
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
                                          color:
                                              Theme.of(context).disabledColor,
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
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ].separate(10),
                      )),
                ),
              )
            ],
          ),
        ));
  }
}
