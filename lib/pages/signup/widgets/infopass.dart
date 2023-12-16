import 'package:flutter/material.dart';
import 'package:intl_phone_field/phone_number.dart';

class ScreenArguments{
  final TextEditingController email;
  final TextEditingController password;
  final PhoneNumber? phoneNumber;
  ScreenArguments(this.email, this.password, this.phoneNumber);
}