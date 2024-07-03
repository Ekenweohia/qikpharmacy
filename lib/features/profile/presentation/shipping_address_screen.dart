import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qik_pharma_mobile/features/profile/presentation/cubit/shipping/shipping_cubit.dart';
import 'package:qik_pharma_mobile/features/profile/presentation/widgets/empty_shipping_address_list.dart';
import 'package:qik_pharma_mobile/shared/widgets/circular_loading_widget.dart';
import 'package:qik_pharma_mobile/utils/utils.dart';
import 'package:qik_pharma_mobile/features/profile/presentation/add_shipping_address_screen.dart';
import 'package:qik_pharma_mobile/shared/widgets/widgets.dart';
import 'package:qik_pharma_mobile/utils/qikpharma_navigator.dart';

class ShippingAddressScreen extends StatefulWidget {
  const ShippingAddressScreen({Key? key}) : super(key: key);

  @override
  State<ShippingAddressScreen> createState() => _ShippingAddressScreenState();
}

class _ShippingAddressScreenState extends State<ShippingAddressScreen> {
  @override
  void initState() {
    super.initState();

    _getShippingAddress();
  }

  void _getShippingAddress() {
    final cubit = BlocProvider.of<ShippingCubit>(context);
    cubit.getShippingAddress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 38, vertical: 19),
          child: Column(
            children: [
              Row(
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
                    'My shipping Address',
                    style: textStyle20Bold,
                  )
                ],
              ),
              const SizedBox(height: 40),
              BlocBuilder<ShippingCubit, ShippingState>(
                builder: (context, state) {
                  if (state is ShippingDetailsLoading) {
                    return const Center(child: CircularLoadingWidget());
                  }

                  if (state is ShippingDetailsLoaded) {
                    return Column(
                      children: List.generate(
                        state.shippingDetails.length,
                        (index) {
                          final item = state.shippingDetails[index];
                          return Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.black12),
                            ),
                            child: Stack(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(left: 20.0),
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      if (item.isDefault!)
                                        const SizedBox(height: 15),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                              'assets/images/icons/person.svg'),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Text(
                                              item.name!,
                                              style: textStyle15w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                              'assets/images/icons/phone.svg'),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Text(
                                              item.phoneNumber!,
                                              style: textStyle15w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                              'assets/images/icons/location.svg'),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Text(
                                              item.address!,
                                              style: textStyle15w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 19),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: SizedBox(
                                              height: 34,
                                              child: PrimaryButton(
                                                title: 'Edit',
                                                hasBorder: true,
                                                borderColor: AppCustomColors
                                                    .primaryColor,
                                                buttonColor: Colors.white,
                                                textColor: Colors.black,
                                                onPressed: () =>
                                                    QikPharmaNavigator.push(
                                                  context,
                                                  AddNewShippingAddressScreen(
                                                    isEdit: true,
                                                    shippingAddress: state
                                                        .shippingDetails[index],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 26),
                                          Expanded(
                                            child: SizedBox(
                                              height: 34,
                                              child: PrimaryButton(
                                                title: 'Delete',
                                                hasBorder: true,
                                                borderColor:
                                                    AppCustomColors.red,
                                                buttonColor: Colors.white,
                                                textColor: Colors.red,
                                                onPressed: () {
                                                  showDialog(
                                                    context: context,
                                                    barrierDismissible: false,
                                                    builder:
                                                        (BuildContext context) {
                                                      return _deleteShippingAddressDialog(
                                                        item.shippingAddressId!,
                                                      );
                                                    },
                                                  );
                                                },
                                                loading:
                                                    state is ShippingLoading,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                if (item.isDefault!)
                                  Image.asset(
                                    'assets/images/ic_default.png',
                                    height: 60.0,
                                    width: 60.0,
                                  ),
                                if (item.isDefault!)
                                  Transform.rotate(
                                    angle: -math.pi / 4,
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                        top: 12.0,
                                        bottom: 20.0,
                                        right: 10,
                                      ),
                                      child: Text(
                                        'DEFAULT',
                                        style: textStyle11Light.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return const EmptyShippingAddressList();
                },
              ),
              const Spacer(),
              PrimaryButton(
                title: 'Add a new address',
                onPressed: () => QikPharmaNavigator.push(
                  context,
                  const AddNewShippingAddressScreen(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _deleteShippingAddressDialog(String shippingAddressId) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 25,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/ic_quetion.png',
                  width: 17,
                  height: 17,
                ),
                const SizedBox(width: 21),
                Container(
                  margin: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    'Delete Shipping Address',
                    style: textStyle15w400,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 17),
            Text(
              'Confirm deleting of shipping address',
              style: textStyle15w400,
            ),
            const SizedBox(height: 26),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 34,
                    child: PrimaryButton(
                      title: 'Cancel',
                      hasBorder: true,
                      borderColor: AppCustomColors.red,
                      buttonColor: Colors.white,
                      textColor: Colors.red,
                      onPressed: () => Navigator.maybePop(context),
                    ),
                  ),
                ),
                const SizedBox(width: 26),
                Expanded(
                  child: SizedBox(
                    height: 34,
                    child: PrimaryButton(
                      title: 'Okay',
                      onPressed: () {
                        final cubit = BlocProvider.of<ShippingCubit>(context);

                        cubit.deleteShippingAddress(
                            shippingAddressId: shippingAddressId);

                        Navigator.maybePop(context);
                      },
                    ),
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
