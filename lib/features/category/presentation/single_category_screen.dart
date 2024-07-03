import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qik_pharma_mobile/core/models/models.dart';
import 'package:qik_pharma_mobile/features/category/presentation/cubit/single_category_cubit.dart';
import 'package:qik_pharma_mobile/features/dashboard/presentation/widgets/dashboard_ad_widget.dart';
import 'package:qik_pharma_mobile/shared/widgets/circular_loading_widget.dart';
import 'package:qik_pharma_mobile/shared/widgets/widgets.dart';
import 'package:qik_pharma_mobile/utils/utils.dart';

class CategoryScreen extends StatefulWidget {
  final Category category;

  const CategoryScreen({Key? key, required this.category}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    _getProducts();
    super.initState();
  }

  void _getProducts() {
    final productCubit = BlocProvider.of<SingleCategoryProductsCubit>(context);
    productCubit.getProductsByCategory(widget.category.categoryId!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<SingleCategoryProductsCubit,
            SingleCategoryProductsState>(
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
                        widget.category.name ?? '',
                        style: textStyle16Bold.copyWith(
                            color: AppCustomColors.textBlue),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                const AdWidget(),
                if (state is SingleCategoryProductsLoading)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 24),
                      child: CircularLoadingWidget(),
                    ),
                  ),
                if (state is SingleCategoryProductsError)
                  Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: Text(
                      'No products under this category!',
                      style: textStyle13Light.copyWith(
                        color: AppCustomColors.textBlue,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 2,
                    ),
                  ),
                if (state is SingleCategoryProductsLoaded)
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
                            Text(
                              'Discounted Products',
                              style: textStyle16Bold,
                            ),
                            const SizedBox(height: 16),
                            _buildDiscountedProduct(
                                state.categoryProducts.products!),
                            const SizedBox(height: 20),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: FittedBox(
                                child: Text(
                                  'All Products',
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
                                  for (final p
                                      in state.categoryProducts.products!)
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

  Widget _buildDiscountedProduct(List<Product> products) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final p in products)
            if (p.displayDiscount == true)
              Container(
                width: 110,
                height: 162,
                margin: const EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  color: AppCustomColors.containerBG,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black.withOpacity(.07),
                      blurRadius: 5,
                      offset: const Offset(0.5, 0.75),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Image.network(
                          p.productImagePath!,
                          fit: BoxFit.contain,
                          height: 80,
                        ),
                      ),
                    ),
                    const SizedBox(height: 13),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 17),
                      child: Text(
                        p.name!,
                        style: textStyle13Light.copyWith(
                          color: AppCustomColors.textBlue,
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
        ],
      ),
    );
  }
}
