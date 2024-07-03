import 'package:flutter/material.dart';
import 'package:qik_pharma_mobile/utils/utils.dart';

class SettingsItemWidget extends StatelessWidget {
  final Widget icon;
  final String title;
  final Function() onTap;

  const SettingsItemWidget({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.black.withOpacity(.05),
            ),
          ),
        ),
        child: Row(
          children: [
            Container(
              height: 28,
              width: 28,
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: AppCustomColors.primaryColor,
                borderRadius: BorderRadius.circular(5),
              ),
              alignment: Alignment.center,
              child: icon,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: textStyle15w400,
            ),
            const Spacer(),
            Icon(
              Icons.keyboard_arrow_right,
              color: AppCustomColors.textBlue.withOpacity(.45),
            )
          ],
        ),
      ),
    );
  }
}
