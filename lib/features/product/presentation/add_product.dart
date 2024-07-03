import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:qik_pharma_mobile/core/models/models.dart';
import 'package:qik_pharma_mobile/core/models/request/create_product.dart';
import 'package:qik_pharma_mobile/features/category/presentation/cubit/category_cubit.dart';
import 'package:qik_pharma_mobile/features/product/presentation/cubit/product/user_products/user_product_cubit.dart';
import 'package:qik_pharma_mobile/features/product/presentation/cubit/region/region_cubit.dart';
import 'package:qik_pharma_mobile/features/product/presentation/widget/product_drop_down.dart';
import 'package:qik_pharma_mobile/features/product/presentation/widget/product_text_field.dart';
import 'package:qik_pharma_mobile/shared/widgets/custom_switch_tile.dart';
import 'package:qik_pharma_mobile/shared/widgets/widgets.dart';
import 'package:qik_pharma_mobile/utils/utils.dart';
import 'package:qik_pharma_mobile/features/product/presentation/widget/success_product_screen.dart';
import 'package:image_picker/image_picker.dart';

final productStatusList = ['Active', 'Not active'];

class AddProducts extends StatefulWidget {
  const AddProducts({Key? key, this.product}) : super(key: key);
  final Product? product;

  @override
  State<AddProducts> createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  bool isEdit = false;
  TextEditingController productNameController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController productDesscriptionController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController quantityAvailableController = TextEditingController();

  ValueNotifier<Category?> selectedCategory = ValueNotifier(null);
  ValueNotifier<bool> isActive = ValueNotifier(true);
  ValueNotifier<bool> shouldDisplayDiscount = ValueNotifier(false);
  ValueNotifier<bool> shouldDisplayProductReviews = ValueNotifier(false);
  ValueNotifier<String> selectedRegion = ValueNotifier('');
  ValueNotifier<bool> hasAvailableStock = ValueNotifier(true);
  ValueNotifier<String> imagePath = ValueNotifier('');

  final picker = ImagePicker();

  Future<XFile?> selectedFile = Future.value(null);
  XFile? image;

  bool buttonEnabled() =>
      productNameController.text.isNotEmpty &&
          productPriceController.text.isNotEmpty &&
          productDesscriptionController.text.isNotEmpty &&
          quantityAvailableController.text.isNotEmpty &&
          selectedCategory.value != null &&
          selectedRegion.value.isNotEmpty &&
          image?.path != null ||
      imagePath.value.isNotEmpty;

  @override
  void initState() {
    setState(() {
      if (widget.product != null) {
        isEdit = true;
        selectedCategory.value = widget.product?.productCategory;
        isActive.value = widget.product?.isActive ?? true;
        shouldDisplayDiscount.value = widget.product?.displayDiscount ?? false;
        shouldDisplayProductReviews.value =
            widget.product?.displayReviews ?? false;
        productNameController =
            TextEditingController(text: widget.product!.name);
        hasAvailableStock.value = widget.product!.quantity! > 1 ? true : false;

        productPriceController =
            TextEditingController(text: widget.product?.price.toString());
        productDesscriptionController =
            TextEditingController(text: widget.product?.description);
        discountController = TextEditingController(
            text: widget.product?.discount?.toInt().toString());
        quantityAvailableController = TextEditingController(
            text: widget.product?.quantity?.toInt().toString());
        imagePath.value = widget.product!.productImagePath ?? '';
      }

      buttonEnabled();
    });

    _getRegions();
    _getCategories();
    super.initState();
  }

  void _getCategories() {
    final categoryCubit = BlocProvider.of<CategoryCubit>(context);
    categoryCubit.getCategories();
  }

  void _getRegions() {
    final regionCubit = BlocProvider.of<RegionCubit>(context);
    regionCubit.getAllRegions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocConsumer<UserProductCubit, UserProductState>(
          listener: (context, state) {
            if (state is UserProductCreated) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return SuccessfullyUpdatedProductScreen(
                    message: isEdit
                        ? 'Hurray!!! your product was successfully updated '
                        : 'Hurray!!! your product has been uploaded to your store',
                    isEdit: isEdit,
                  );
                },
              );

              return;
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 29),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.maybePop(context),
                        child: const Icon(
                          Icons.arrow_back,
                          size: 32,
                          color: AppCustomColors.textBlue,
                        ),
                      ),
                      const Spacer(),
                      Column(
                        children: [
                          Center(
                            child: isEdit
                                ? Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(.1),
                                      shape: BoxShape.circle,
                                    ),
                                    child:
                                        Image.asset("assets/images/edit.png"),
                                  )
                                : Image.asset("assets/images/cart.png"),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            isEdit ? 'Edit a product' : 'Add Product',
                            style: textStyle20Bold,
                          ),
                        ],
                      ),
                      const Spacer(),
                    ],
                  ),
                  const SizedBox(height: 11),
                  Expanded(child: addProductForm()),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 124,
                    child: PrimaryButton(
                      title: isEdit ? 'Update' : 'Add',
                      isEnabled: buttonEnabled(),
                      onPressed: buttonEnabled()
                          ? () async {
                              final productCubit =
                                  BlocProvider.of<UserProductCubit>(context);

                              CreateProduct req = CreateProduct(
                                description: productDesscriptionController.text,
                                discount: int.tryParse(discountController.text),
                                isActive: isActive.value,
                                name: productNameController.text,
                                price:
                                    double.parse(productPriceController.text),
                                productCategoryId:
                                    selectedCategory.value?.categoryId,
                                quantity:
                                    int.parse(quantityAvailableController.text),
                                regions: selectedRegion.value,
                                displayDiscount: shouldDisplayDiscount.value,
                                displayReviews:
                                    shouldDisplayProductReviews.value,
                              );

                              if (isEdit) {
                                req.imageUrl = imagePath.value;

                                final file = await DefaultCacheManager()
                                    .getSingleFile(imagePath.value);

                                XFile image = XFile(file.path);

                                productCubit.updateProduct(
                                  req: req,
                                  image: image,
                                  productId: widget.product!.productId!,
                                );
                                return;
                              }

                              productCubit.createProduct(
                                  req: req, image: image);
                            }
                          : null,
                      loading: state is UserProductLoading,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  SingleChildScrollView addProductForm() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 45),
        child: Column(
          children: [
            ProductTextField(
              placeholder: 'Product name',
              errText: 'Product cannot be empty',
              controller: productNameController,
              onChanged: (final value) {
                setState(() {});
              },
            ),
            const SizedBox(height: 18),
            BlocBuilder<CategoryCubit, CategoryState>(
              builder: (context, state) {
                if (state is CategoryLoaded) {
                  selectedCategory.value =
                      selectedCategory.value ?? state.categories[0];

                  return ProductDropDown(
                    initialValue: selectedCategory.value,
                    dropdownMenuItem: state.categories
                        .map(
                          (value) => DropdownMenuItem(
                            value: value,
                            child: Text(
                              value.name!,
                              style: textStyle13Light.copyWith(
                                color: AppCustomColors.textBlue,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (final category) {
                      setState(() {
                        buttonEnabled();
                        selectedCategory.value = category;
                      });
                    },
                  );
                }

                return Text(
                  'Loading...',
                  style: textStyle13Light,
                );
              },
            ),
            const SizedBox(height: 18),
            ProductTextField(
              placeholder: 'Product Price',
              errText: 'Price cannot be empty',
              controller: productPriceController,
              onChanged: (final value) {
                setState(() {});
              },
            ),
            const SizedBox(height: 18),
            ProductTextField(
              placeholder: 'Product Description',
              errText: 'desc cannot be empty',
              controller: productDesscriptionController,
              onChanged: (final value) {
                setState(() {});
              },
              maxLines: 4,
            ),
            const SizedBox(height: 18),
            ProductDropDown(
              initialValue: productStatusList[0],
              dropdownMenuItem: productStatusList
                  .map(
                    (value) => DropdownMenuItem(
                      value: value,
                      child: Text(
                        value,
                        style: textStyle13Light.copyWith(
                          color: AppCustomColors.textBlue,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (_) => buttonEnabled(),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: ProductTextField(
                    placeholder: 'Discount',
                    errText: 'discount cannot be empty',
                    controller: discountController,
                    onChanged: (final value) {
                      setState(() {});
                    },
                    textColor: AppCustomColors.red,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                CustomSwitchTile(
                  isTrue: shouldDisplayDiscount.value,
                  label: 'Display discount',
                  tileColor: AppCustomColors.primaryColor,
                  onTap: () {
                    setState(() {
                      shouldDisplayDiscount.value =
                          !shouldDisplayDiscount.value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 18),
            CustomSwitchTile(
              isTrue: shouldDisplayProductReviews.value,
              label: 'Show product reviews',
              tileColor: Colors.red,
              onTap: () {
                setState(() {
                  shouldDisplayProductReviews.value =
                      !shouldDisplayProductReviews.value;
                });
              },
            ),
            const SizedBox(height: 18),
            BlocBuilder<RegionCubit, RegionState>(
              builder: (context, state) {
                if (state is RegionsLoaded) {
                  final initialValue = selectedRegion.value.isNotEmpty
                      ? state.regions.firstWhere((e) =>
                          e.regionId?.toLowerCase() ==
                          selectedRegion.value.toLowerCase())
                      : widget.product?.user?.country != null
                          ? state.regions.firstWhere((e) =>
                              e.name?.toLowerCase() ==
                              widget.product?.user?.country?.toLowerCase())
                          : state.regions[0];

                  selectedRegion.value = initialValue.regionId!;

                  return ProductDropDown(
                    initialValue: initialValue,
                    dropdownMenuItem: state.regions
                        .map(
                          (value) => DropdownMenuItem(
                            value: value,
                            child: Text(
                              value.name!,
                              style: textStyle13Light.copyWith(
                                color: AppCustomColors.textBlue,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (final region) {
                      setState(() {
                        buttonEnabled();
                        selectedRegion.value = region.regionId;
                      });
                    },
                  );
                }

                return Text(
                  'Loading...',
                  style: textStyle13Light,
                );
              },
            ),
            const SizedBox(height: 18),
            ProductTextField(
              placeholder: 'Quantity available',
              errText: 'Fill in available quantity',
              controller: quantityAvailableController,
              onChanged: (final value) {
                setState(() {});
              },
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Stock availability',
                  style: textStyle13Light,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          hasAvailableStock.value = !hasAvailableStock.value;
                        });
                      },
                      child: Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                          color: hasAvailableStock.value
                              ? AppCustomColors.primaryColor
                              : null,
                          border: Border.all(
                            color: AppCustomColors.primaryColor,
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'InStock',
                      style: textStyle13Light,
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          hasAvailableStock.value = !hasAvailableStock.value;
                        });
                      },
                      child: Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                          color: !hasAvailableStock.value
                              ? AppCustomColors.primaryColor
                              : null,
                          border: Border.all(
                            color: AppCustomColors.primaryColor,
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Out of Stock',
                      style: textStyle13Light,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  'Upload product image',
                  style: textStyle13MediumTextButtonColor.copyWith(
                      color: Colors.black),
                ),
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: () async {
                    image = await picker.pickImage(source: ImageSource.gallery);
                    setState(() {
                      selectedFile = Future.value(image);
                      buttonEnabled();
                    });
                  },
                  child: FutureBuilder<XFile?>(
                    future: selectedFile,
                    builder: (context, snap) {
                      if (snap.hasData) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
                            width: 39,
                            height: 36,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Image.file(
                              File(snap.data!.path),
                              fit: BoxFit.contain,
                            ),
                          ),
                        );
                      } else {
                        if (imagePath.value.isNotEmpty) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              imagePath.value,
                              fit: BoxFit.contain,
                              width: 39,
                              height: 36,
                            ),
                          );
                        }

                        return Container(
                          width: 39,
                          height: 36,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.add,
                            size: 12,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
