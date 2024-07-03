import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qik_pharma_mobile/core/models/response/product.dart';
import 'package:qik_pharma_mobile/features/category/presentation/cubit/category_cubit.dart';
import 'package:qik_pharma_mobile/features/dashboard/presentation/retailer/widgets/products_from_wholesalers_widget.dart';
import 'package:qik_pharma_mobile/features/dashboard/presentation/widgets/featured_retailers_widget.dart';
import 'package:qik_pharma_mobile/features/dashboard/presentation/widgets/dashboard_ad_widget.dart';
import 'package:qik_pharma_mobile/features/dashboard/presentation/widgets/dashboard_header.dart';
import 'package:qik_pharma_mobile/features/dashboard/presentation/widgets/top_categories_widget.dart';
import 'package:qik_pharma_mobile/features/product/presentation/cubit/product/deals_of_day/dod_cubit.dart';
import 'package:qik_pharma_mobile/features/product/presentation/cubit/product/product_cubit.dart';
import 'package:qik_pharma_mobile/features/profile/presentation/cubit/user/user_cubit.dart';
import 'package:qik_pharma_mobile/utils/utils.dart';

class RetailerHome extends StatefulWidget {
  const RetailerHome({Key? key}) : super(key: key);

  @override
  State<RetailerHome> createState() => _RetailerHomeState();
}

class _RetailerHomeState extends State<RetailerHome> {
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

  List<Product> products = [];

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
                children: [
                  TopCategoriesWidget(),
                  SizedBox(height: 24),
                  AdWidget(),
                  SizedBox(height: 24),
                  ProductFromWholeSalersWidget(),
                  SizedBox(height: 24),
                  FeaturedSellersWidget(isUser: false),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
