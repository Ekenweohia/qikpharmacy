import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qik_pharma_mobile/core/models/models.dart';
import 'package:qik_pharma_mobile/features/product/presentation/cubit/product/product_cubit.dart';
import 'package:qik_pharma_mobile/shared/widgets/circular_loading_widget.dart';
import 'package:qik_pharma_mobile/shared/widgets/widgets.dart';
import 'package:qik_pharma_mobile/utils/utils.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();

  List<Product> productsList = <Product>[];
  List<Product> searchList = <Product>[];

  void updateSearchResult(String value) {
    if (value.isNotEmpty) {
      productsList = [...searchList];

      setState(() {
        productsList.retainWhere((e) {
          return (e.name ?? '').toLowerCase().contains(value.toLowerCase()) ||
              (e.description ?? '').toLowerCase().contains(value.toLowerCase());
        });
      });
    } else {
      setState(() {
        productsList = [...searchList];
      });
    }
  }

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
      body: Container(
        width: double.infinity,
        color: AppCustomColors.scaffoldBG,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                const SizedBox(height: 180),
                Positioned(
                  bottom: 20,
                  child: Container(
                    height: 165,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.fromLTRB(26, 60, 26, 0),
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
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                      ),
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
                        autofocus: true,
                        controller: searchController,
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
                        onChanged: (value) {
                          updateSearchResult(value);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Expanded(
              child: BlocConsumer<ProductCubit, ProductState>(
                listener: (context, state) {
                  if (state is ProductLoaded) {
                    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                      setState(() {
                        productsList = [...state.products];
                        searchList = [...state.products];
                      });
                    });
                  }
                },
                builder: (context, state) {
                  if (state is ProductLoading) {
                    return const Center(
                      child: CircularLoadingWidget(),
                    );
                  }
                  if (state is ProductLoaded) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 24),
                      child: SizedBox(
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
                            for (final p in productsList)
                              ProductCard(product: p)
                          ],
                        ),
                      ),
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
