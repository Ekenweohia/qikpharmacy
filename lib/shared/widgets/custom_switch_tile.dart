import 'package:flutter/material.dart';
import 'package:qik_pharma_mobile/utils/utils.dart';

class CustomSwitchTile extends StatelessWidget {
  final bool isTrue;
  final String label;
  final Color tileColor;
  final Function() onTap;

  const CustomSwitchTile({
    Key? key,
    required this.isTrue,
    required this.label,
    required this.onTap,
    required this.tileColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 30,
            height: 13,
            decoration: BoxDecoration(
              border: Border.all(
                color: isTrue ? tileColor : Colors.grey,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(36),
            ),
            padding: const EdgeInsets.all(.5),
            alignment: isTrue ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              width: 12,
              decoration: BoxDecoration(
                color: isTrue ? tileColor : Colors.grey,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          label,
          style: textStyle13Light,
        ),
      ],
    );
  }
}
