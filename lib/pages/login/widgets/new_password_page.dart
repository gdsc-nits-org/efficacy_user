import 'package:efficacy_user/config/config.dart';
import 'package:efficacy_user/controllers/controllers.dart';
import 'package:efficacy_user/controllers/services/mail/mail_controller.dart';
import 'package:efficacy_user/dialogs/loading_overlay/loading_overlay.dart';
import 'package:efficacy_user/models/models.dart';
import 'package:efficacy_user/pages/login/widgets/forgot_password_page.dart';
import 'package:efficacy_user/pages/pages.dart';
import 'package:efficacy_user/utils/database/constants.dart';
import 'package:efficacy_user/utils/exit_program.dart';
import 'package:efficacy_user/utils/utils.dart';
import 'package:efficacy_user/widgets/custom_text_field/custom_text_field.dart';
import 'package:efficacy_user/widgets/snack_bar/error_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class NewPasswordPage extends StatefulWidget {
  const NewPasswordPage({super.key});

  static const String routeName = "/NewPassword Page";

  @override
  State<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  bool hidePassword = true;
  bool hideConfirmPassword = true;
  IconData passVisibility = Icons.visibility;
  IconData confirmPassVisibility = Icons.visibility;
  final _formKey = GlobalKey<FormState>();

  void saveUpdates() {
    if (_formKey.currentState!.validate()) {
      showLoadingOverlay(
        context: context,
        asyncTask: () async {
          print("-------new user with password created---------");
          UserController.currentUser = UserModel(
            name: "",
            email: ForgotPasswordPage.emailEntered,
            scholarID: "",
            password: Encryptor.encrypt(
              passwordController.text.toString(),
              dotenv.env[EnvValues.ENCRYPTER_SALT.name]!,
            ),
          );
          print(UserController.currentUser);
          ForgotPasswordPage.emailEntered = "";
          await UserController.update(
              password: passwordController.text.toString());
          await MailController.sendPasswordChangeMail(
              email: ForgotPasswordPage.emailEntered);
          showSnackBar(context, "Confirmation Email Sent");
        },
        onCompleted: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => LoginPage(),
              ),
              (route) => false);
        },
      );
    } else {
      print("------------form not valid------------");
    }
  }

  String? isConfirmEqual() {
    if (confirmController.text.toString() ==
        passwordController.text.toString()) {
      return null;
    }
    return "Password and confirm password must be equal";
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    double bodyHeightPercentage = 0.7;
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) {
          return;
        }
        final bool shouldPop = await showExitWarning(context);
        if (shouldPop) {
          SystemNavigator.pop();
        }
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
                            "New Password",
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge
                                ?.copyWith(color: dark),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextField(
                              controller: passwordController,
                              hiddenText: hidePassword,
                              label: "New Password",
                              validator: Validator.isPasswordValid,
                              borderRadius: 50,
                              height: 79,
                              prefixIcon: Icons.lock,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  if (passVisibility == Icons.visibility) {
                                    setState(() {
                                      passVisibility = Icons.visibility_off;
                                      hidePassword = false;
                                    });
                                  } else {
                                    setState(() {
                                      passVisibility = Icons.visibility;
                                      hidePassword = true;
                                    });
                                  }
                                },
                                icon: Icon(
                                  passVisibility,
                                  color: const Color.fromARGB(255, 67, 67, 67),
                                ),
                              ),
                            ),
                            // Column(
                            //   children: [
                            //     CustomTextField(
                            //       controller: confirmController,
                            //       hiddenText: hideConfirmPassword,
                            //       label: "Confirm Password",
                            //       validator: isConfirmEqual,
                            //       borderRadius: 50,
                            //       height: 79,
                            //       prefixIcon: Icons.lock,
                            //       suffixIcon: IconButton(
                            //         onPressed: () {
                            //           if (confirmPassVisibility ==
                            //               Icons.visibility) {
                            //             setState(() {
                            //               confirmPassVisibility =
                            //                   Icons.visibility_off;
                            //               hideConfirmPassword = false;
                            //             });
                            //           } else {
                            //             setState(() {
                            //               confirmPassVisibility =
                            //                   Icons.visibility;
                            //               hideConfirmPassword = true;
                            //             });
                            //           }
                            //         },
                            //         icon: Icon(
                            //           confirmPassVisibility,
                            //           color:
                            //               const Color.fromARGB(255, 67, 67, 67),
                            //         ),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                          ].separate(height * 0.01),
                        ),
                        Column(
                          children: [
                            Container(
                              alignment: Alignment.topCenter,
                              height: 50,
                              width: 200,
                              child: ElevatedButton(
                                onPressed: saveUpdates,
                                child: Text(
                                  "Change Password",
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
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     Text(
                            //       "Don't have an account?",
                            //       style: Theme.of(context)
                            //           .textTheme
                            //           .labelMedium
                            //           ?.copyWith(
                            //             color: Theme.of(context).disabledColor,
                            //           ),
                            //     ),
                            //     TextButton(
                            //       onPressed: () {
                            //         Navigator.pushNamedAndRemoveUntil(
                            //           context,
                            //           SignUpPage.routeName,
                            //           (Route<dynamic> route) => false,
                            //         );
                            //       },
                            //       child: Text(
                            //         "Sign Up",
                            //         style: Theme.of(context)
                            //             .textTheme
                            //             .labelMedium
                            //             ?.copyWith(
                            //               color: dark,
                            //               decoration: TextDecoration.underline,
                            //             ),
                            //       ),
                            //     )
                            //   ],
                            // ),
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
