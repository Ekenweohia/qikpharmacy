// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qik_pharma_mobile/features/profile/presentation/cubit/user/user_cubit.dart';
import 'package:qik_pharma_mobile/utils/utils.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class InviteFriendsScreen extends StatefulWidget {
  const InviteFriendsScreen({Key? key}) : super(key: key);

  @override
  State<InviteFriendsScreen> createState() => _InviteFriendsScreenState();
}

class _InviteFriendsScreenState extends State<InviteFriendsScreen> {
  String? currency;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      currency = await Helper.currency();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 242, 241, 241),
      body: SafeArea(
        child: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            if (state is UserLoaded) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 38, vertical: 40),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.maybePop(context),
                          child: const Icon(
                            Icons.arrow_back,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Invite Friends',
                                style: textStyle20Bold.copyWith(
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(height: 55),
                              Text(
                                'Referral Account Overview',
                                style: textStyle16Light.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Container(
                                height: 119,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: Column(
                                  children: [
                                    Center(
                                      child: Text(
                                        'Total Earnings',
                                        style: textStyle11Light,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      '0.00',
                                      style: textStyle30Bold,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 19),
                              const Divider(
                                color: Color.fromARGB(255, 157, 148, 148),
                              ),
                              const SizedBox(height: 13),
                              Text(
                                'Share and give us $currency 20.00, you\'ll get $currency 2.00',
                                style: textStyle12.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 19),
                              Center(
                                child: Image.asset(
                                  "assets/images/refer.png",
                                  width: 82,
                                  height: 82,
                                ),
                              ),
                              const SizedBox(height: 25),
                              Text(
                                'Share $currency 20.00 coupon with other retailers & get $currency 2.00 once they make an order!',
                                textAlign: TextAlign.center,
                                style: textStyle12.copyWith(
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              const SizedBox(height: 42),
                              Container(
                                height: 53,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 11, horizontal: 18),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.black,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      state.user.referralCode!.toUpperCase(),
                                    ),
                                    const Spacer(),
                                    const SizedBox(
                                      height: 25,
                                      child: VerticalDivider(
                                        color: Colors.black,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        await Clipboard.setData(
                                          ClipboardData(
                                            text: state.user.referralCode!,
                                          ),
                                        );

                                        showTopSnackBar(
                                          Overlay.of(context),
                                          const CustomSnackBar.success(
                                            message:
                                                "Referral copied successfully",
                                          ),
                                        );
                                      },
                                      child: Text(
                                        'Copy',
                                        style: textStyle15w400.copyWith(
                                          color: AppCustomColors.primaryColor,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
