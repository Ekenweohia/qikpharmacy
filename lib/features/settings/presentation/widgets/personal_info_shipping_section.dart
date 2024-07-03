import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qik_pharma_mobile/features/profile/presentation/cubit/shipping/shipping_cubit.dart';
import 'package:qik_pharma_mobile/features/profile/presentation/shipping_address_screen.dart';
import 'package:qik_pharma_mobile/shared/widgets/circular_loading_widget.dart';
import 'package:qik_pharma_mobile/utils/qikpharma_navigator.dart';
import 'package:qik_pharma_mobile/utils/utils.dart';

class PersonalInfoShippingSection extends StatelessWidget {
  const PersonalInfoShippingSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShippingCubit, ShippingState>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.only(bottom: 20.0),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(28, 15, 28, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Shipping Location",
                      style: textStyle17w400,
                    ),
                    InkWell(
                      onTap: () {
                        QikPharmaNavigator.push(
                          context,
                          const ShippingAddressScreen(),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 1,
                            color: Colors.grey.withOpacity(.5),
                          ),
                        ),
                        child: const Icon(
                          Icons.edit,
                          size: 10,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Divider(color: Colors.black.withOpacity(.2)),
              const SizedBox(height: 12),
              if (state is ShippingDetailsLoading)
                const Center(child: CircularLoadingWidget()),
              if (state is ShippingDetailsLoaded)
                Container(
                  padding: const EdgeInsets.fromLTRB(28, 0, 28, 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Address', style: textStyle15w400),
                      const SizedBox(height: 6),
                      Text(
                        state.shippingDetails
                            .firstWhere((e) => e.isDefault!)
                            .address!,
                        style: textStyle17w400,
                      ),
                      const SizedBox(height: 15),
                      Text('Phone', style: textStyle15w400),
                      const SizedBox(height: 6),
                      Text(
                        state.shippingDetails
                            .firstWhere((e) => e.isDefault!)
                            .phoneNumber!,
                        style: textStyle17w400,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
