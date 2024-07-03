import 'package:flutter/material.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:qik_pharma_mobile/features/cart/presentation/cart_screen.dart';
import 'package:qik_pharma_mobile/features/dashboard/presentation/user/screens/user_account_dashboard.dart';
import 'package:qik_pharma_mobile/features/dashboard/presentation/user/screens/user_home.dart';
import 'package:qik_pharma_mobile/features/notifications/presentation/notifications_screen.dart';
import 'package:qik_pharma_mobile/features/settings/presentation/edit_information_screen.dart';

class UserDashboard extends StatefulWidget {
  final int index;

  const UserDashboard({Key? key, this.index = 0}) : super(key: key);

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  int _index = 0;

  @override
  void initState() {
    super.initState();

    setState(() {
      _index = widget.index;
    });
  }

  final _pages = [
    const UserHome(),
    const NotificationsScreen(),
    const UserAccountDashboard(),
    const CartScreen(),
    const EditInformationScreen(),
  ];

  Future<void> _onItemTapped(int index) async {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_index],
      backgroundColor: Colors.white,
      bottomNavigationBar: FloatingNavbar(
        selectedItemColor: Colors.white,
        selectedBackgroundColor: Colors.green,
        unselectedItemColor: const Color.fromARGB(255, 171, 169, 169),
        backgroundColor: Colors.white,
        onTap: (int val) => _onItemTapped(val),
        currentIndex: _index,
        items: [
          FloatingNavbarItem(
            icon: Icons.home_outlined,
          ),
          FloatingNavbarItem(
            icon: Icons.notifications_outlined,
          ),
          FloatingNavbarItem(icon: Icons.add_outlined),
          FloatingNavbarItem(icon: Icons.shopping_bag_outlined),
          FloatingNavbarItem(
            icon: Icons.person_outline_outlined,
          )
        ],
      ),
    );
  }
}
