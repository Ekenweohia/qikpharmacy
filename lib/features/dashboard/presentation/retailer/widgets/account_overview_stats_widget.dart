import 'package:flutter/material.dart';
import 'package:qik_pharma_mobile/utils/utils.dart';

class AccountOverviewStatsWidget extends StatelessWidget {
  const AccountOverviewStatsWidget({
    Key? key,
    required this.icon,
    required this.value,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  final IconData icon;
  final int value;
  final String label;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 142,
        width: 93,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: const Color(0XFFEBEBEB),
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withOpacity(.07),
              blurRadius: 5,
              offset: const Offset(0.5, 0.75),
            )
          ],
        ),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              width: 170.0,
              height: 50.0,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppCustomColors.primaryColor,
                    Color.fromARGB(255, 2, 34, 3),
                  ],
                ),
              ),
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '$value',
              style: textStyle16Bold.copyWith(
                color: AppCustomColors.textBlue,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              label,
              style: textStyle11Light.copyWith(color: AppCustomColors.textBlue),
            )
          ],
        ),
      ),
    );
  }
}
