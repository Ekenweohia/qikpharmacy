import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qik_pharma_mobile/features/dashboard/presentation/widgets/dashboard_ad_widget.dart';
import 'package:qik_pharma_mobile/features/product/presentation/cubit/product/product_cubit.dart';
import 'package:qik_pharma_mobile/shared/widgets/circular_loading_widget.dart';
import 'package:qik_pharma_mobile/shared/widgets/widgets.dart';
import 'package:qik_pharma_mobile/utils/utils.dart';

class UserAccountOverviewScreen extends StatefulWidget {
  const UserAccountOverviewScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<UserAccountOverviewScreen> createState() =>
      _UserAccountOverviewScreenState();
}

class _UserAccountOverviewScreenState extends State<UserAccountOverviewScreen> {
  @override
  void initState() {
    _getProducts();
    super.initState();
  }

  void _getProducts() {
    final productCubit = BlocProvider.of<ProductCubit>(context);
    productCubit.getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 19, 15, 0),
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
                        'Account Overview',
                        style: textStyle16Bold.copyWith(
                            color: AppCustomColors.textBlue),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                const AdWidget(),
                if (state is ProductLoading)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 24),
                      child: CircularLoadingWidget(),
                    ),
                  ),
                if (state is ProductError)
                  Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: Text(
                      'No products found!',
                      style: textStyle13Light.copyWith(
                        color: AppCustomColors.textBlue,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 2,
                    ),
                  ),
                if (state is ProductLoaded)
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 19),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: FittedBox(
                                child: Text(
                                  'All Retailers Products',
                                  style: textStyle16Bold,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 2,
                              child: GridView.count(
                                scrollDirection: Axis.vertical,
                                padding: EdgeInsets.zero,
                                crossAxisCount: 2,
                                childAspectRatio: 2 / 2.5,
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 17,
                                children: [
                                  for (final p in state.products)
                                    ProductCard(product: p),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
