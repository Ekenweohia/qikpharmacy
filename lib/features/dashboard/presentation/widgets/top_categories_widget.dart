import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qik_pharma_mobile/core/models/models.dart';
import 'package:qik_pharma_mobile/features/category/presentation/cubit/category_cubit.dart';
import 'package:qik_pharma_mobile/features/category/presentation/single_category_screen.dart';
import 'package:qik_pharma_mobile/shared/widgets/circular_loading_widget.dart';
import 'package:qik_pharma_mobile/utils/utils.dart';

class TopCategoriesWidget extends StatelessWidget {
  const TopCategoriesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Top Categories",
            style: textStyle16Bold.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 11),
          BlocBuilder<CategoryCubit, CategoryState>(
            builder: (context, state) {
              if (state is CategoryLoading) {
                return const Center(
                  child: CircularLoadingWidget(),
                );
              }

              if (state is CategoryLoaded) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      for (int i = 0; i < state.categories.length; i++)
                        _buildCategoryCard(context,
                            category: state.categories[i]),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context,
      {required Category category}) {
    return GestureDetector(
      onTap: () => _navigateToCategoryScreen(
        context,
        category: category,
      ),
      child: Container(
        height: 98,
        width: 64,
        padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
        margin: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withOpacity(.05),
              blurRadius: 15.0,
              offset: const Offset(0.0, 0.75),
            )
          ],
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/icons/category_icon.png",
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 3),
            Text(
              category.name!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: textStyle11Light.copyWith(fontSize: 8),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToCategoryScreen(BuildContext context,
      {required Category category}) {
    Navigator.push(
      context,
      PageTransition(
        duration: const Duration(milliseconds: 400),
        type: PageTransitionType.rightToLeft,
        child: CategoryScreen(category: category),
      ),
    );
  }
}
