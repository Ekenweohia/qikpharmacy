// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qik_pharma_mobile/features/settings/presentation/email_notification_screen.dart';
import 'package:qik_pharma_mobile/features/settings/presentation/password_and_security_screen.dart';
import 'package:qik_pharma_mobile/features/settings/presentation/personal_information_screen.dart';
import 'package:qik_pharma_mobile/features/settings/presentation/widgets/settings_item_widget.dart';
import 'package:qik_pharma_mobile/utils/qikpharma_dialog_manager.dart';
import 'package:qik_pharma_mobile/utils/qikpharma_navigator.dart';
import 'package:qik_pharma_mobile/utils/utils.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 38, vertical: 19),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.maybePop(context),
                    child: const Icon(
                      Icons.arrow_back,
                      size: 24,
                      color: AppCustomColors.textBlue,
                    ),
                  ),
                  const SizedBox(width: 21),
                  Text(
                    'Settings',
                    style: textStyle24Bold,
                  )
                ],
              ),
              const SizedBox(height: 33),
              Text('Account', style: textStyle17w400),
              const SizedBox(height: 30),
              SettingsItemWidget(
                icon: SvgPicture.asset(
                  'assets/images/icons/person.svg',
                  color: Colors.white,
                  height: 15,
                  width: 15,
                ),
                title: 'Personal Information',
                onTap: () => QikPharmaNavigator.push(
                  context,
                  const PersonalInformationScreen(),
                ),
              ),
              const SizedBox(height: 17),
              SettingsItemWidget(
                icon: const Icon(
                  Icons.lock_outline,
                  color: Colors.white,
                  size: 15,
                ),
                title: 'Password and Security',
                onTap: () => QikPharmaNavigator.push(
                  context,
                  const PasswordAndSecurityScreen(),
                ),
              ),
              const SizedBox(height: 17),
              SettingsItemWidget(
                icon: const Icon(
                  Icons.notifications_outlined,
                  color: Colors.white,
                  size: 15,
                ),
                title: 'Activate Email Notifications',
                onTap: () => QikPharmaNavigator.push(
                  context,
                  const EmailNotificationScreen(),
                ),
              ),
              const SizedBox(height: 17),
              SettingsItemWidget(
                icon: const Icon(
                  Icons.logout,
                  color: Colors.white,
                  size: 15,
                ),
                title: 'Sign out',
                onTap: () => QikPharmaDialogManager.showLogoutDialog(
                    context, "Are you Sure you want to logout ?"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
