import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qik_pharma_mobile/features/product/presentation/cubit/product/deals_of_day/dod_cubit.dart';
import 'package:qik_pharma_mobile/shared/widgets/custom_header.dart';
import 'package:qik_pharma_mobile/shared/widgets/widgets.dart';
import 'package:qik_pharma_mobile/utils/utils.dart';

class ProductsFromRetailersScreen extends StatelessWidget {
  const ProductsFromRetailersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomHeader(text: 'Buy from Retailer'),
            BlocBuilder<DODCubit, DODState>(
              builder: (context, state) {
                if (state is DODLoaded) {
                  return Expanded(
                    child: _body(
                      context,
                      state.products,
                    ),
                  );
                }

                if (state is DODLoading) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _body(BuildContext context, final products) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 40, 0, 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Products from Retailers",
            style: textStyle16Bold,
          ),
          const SizedBox(height: 20),
          Expanded(child: _productsGrid(context, products))
        ],
      ),
    );
  }

  Widget _productsGrid(BuildContext context, final products) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 2,
      child: GridView.count(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.zero,
        crossAxisCount: 2,
        childAspectRatio: 2 / 2.5,
        crossAxisSpacing: 5,
        mainAxisSpacing: 17,
        children: [for (final p in products) ProductCard(product: p)],
      ),
    );
  }
}
