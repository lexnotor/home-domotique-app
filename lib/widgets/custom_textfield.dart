import 'package:flutter/material.dart';
import 'package:home_domotique/constant.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText, labelText;

  const CustomTextField({
    super.key,
    required this.controller,
    this.hintText = "",
    this.labelText = "",
  });

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle();

    return TextField(
      controller: controller,
      maxLines: 1,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 20,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: primaryColor.withOpacity(0.7),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            color: primaryColor,
            width: 2,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            color: primaryColor,
          ),
        ),
        hintText: hintText,
        hintStyle: textStyle.copyWith(
          color: primaryColor.withOpacity(0.2),
        ),
        labelText: labelText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelStyle: textStyle.copyWith(color: primaryColor),
      ),
      style: textStyle.copyWith(color: primaryColor),
    );
  }
}
