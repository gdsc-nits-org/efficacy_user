import 'package:efficacy_user/controllers/services/user/user_controller.dart';
import 'package:efficacy_user/models/user/user_model.dart';
import 'package:efficacy_user/pages/signup/widgets/infopass.dart';
import 'package:efficacy_user/utils/utils.dart';
import 'package:efficacy_user/widgets/custom_phone_input/custom_phone_input.dart';
import 'package:efficacy_user/widgets/custom_text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:efficacy_user/config/config.dart';
import 'package:efficacy_user/pages/pages.dart';
import 'package:intl_phone_field/phone_number.dart';

class SignUpPage extends StatefulWidget {
  static const String routeName = '/SignUpPage';
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}


class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool hidePassword = true;
  PhoneNumber? phoneNumber;
  IconData passVisibility = Icons.visibility;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
          // resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: height * (1 - bodyHeightPercentage),
                  padding: EdgeInsets.symmetric(vertical: height * 0.08),
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
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Sign Up",
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
                                  height: 79,
                                  prefixIcon: Icons.email,
                                ),
                                CustomTextField(
                                  controller: passwordController,
                                  hiddenText: hidePassword,
                                  label: "Password",
                                  validator: Validator.isPasswordValid,
                                  borderRadius: 50,
                                  height: 79,
                                  prefixIcon: Icons.lock,
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        if (passVisibility ==
                                            Icons.visibility) {
                                          setState(() {
                                            passVisibility =
                                                Icons.visibility_off;
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
                                        color: const Color.fromARGB(
                                            255, 67, 67, 67),
                                      )),
                                ),
                                CustomPhoneField(
                                  label: "Phone No.",
                                  onPhoneChanged: (PhoneNumber newPhoneNumber) {
                                    phoneNumber = newPhoneNumber;
                                  },
                                  borderRadius: 50,
                                  helperText: "* Optional",
                                ),
                              ].separate(height*0.01),
                            ),
                            Column(
                              children: [
                                Container(
                                  alignment: Alignment.topCenter,
                                  height: 50,
                                  width: 150,
                                  child: ElevatedButton(
                                    onPressed: () async{
                                      if(_formKey.currentState!.validate()){
                                        Navigator.pushNamed(context, PersonalInfoPage.routeName, arguments: ScreenArguments(emailController, passwordController, phoneNumber));
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
                          ].separate(gap),
                        )),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
