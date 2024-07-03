import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qik_pharma_mobile/features/cart/presentation/cart_screen.dart';
import 'package:qik_pharma_mobile/features/dashboard/presentation/retailer/screens/search_screen.dart';
import 'package:qik_pharma_mobile/features/notifications/presentation/notifications_screen.dart';
import 'package:qik_pharma_mobile/features/profile/presentation/cubit/user/user_cubit.dart';
import 'package:qik_pharma_mobile/utils/qikpharma_navigator.dart';
import 'package:qik_pharma_mobile/utils/utils.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        const SizedBox(height: 280),
        Positioned(
          bottom: 20,
          child: Container(
            height: 265,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.fromLTRB(26, 80, 26, 0),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/images/home_top_bg.png"),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocBuilder<UserCubit, UserState>(
                      builder: (context, state) {
                        if (state is UserLoaded) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                  backgroundImage: state.user.imagePath != null
                                      ? NetworkImage(state.user.imagePath!)
                                      : null,
                                  child: Text(
                                    '${state.user.name?.substring(0, 1)}',
                                    style: textStyle24Bold.copyWith(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 23),
                              Text(
                                "Hi, ${state.user.name}",
                                style: textStyle24BoldWhite,
                              ),
                            ],
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Welcome to qikPharma",
                      style: textStyle16White.copyWith(
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => QikPharmaNavigator.push(
                    context,
                    const NotificationsScreen(
                      fromHome: false,
                    ),
                  ),
                  child: Icon(
                    Icons.notifications_none_outlined,
                    color: Colors.white.withOpacity(.6),
                    size: 26,
                  ),
                ),
                const SizedBox(width: 25),
                GestureDetector(
                  onTap: () => QikPharmaNavigator.push(
                    context,
                    const CartScreen(
                      fromHome: false,
                    ),
                  ),
                  child: Image.asset(
                    'assets/images/icons/cart_icon.png',
                    height: 26,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 5),
              decoration: BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black.withOpacity(.07),
                    blurRadius: 5,
                    offset: const Offset(0.5, 0.75),
                  )
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(36),
              ),
              child: TextFormField(
                style: const TextStyle(fontSize: 13),
                readOnly: true,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 16),
                  hintText: "Search Medicine & Healthcare products",
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey,
                    size: 22,
                  ),
                ),
                onTap: () {
                  QikPharmaNavigator.push(
                    context,
                    const SearchScreen(),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
