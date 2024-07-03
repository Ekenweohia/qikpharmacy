import 'package:flutter/material.dart';
import 'package:qik_pharma_mobile/features/splash/splash_screen.dart';
import 'package:qik_pharma_mobile/utils/qikpharma_navigator.dart';
import 'package:qik_pharma_mobile/utils/utils.dart';
import 'package:qik_pharma_mobile/shared/widgets/widgets.dart';

class TwoFaConfirmedDialog extends StatelessWidget {
  const TwoFaConfirmedDialog({
    Key? key,
    this.fromLogin = false,
  }) : super(key: key);

  final bool fromLogin;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        height: 320,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.topRight,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Spacer(),
            Column(
              children: [
                Text(
                  'Two-Factor Authentication',
                  style: textStyle15w400,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 22),
                Image.asset('assets/images/shield.png'),
                const SizedBox(height: 22),
                Text(
                  'Two-Factor Authentication Verified',
                  style: textStyle15w400,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                PrimaryButton(
                  title: 'Done',
                  width: 170,
                  onPressed: () {
                    Navigator.pop(context);

                    QikPharmaNavigator.pushReplacement(
                      context,
                      const SplashScreen(),
                    );
                  },
                ),
              ],
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);

                QikPharmaNavigator.pushReplacement(
                  context,
                  const SplashScreen(),
                );
              },
              child: const Padding(
                padding: EdgeInsets.only(top: 4),
                child: Icon(
                  Icons.close,
                  size: 12,
                  color: AppCustomColors.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
