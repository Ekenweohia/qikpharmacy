import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qik_pharma_mobile/features/dashboard/presentation/retailer/screens/my_store_home.dart';
import 'package:qik_pharma_mobile/features/product/presentation/add_product.dart';
import 'package:qik_pharma_mobile/features/product/presentation/cubit/product/user_products/user_product_cubit.dart';
import 'package:qik_pharma_mobile/features/product/presentation/retailer_products_list.dart';
import 'package:qik_pharma_mobile/utils/qikpharma_navigator.dart';

import 'package:qik_pharma_mobile/utils/utils.dart';

class ProductDasboard extends StatefulWidget {
  const ProductDasboard({Key? key}) : super(key: key);

  @override
  State<ProductDasboard> createState() => _ProductDasboardState();
}

class _ProductDasboardState extends State<ProductDasboard> {
  @override
  void initState() {
    _getProducts();
    super.initState();
  }

  void _getProducts() {
    final categoryCubit = BlocProvider.of<UserProductCubit>(context);
    categoryCubit.getUserProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppCustomColors.scaffoldBG,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_customAppBar(), const SizedBox(height: 10), _content()],
        ),
      ),
    );
  }

  Widget _customAppBar() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppCustomColors.primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => Navigator.maybePop(context),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const SizedBox(width: 30),
              Text(
                'Product Dashboard',
                style: textStyle24BoldWhite,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _content() {
    return Expanded(
      child: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(16),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: [
          BlocBuilder<UserProductCubit, UserProductState>(
            builder: (context, state) => Container(
              height: 80,
              width: 50,
              padding: const EdgeInsets.all(8),
              child: GestureDetector(
                onTap: () => QikPharmaNavigator.push(
                    context, const RetailerProductsList()),
                child: Card(
                  color: AppCustomColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 10,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          const SizedBox(width: 80),
                          Container(
                            margin: const EdgeInsets.only(top: 15),
                            child: Image.asset(
                              'assets/images/icons/product_cart_icon.png',
                              height: 40,
                            ),
                          ),
                          Positioned(
                            right: 5,
                            top: 5,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0XFFBD2121),
                              ),
                              child: Text(
                                state is UserProductLoaded
                                    ? '${state.products.length > 100 ? '100+' : state.products.length}'
                                    : '0',
                                style: textStyle13Light.copyWith(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'All Products',
                        style: textStyle13Light.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () => QikPharmaNavigator.push(context, const AddProducts()),
            child: ProductIcons(
              icon: Image.asset(
                'assets/images/icons/add_product_icon.png',
                height: 40,
              ),
              desc: 'Add Products',
            ),
          ),
          InkWell(
            onTap: () =>
                QikPharmaNavigator.push(context, const MyStoreHomeScreen()),
            child: ProductIcons(
              icon: Image.asset(
                'assets/images/icons/store_home_icon.png',
                height: 40,
              ),
              desc: 'My Store Home',
            ),
          ),
        ],
      ),
    );
  }
}

class RadiantGradientMask extends StatelessWidget {
  final Widget child;
  const RadiantGradientMask({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => const RadialGradient(
        center: Alignment.topCenter,
        radius: 0.5,
        colors: [
          Colors.green,
          Color.fromARGB(255, 1, 31, 2),
        ],
        tileMode: TileMode.mirror,
      ).createShader(bounds),
      child: child,
    );
  }
}

class ProductIcons extends StatelessWidget {
  final Widget icon;
  final String desc;

  const ProductIcons({
    Key? key,
    required this.icon,
    required this.desc,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 50,
      padding: const EdgeInsets.all(8),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 10,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(height: 20),
            Text(
              desc,
              style: textStyle13Light,
            ),
          ],
        ),
      ),
    );
  }
}
