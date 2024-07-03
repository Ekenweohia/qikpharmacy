import 'package:flutter/material.dart';
import 'package:qik_pharma_mobile/utils/utils.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key, this.fromHome = true}) : super(key: key);
  final bool fromHome;

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(29, 21, 29, 0),
              child: Row(
                children: [
                  if (!widget.fromHome)
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
                    'Notifications',
                    style: textStyle16Bold.copyWith(
                        color: AppCustomColors.textBlue),
                    textAlign: TextAlign.start,
                  ),
                  const Spacer(),
                  // Text(
                  //   'Clear all',
                  //   style: textStyle13Light.copyWith(
                  //       color: const Color(0XFF1987FB)),
                  //   textAlign: TextAlign.start,
                  // ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Divider(
              color: AppCustomColors.lightGray,
            ),
            const SizedBox(height: 24),
            Center(
              child: Text(
                'No notifications!',
                style: textStyle13Light,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
