import 'package:efficacy_user/utils/validator.dart';
import 'package:efficacy_user/widgets/custom_text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:efficacy_user/config/config.dart';
import 'package:efficacy_user/pages/pages.dart';
import 'package:efficacy_user/utils/exit_program.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/LoginPage';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool hidePassword = true;
  IconData passVisibility = Icons.visibility;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    double gap = height * 0.01;
    double bodyHeightPercentage = 0.6;
    return WillPopScope(
      onWillPop: () async {
        final quitCondition = await showExitWarning(context);
        return quitCondition ?? false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
                            "Sign In",
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge
                                ?.copyWith(color: dark),
                          ),
                        ),
                        Column(
                          children: [
                            CustomTextField(
                              controller: emailController,
                              label: "Email",
                              validator: Validator.isEmailValid,
                              borderRadius: 50,
                              height: 50,
                              prefixIcon: Icons.email,
                            ),
                            Column(
                              children: [
                                CustomTextField(
                                  controller: passwordController,
                                  hiddenText: hidePassword,
                                  label: "Password",
                                  validator: Validator.isPasswordValid,
                                  borderRadius: 50,
                                  height: 50,
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
                                      color:
                                          const Color.fromARGB(255, 67, 67, 67),
                                    ),
                                  ),
                                ),
                                // Container(
                                //   alignment: Alignment.topRight,
                                //   child: TextButton(
                                //     onPressed: () {
                                //       Navigator.pushNamed(
                                //         context,
                                //         ForgotPasswordPage.routeName,
                                //       );
                                //     },
                                //     child: Text(
                                //       "Forgot Password?",
                                //       style: TextStyle(
                                //           color:
                                //               Theme.of(context).disabledColor),
                                //     ),
                                //   ),
                                // ),
                              ],
                            )
                          ].separate(height * 0.02),
                        ),
                        Column(
                          children: [
                            Container(
                              alignment: Alignment.topCenter,
                              height: 50,
                              width: 150,
                              child: ElevatedButton(
                                onPressed: () {
                                  _formKey.currentState!.validate();
                                },
                                child: Text(
                                  "Sign In",
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
                                  "Don't have an account?",
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
                                      SignUpPage.routeName,
                                      (Route<dynamic> route) => false,
                                    );
                                  },
                                  child: Text(
                                    "Sign Up",
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
