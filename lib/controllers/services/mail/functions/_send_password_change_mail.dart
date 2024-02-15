part of '../mail_controller.dart';

Future<void> _sendPasswordChangeMailImpl({
  required String email,
}) async {
  String sendMailUrl =
      MailController._backendBaseUrl + MailController._mailSendRoute;
  String mailServiceToken = dotenv.env[EnvValues.MAIL_SERVICE_TOKEN.name]!;

  Dio dio = Dio();

  Map body = {
    "to": email,
    "html": generatePasswordChangeEmail(
      appName,
      Assets.efficacyUserHostedImageUrl,
      dark.toHexCode(),
    ),
    "subject": "Verification code for password change at $appName",
  };
  await dio.post(
    sendMailUrl,
    data: body,
    options: Options(
      headers: {
        "Authorization": "Bearer $mailServiceToken",
      },
    ),
  );
}
