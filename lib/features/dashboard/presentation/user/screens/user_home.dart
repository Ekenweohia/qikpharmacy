import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qik_pharma_mobile/features/category/presentation/cubit/category_cubit.dart';
import 'package:qik_pharma_mobile/features/dashboard/presentation/user/widgets/deals_of_the_day_widget.dart';
import 'package:qik_pharma_mobile/features/dashboard/presentation/widgets/dashboard_ad_widget.dart';
import 'package:qik_pharma_mobile/features/dashboard/presentation/widgets/dashboard_header.dart';
import 'package:qik_pharma_mobile/features/dashboard/presentation/widgets/featured_retailers_widget.dart';
import 'package:qik_pharma_mobile/features/dashboard/presentation/widgets/top_categories_widget.dart';
import 'package:qik_pharma_mobile/features/product/presentation/cubit/product/deals_of_day/dod_cubit.dart';
import 'package:qik_pharma_mobile/features/product/presentation/cubit/product/product_cubit.dart';
import 'package:qik_pharma_mobile/features/profile/presentation/cubit/user/user_cubit.dart';
import 'package:qik_pharma_mobile/utils/utils.dart';

class UserHome extends StatefulWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  @override
  void initState() {
    _getProducts();
    _getCategories();
    _getUserDetails();
    _getDealsOfDay();

    super.initState();
  }

  void _getCategories() {
    final categoryCubit = BlocProvider.of<CategoryCubit>(context);
    categoryCubit.getCategories();
  }

  void _getProducts() {
    final productCubit = BlocProvider.of<ProductCubit>(context);
    productCubit.getProducts();
  }

  void _getUserDetails() {
    final userCubit = BlocProvider.of<UserCubit>(context);
    userCubit.getUserDetails();
  }

  void _getDealsOfDay() {
    final cubit = BlocProvider.of<DODCubit>(context);
    cubit.getDealsOfDay();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppCustomColors.scaffoldBG,
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DashboardHeader(),
          SizedBox(height: 24),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TopCategoriesWidget(),
                  SizedBox(height: 24),
                  AdWidget(),
                  SizedBox(height: 24),
                  DealsOfTheDayWidget(),
                  SizedBox(height: 24),
                  FeaturedSellersWidget(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
