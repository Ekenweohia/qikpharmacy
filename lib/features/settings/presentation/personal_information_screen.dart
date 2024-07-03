import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qik_pharma_mobile/features/profile/presentation/cubit/shipping/shipping_cubit.dart';
import 'package:qik_pharma_mobile/features/profile/presentation/cubit/user/user_cubit.dart';
import 'package:qik_pharma_mobile/features/settings/presentation/widgets/personal_info_account_section.dart';
import 'package:qik_pharma_mobile/features/settings/presentation/widgets/personal_info_profile_section.dart';
import 'package:qik_pharma_mobile/features/settings/presentation/widgets/personal_info_shipping_section.dart';
import 'package:qik_pharma_mobile/utils/utils.dart';

class PersonalInformationScreen extends StatefulWidget {
  const PersonalInformationScreen({Key? key}) : super(key: key);

  @override
  State<PersonalInformationScreen> createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  @override
  void initState() {
    _getUserDetails();

    _getShippingAddress();

    super.initState();
  }

  void _getUserDetails() {
    final userCubit = BlocProvider.of<UserCubit>(context);
    userCubit.getUserDetails();
  }

  void _getShippingAddress() {
    final cubit = BlocProvider.of<ShippingCubit>(context);
    cubit.getShippingAddress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFF2F2F2),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 120,
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(38, 60, 38, 10),
              child: Row(
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
                    'Personal Information',
                    style: textStyle24Bold,
                  )
                ],
              ),
            ),
            const SizedBox(height: 9),
            const PersonalInfoAccountSection(),
            const SizedBox(height: 9),
            const PersonalInfoProfileSection(),
            const SizedBox(height: 9),
            const PersonalInfoShippingSection(),
          ],
        ),
      ),
    );
  }
}
