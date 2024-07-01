import 'package:flutter/material.dart';
import 'package:home_domotique/constant.dart';

class CustomButton extends StatelessWidget {
  final void Function() onPressed;
  final Icon icon;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      onPressed: onPressed,
      icon: icon,
      style: IconButton.styleFrom(
        foregroundColor: primaryTextColor,
        backgroundColor: accentColor,
      ),
    );
  }
}
