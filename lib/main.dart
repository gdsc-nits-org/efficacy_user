import 'package:flutter/material.dart';
import 'utils/utils.dart';
import 'config/config.dart';
import 'pages/pages.dart';

void main() async {
  runApp(const EfficacyUser());
}

class EfficacyUser extends StatelessWidget {
  const EfficacyUser({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Efficacy User',
      routes: {//issue here
        Homepage.routeName: (context) => const Homepage(),
        SignInPage.routeName: (context) => const SignInPage(),
        SplashScreen.routeName: (context) => const SplashScreen(),
        ProfilePage.routeName: (context) => const ProfilePage(),
        SignUpPage.routeName: (context) => const SignUpPage(),
        OrganizationsPage.routeName: (context) => const OrganizationsPage(),
        ForgotPasswordPage.routeName: (context) => const ForgotPasswordPage()
      },
      builder: ErrorHandler.handle,
      theme: lightTheme,
      initialRoute: SplashScreen.routeName, //ExperimentPage.routeName,
    );
  }
}
