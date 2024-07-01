import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final Widget? trailing, centered, leading;

  const CustomAppBar({
    super.key,
    this.centered,
    this.trailing,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          leading ?? const SizedBox(width: 5),
          centered ?? const SizedBox(width: 5),
          trailing ?? const SizedBox(width: 5),
        ],
      ),
    );
  }
}
