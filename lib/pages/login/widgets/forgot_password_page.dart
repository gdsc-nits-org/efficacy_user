import 'package:efficacy_user/config/config.dart';
import 'package:efficacy_user/utils/exit_program.dart';
import 'package:efficacy_user/utils/validator.dart';
import 'package:efficacy_user/widgets/custom_text_field/custom_text_field.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  static const String routeName = '/ForgotPasswordPage';
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    double gap = height * 0.01;
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
                    height: height * 0.6,
                    padding: EdgeInsets.symmetric(vertical: height * 0.02),
                    width: width,
                    decoration: const BoxDecoration(color: dark),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: width * 0.5,
                          child: Image.asset(
                            Assets.efficacyUserLogoImagePath,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: width * 0.02),
                          child: Text(
                            "Life made easy, life made efficient",
                            style: TextStyle(
                              fontSize: height * 0.04,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ].separate(gap * 2),
                    )),
                Container(
                  height: height * 0.4,
                  width: width,
                  color: const Color(0xFF213F8D),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: height * 0.03, horizontal: width * 0.05),
                    height: height * 0.5,
                    width: width,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
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
                              "Forgot Password",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge
                                  ?.copyWith(color: dark),
                            ),
                          ),
                          CustomTextField(
                            controller: emailController,
                            label: "Email",
                            validator: Validator.isEmailValid,
                            borderRadius: 50,
                            height: height * 0.09,
                            prefixIcon: Icons.email,
                          ),
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
                          )
                        ].separate(gap),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
