import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qik_pharma_mobile/core/models/models.dart';
import 'package:qik_pharma_mobile/features/product/presentation/add_product.dart';
import 'package:qik_pharma_mobile/features/product/presentation/cubit/product/user_products/user_product_cubit.dart';
import 'package:qik_pharma_mobile/shared/widgets/circular_loading_widget.dart';
import 'package:qik_pharma_mobile/utils/qikpharma_navigator.dart';
import 'package:qik_pharma_mobile/utils/utils.dart';
import 'package:qik_pharma_mobile/shared/widgets/widgets.dart';

class RetailerProductsList extends StatefulWidget {
  const RetailerProductsList({Key? key, this.product}) : super(key: key);
  final Product? product;

  @override
  State<RetailerProductsList> createState() => _RetailerProductsListState();
}

class _RetailerProductsListState extends State<RetailerProductsList> {
  int selectedIndex = 0;
  bool isSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 29, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.maybePop(context),
                    child: const Icon(
                      Icons.arrow_back,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 34),
                  Text(
                    'Products',
                    style: textStyle20.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 11),
              BlocConsumer<UserProductCubit, UserProductState>(
                listener: (context, state) {
                  if (state is UserProductDeleted) {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return const DeleteSuccessfulDialog();
                      },
                    );
                  }
                },
                builder: (context, state) {
                  if (state is UserProductLoading) {
                    return const Center(child: CircularLoadingWidget());
                  }
                  if (state is UserProductLoaded) {
                    return Expanded(
                      child: Column(
                        mainAxisAlignment: state.products.isEmpty
                            ? MainAxisAlignment.center
                            : MainAxisAlignment.start,
                        children: [
                          Align(
                            alignment: state.products.isEmpty
                                ? Alignment.center
                                : Alignment.centerLeft,
                            child: PrimaryButton(
                              title: 'Create New',
                              width: 252,
                              onPressed: () => QikPharmaNavigator.push(
                                context,
                                const AddProducts(),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          if (state.products.isNotEmpty)
                            Expanded(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(
                                  children: List.generate(
                                    state.products.length,
                                    (index) => Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 12),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (selectedIndex != index) {
                                                  isSelected = isSelected
                                                      ? true
                                                      : !isSelected;

                                                  selectedIndex = index;
                                                } else {
                                                  isSelected = !isSelected;
                                                }
                                              });
                                            },
                                            child: Container(
                                              width: 25,
                                              height: 25,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: AppCustomColors
                                                    .primaryColor,
                                              ),
                                              child: Center(
                                                child: Icon(
                                                  isSelected &&
                                                          selectedIndex == index
                                                      ? Icons.keyboard_arrow_up
                                                      : Icons
                                                          .keyboard_arrow_down,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: isSelected &&
                                                    selectedIndex == index
                                                ? productListSetup(
                                                    state.products[index],
                                                  )
                                                : productDetailItem(
                                                    title: 'Name',
                                                    value: state
                                                        .products[index].name,
                                                  ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget productListSetup(Product product) {
    return Column(
      children: [
        productDetailItem(
          title: 'Name',
          value: product.name,
        ),
        productDetailItem(
          title: 'Image',
          isImage: true,
          imageString: product.productImagePath,
        ),
        productDetailItem(
          title: 'Category',
          value: product.productCategory?.name,
        ),
        productDetailItem(
          title: 'Status',
          value: product.isActive! ? 'Active' : 'Inactive',
        ),
        productDetailItem(
          title: 'Price',
          value: product.price.toString(),
        ),
        productDetailItem(
          title: 'Quantity',
          value: product.quantity.toString(),
        ),
        productDetailItem(
          title: 'Discount',
          value: '-${product.discount?.toInt().toString()}%',
          isDiscount: true,
        ),
        actions(product: product),
      ],
    );
  }

  Widget productDetailItem({
    required String title,
    String? value,
    bool isDiscount = false,
    bool isImage = false,
    String? imageString,
  }) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 12, top: 6),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: textStyle13w500.copyWith(fontSize: 12),
              ),
            ),
            if (isImage && imageString != null)
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Image.network(
                    imageString,
                    height: 21,
                    width: 21,
                  ),
                ),
              )
            else if (value != null)
              Expanded(
                child: Text(
                  value,
                  maxLines: 1,
                  style: textStyle13Light.copyWith(
                    fontSize: 12,
                    color: isDiscount ? Colors.red : null,
                  ),
                ),
              ),
          ],
        ),
      );

  Widget actions({required Product product}) => Padding(
        padding: const EdgeInsets.only(bottom: 12, top: 6),
        child: Row(
          children: [
            Expanded(
              child: Text(
                'Action',
                style: textStyle13w500.copyWith(fontSize: 12),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return DeleteProductAlertDialog(
                              productId: product.productId!,
                            );
                          },
                        );
                      },
                      child: Container(
                        width: 19,
                        height: 19,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.delete_forever,
                          size: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    GestureDetector(
                      onTap: () => QikPharmaNavigator.push(
                          context, AddProducts(product: product)),
                      child: Container(
                        width: 19,
                        height: 19,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.edit_outlined,
                          size: 12,
                          color: AppCustomColors.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
