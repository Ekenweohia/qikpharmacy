// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qik_pharma_mobile/features/profile/presentation/cubit/user/user_cubit.dart';
import 'package:qik_pharma_mobile/features/splash/splash_screen.dart';
import 'package:qik_pharma_mobile/utils/qikpharma_navigator.dart';

import 'package:qik_pharma_mobile/utils/utils.dart';
import 'package:qik_pharma_mobile/shared/widgets/primary_button.dart';

class SuccessDialog extends StatelessWidget {
  final String message;

  const SuccessDialog({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              "assets/images/icons/success.svg",
              semanticsLabel: 'success icon',
            ),
            const SizedBox(height: 20),
            FittedBox(
              child: Text(
                "Successful",
                style: textStyle17Bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              message,
              style: textStyle14w400,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            PrimaryButton(
              title: "Ok",
              isEnabled: true,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}

class AlertLogoutDialog extends StatelessWidget {
  final String message;

  const AlertLogoutDialog({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppCustomColors.primaryColor,
                border: Border.all(
                    color: AppCustomColors.lightGray.withOpacity(0.6),
                    width: 5),
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                "assets/images/icons/ic_logout.svg",
                semanticsLabel: 'logout icon',
                // color: Colors.white,
                width: 25,
                height: 25,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            FittedBox(
              child: Text(
                "Logout",
                style: textStyle17Bold,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              message,
              style: textStyle15w400,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            BlocListener<UserCubit, UserState>(
              listener: (context, state) {
                if (state is UserLoggedOut) {
                  QikPharmaNavigator.pushReplacement(
                      context, const SplashScreen());
                }
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Expanded(
                      child: PrimaryButton(
                        title: 'Ok',
                        onPressed: () async {
                          final cubit = BlocProvider.of<UserCubit>(context);

                          await cubit.logOut();
                        },
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: PrimaryButton(
                        title: 'Cancel',
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AlertDeleteDialog extends StatelessWidget {
  final String shippingAddressId;
  const AlertDeleteDialog({Key? key, required this.shippingAddressId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/ic_quetion.png",
                  width: 15.0,
                  height: 15.0,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    "Delete Shipping Address ",
                    style: textStyle17Bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              "Confirm deleting of shipping address ",
              style: textStyle17w400,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 80.0,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.all(5.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          side: const BorderSide(
                            color: Colors.red,
                            width: 1,
                          ),
                        ),
                        child: Text("Cancel", style: textStyle15w500Red),
                      ),
                    ),
                    const SizedBox(width: 20),
                    SizedBox(
                      width: 80.0,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.all(5)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                AppCustomColors.primaryColor),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    side: const BorderSide(
                                        color: AppCustomColors.primaryColor)))),
                        onPressed: () async {
                          Navigator.of(context).pop();
                        },
                        child: Text('Ok', style: textStyle17BoldWhite),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

class AlertCloseAccountDialog extends StatelessWidget {
  const AlertCloseAccountDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppCustomColors.primaryColor,
                border: Border.all(
                    color: AppCustomColors.lightGray.withOpacity(0.6),
                    width: 5),
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                "assets/images/icons/ic_logout.svg",
                semanticsLabel: 'logout icon',
                width: 25,
                height: 25,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            FittedBox(
              child: Text(
                "Close account?",
                style: textStyle17Bold,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'We hate to see you go. Are you sure you want to close your account?',
              style: textStyle15w400,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Expanded(
                    child: PrimaryButton(
                      title: 'Ok',
                      onPressed: () async {
                        final cubit = BlocProvider.of<UserCubit>(context);

                        await cubit.deleteUser();

                        QikPharmaNavigator.pushReplacement(
                            context, const SplashScreen());
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: PrimaryButton(
                      title: 'Cancel',
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
