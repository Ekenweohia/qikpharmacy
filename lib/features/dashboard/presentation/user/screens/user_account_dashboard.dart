import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qik_pharma_mobile/features/dashboard/presentation/user/screens/invite_friends_screen.dart';
import 'package:qik_pharma_mobile/features/dashboard/presentation/user/screens/user_account_overview.dart';
import 'package:qik_pharma_mobile/features/orders/presentation/my_orders.dart';
import 'package:qik_pharma_mobile/features/product/presentation/cubit/product/product_cubit.dart';
import 'package:qik_pharma_mobile/features/profile/presentation/cubit/user/user_cubit.dart';
import 'package:qik_pharma_mobile/features/profile/presentation/shipping_address_screen.dart';
import 'package:qik_pharma_mobile/features/settings/presentation/settings_screen.dart';
import 'package:qik_pharma_mobile/features/wallet/presentation/account_wallet_screen.dart';
import 'package:qik_pharma_mobile/utils/qikpharma_navigator.dart';
import 'package:qik_pharma_mobile/utils/utils.dart';

class UserAccountDashboard extends StatefulWidget {
  const UserAccountDashboard({Key? key}) : super(key: key);

  @override
  State<UserAccountDashboard> createState() => _UserAccountDashboardState();
}

class _UserAccountDashboardState extends State<UserAccountDashboard> {
  @override
  void initState() {
    _getProducts();
    _getUserDetails();

    super.initState();
  }

  void _getProducts() {
    final categoryCubit = BlocProvider.of<ProductCubit>(context);
    categoryCubit.getProducts();
  }

  void _getUserDetails() {
    final userCubit = BlocProvider.of<UserCubit>(context);
    userCubit.getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTopSection(),
              const SizedBox(height: 20),
              _buildMenuOptions(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuOptions() {
    return Column(
      children: [
        _buildMenuOption(
          onPressed: () => QikPharmaNavigator.push(
              context, const UserAccountOverviewScreen()),
          iconPath: "assets/images/icons/list.svg",
          title: "Overview",
        ),
        _buildMenuOption(
          onPressed: () =>
              QikPharmaNavigator.push(context, const MyOrderScreen()),
          iconPath: "assets/images/icons/doc.svg",
          title: "My Orders",
        ),
        _buildMenuOption(
          onPressed: () =>
              QikPharmaNavigator.push(context, const ShippingAddressScreen()),
          iconPath: "assets/images/icons/help.svg",
          title: "Shipping Address",
        ),
        _buildMenuOption(
          onPressed: () =>
              QikPharmaNavigator.push(context, const SettingsScreen()),
          iconPath: "assets/images/icons/help.svg",
          title: "Settings & Accounts",
        ),
        _buildMenuOption(
          onPressed: () =>
              QikPharmaNavigator.push(context, const AccountWalletScreen()),
          iconPath: "assets/images/icons/setting.svg",
          title: "Wallet",
        ),
        _buildMenuOption(
          onPressed: () => QikPharmaNavigator.push(
            context,
            const InviteFriendsScreen(),
          ),
          iconPath: "assets/images/icons/help.svg",
          title: "Invite friends",
        ),
      ],
    );
  }

  Widget _buildMenuOption({
    required Function onPressed,
    required String iconPath,
    required String title,
  }) {
    return GestureDetector(
      onTap: () => onPressed(),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 10.0,
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(iconPath),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(title, style: textStyle15w400),
                          const Spacer(),
                          const Icon(Icons.navigate_next),
                        ],
                      ),
                      const SizedBox(height: 3),
                      const Divider(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopSection() {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        return Container(
          width: double.infinity,
          height: 220,
          decoration: const BoxDecoration(
            color: AppCustomColors.primaryColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 75,
                      backgroundColor: Colors.white,
                      backgroundImage:
                          state is UserLoaded && state.user.imagePath != null
                              ? NetworkImage(state.user.imagePath!)
                              : null,
                      child: Text(
                        state is UserLoaded && state.user.name != null
                            ? state.user.name!.substring(0, 1)
                            : '',
                        style: textStyle24Bold.copyWith(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (state is UserLoaded)
                        Text(
                          "Hi, ${state.user.name}",
                          style: textStyle20Bold.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      const SizedBox(height: 5),
                      Text(
                        "Account Dashboard",
                        style: textStyle14Light.copyWith(
                          color: Colors.white.withOpacity(.5),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
