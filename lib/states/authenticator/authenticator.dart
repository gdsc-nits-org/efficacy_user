import 'package:efficacy_user/models/models.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class Authenticator {
  static UserModel? _currentUser;
  const Authenticator._();

  static UserModel? get currentUser => _currentUser;
  static Future<void> setCurrentUser(UserModel? newUser) async {
    _currentUser = newUser;
  }

  /// TODO: Set it up for IOS
  ///
  /// Could have just made a dummy user with certain values like scholarID
  /// as default to empty string but can cause bugs
  static Future<GoogleSignInAccount> googleSignIn() async {
    GoogleSignInAccount? account = await GoogleSignIn().signIn();
    if (account == null) {
      throw Exception("Couldn't sign in'");
    }
    return account;
  }

  static Future<void> signOut() async {
    await GoogleSignIn().signOut();
  }

  static Future<void> sendEmailOtp(String otp, String recipient) async {
    const String apiUrl = 'https://api.elasticemail.com/v2/email/send';
    final String emailVerAPI = dotenv.env["EMAIL_VERIFICATION_API"] ?? 'null';
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    final bodyMap = {
      'apikey': emailVerAPI,
      'from': "diptangshu1617@gmail.com",
      'to': recipient,
      'subject': "OTP for Email Verification",
      'body_html': "Dear user, your otp for Efficacy is $otp.",
    };

    // try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: bodyMap,
    );

    if (response.statusCode == 200) {
      print('Email sent successfully');
    } else {
      print('Failed to send email. Status code: ${response.statusCode}');
    }
  }
}
