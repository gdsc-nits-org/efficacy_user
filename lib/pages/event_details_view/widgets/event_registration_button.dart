import 'package:efficacy_user/config/config.dart';
import 'package:flutter/material.dart';

class EventRegistrationButton extends StatelessWidget {
  const EventRegistrationButton({
    super.key,
    required this.onTap,
    required this.icon,
    required this.message,
  });

  final void Function() onTap;
  final Widget icon;
  final String message;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: icon,
        label: Text(
          message,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(color: dark),
        ),
        style: ElevatedButton.styleFrom(backgroundColor: light),
      ),
    );
  }
}
