import 'package:flutter/material.dart';
import 'package:home_domotique/constant.dart';

class RoomCard extends StatelessWidget {
  const RoomCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Switch(
            value: false,
            onChanged: (val) {},
            trackColor: MaterialStateColor.resolveWith(
              (states) {
                return states.contains(MaterialState.selected)
                    ? darkPrimaryColor
                    : primaryTextColor;
              },
            ),
            thumbColor: MaterialStateColor.resolveWith(
              (states) {
                return states.contains(MaterialState.selected)
                    ? primaryTextColor
                    : backgroundColor;
              },
            ),
          ),
          const Text(
            "CHAMBRE 01",
            style: TextStyle(
              color: secondaryTextColor,
              fontWeight: FontWeight.w900,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
