import 'package:flutter/material.dart';
import 'package:qik_pharma_mobile/features/cart/presentation/cart_screen.dart';
import 'package:qik_pharma_mobile/features/dashboard/presentation/retailer/screens/search_screen.dart';
import 'package:qik_pharma_mobile/features/notifications/presentation/notifications_screen.dart';
import 'package:qik_pharma_mobile/utils/qikpharma_navigator.dart';
import 'package:qik_pharma_mobile/utils/utils.dart';

class CustomHeader extends StatelessWidget {
  final String text;
  const CustomHeader({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        const SizedBox(height: 220),
        Positioned(
          bottom: 20,
          child: Container(
            height: 210,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.fromLTRB(26, 30, 26, 0),
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
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  text,
                  style: textStyle16BoldWhite,
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
