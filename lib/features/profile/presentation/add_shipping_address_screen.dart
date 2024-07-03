import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:qik_pharma_mobile/core/models/response/shipping_address.dart';
import 'package:qik_pharma_mobile/features/auth/presentation/cubit/country/country_cubit.dart';
import 'package:qik_pharma_mobile/features/auth/presentation/widgets/options_overlay.dart';
import 'package:qik_pharma_mobile/features/profile/presentation/cubit/shipping/shipping_cubit.dart';
import 'package:qik_pharma_mobile/features/profile/presentation/shipping_update_successful.dart';
import 'package:qik_pharma_mobile/shared/widgets/widgets.dart';
import 'package:qik_pharma_mobile/utils/colors.dart';
import 'package:qik_pharma_mobile/utils/qikpharma_navigator.dart';
import 'package:qik_pharma_mobile/utils/text_styles.dart';

class AddNewShippingAddressScreen extends StatefulWidget {
  final bool isEdit;
  final ShippingAddress? shippingAddress;

  const AddNewShippingAddressScreen({
    Key? key,
    this.isEdit = false,
    this.shippingAddress,
  }) : super(key: key);

  @override
  State<AddNewShippingAddressScreen> createState() =>
      _AddNewShippingAddressScreenState();
}

class _AddNewShippingAddressScreenState
    extends State<AddNewShippingAddressScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController subAddressController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();

  String? selectedCountry;
  String? selectedState;
  bool isDefault = false;

  List<dynamic>? states = [];

  bool buttonEnabled() =>
      nameController.text.isNotEmpty &&
      addressController.text.isNotEmpty &&
      phoneNumberController.text.isNotEmpty &&
      phoneNumberController.text.length >= 11 &&
      selectedCountry != null &&
      selectedState != null &&
      zipCodeController.text.isNotEmpty;

  @override
  void initState() {
    setState(() {
      if (widget.isEdit) {
        selectedCountry = widget.shippingAddress!.country;
        selectedState = widget.shippingAddress!.city;

        isDefault = widget.shippingAddress!.isDefault!;

        nameController =
            TextEditingController(text: widget.shippingAddress!.name);

        addressController =
            TextEditingController(text: widget.shippingAddress!.address);
        zipCodeController =
            TextEditingController(text: widget.shippingAddress!.zipCode);
        phoneNumberController =
            TextEditingController(text: widget.shippingAddress!.phoneNumber);
      }

      buttonEnabled();
    });

    _getCountriesAndStates();

    super.initState();
  }

  void _getCountriesAndStates() async {
    final countryStateCubit = BlocProvider.of<CountryCubit>(context);
    countryStateCubit.getCountries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocConsumer<ShippingCubit, ShippingState>(
          listener: (context, state) {
            if (state is ShippingAddressAdded) {
              QikPharmaNavigator.pushReplacement(
                context,
                const ShippingUpdateSuccessful(
                  title: 'Hurray! Address Added',
                  content:
                      'Your shipping address has been added successfully. You can add more shipping addresses below',
                ),
              );
            }

            if (state is ShippingAddressUpdated) {
              QikPharmaNavigator.pushReplacement(
                context,
                const ShippingUpdateSuccessful(
                  title: 'Hurray! Address Updated',
                  content:
                      'Your shipping address has been updated successfully. You can add more shipping addresses below',
                ),
              );
            }
          },
          builder: (context, state) {
            return Padding(
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
                        !widget.isEdit
                            ? 'Add a shipping address'
                            : 'Update a shipping address',
                        style: textStyle20Bold,
                      )
                    ],
                  ),
                  const SizedBox(height: 36),
                  Expanded(
                    flex: 12,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Contact',
                            style: textStyle15w700,
                          ),
                          const SizedBox(height: 28),
                          InputField(
                            hint: 'Name',
                            controller: nameController,
                            onChanged: (final value) {
                              setState(() {});
                            },
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Example: Emmanuel Kalu Uche',
                            style: textStyle12.copyWith(
                              color: AppCustomColors.textBlue.withOpacity(.45),
                            ),
                          ),
                          const SizedBox(height: 31),
                          InputField(
                            hint: 'Phone Number',
                            controller: phoneNumberController,
                            validator: (final value) {
                              if (value == null || value.length < 11) {
                                return 'Phone number incomplete!';
                              }

                              return null;
                            },
                            onChanged: (final value) {
                              setState(() {});
                            },
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Example: 08123456789',
                            style: textStyle12.copyWith(
                              color: AppCustomColors.textBlue.withOpacity(.45),
                            ),
                          ),
                          const SizedBox(height: 26),
                          Text(
                            'Address',
                            style: textStyle15w700,
                          ),
                          const SizedBox(height: 21),
                          InputField(
                            hint: 'Street, house/apartment/unit',
                            controller: addressController,
                            onChanged: (final value) {
                              setState(() {});
                            },
                          ),
                          const SizedBox(height: 27),
                          InputField(
                            hint: 'Street, house/apartment/unit',
                            controller: subAddressController,
                            onChanged: (final value) {
                              setState(() {});
                            },
                          ),
                          const SizedBox(height: 39),
                          BlocBuilder<CountryCubit, CountryState>(
                            builder: (context, state) {
                              if (state is CountriesLoaded) {
                                if (selectedCountry != null) {
                                  final selectedCountryStates = state.countries
                                      .where((e) =>
                                          e.name?.toLowerCase() ==
                                          selectedCountry?.toLowerCase())
                                      .toList();

                                  states = selectedCountryStates.isNotEmpty
                                      ? selectedCountryStates[0].state
                                      : [];
                                }

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    OptionsOverlay(
                                      placeholderText: 'Select Country',
                                      options: state.countries,
                                      selectedOption: (value) {
                                        setState(() {
                                          selectedCountry = value.name;
                                        });
                                      },
                                    ),
                                    const SizedBox(height: 34),
                                    OptionsOverlay(
                                      placeholderText: 'Select State',
                                      options: states ?? [],
                                      selectedOption: (value) {
                                        setState(() {
                                          selectedState = value.name;
                                        });
                                      },
                                    ),
                                  ],
                                );
                              }

                              return const SizedBox.shrink();
                            },
                          ),
                          const SizedBox(height: 14),
                          InputField(
                            hint: 'Zip code',
                            controller: zipCodeController,
                            onChanged: (final value) {
                              setState(() {});
                            },
                          ),
                          const SizedBox(height: 25),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isDefault = !isDefault;
                                  });
                                },
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isDefault
                                        ? AppCustomColors.primaryColor
                                        : Colors.white,
                                    border: Border.all(
                                      color: Colors.grey.withOpacity(0.3),
                                      width: 1,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 13),
                              Text("Set as default", style: textStyle15w400),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: PrimaryButton(
                          title: 'Cancel',
                          hasBorder: true,
                          borderColor: AppCustomColors.primaryColor,
                          buttonColor: Colors.white,
                          textColor: Colors.black,
                          onPressed: () => Navigator.maybePop(context),
                        ),
                      ),
                      const SizedBox(width: 26),
                      Expanded(
                        child: PrimaryButton(
                          title: !widget.isEdit ? 'Save' : 'Update',
                          loading: state is ShippingLoading,
                          isEnabled: buttonEnabled(),
                          onPressed: buttonEnabled()
                              ? () {
                                  final cubit =
                                      BlocProvider.of<ShippingCubit>(context);

                                  if (widget.isEdit) {
                                    cubit.updateShippingAddress(
                                      address:
                                          '${addressController.text} ${subAddressController.text}',
                                      country: selectedCountry,
                                      isDefault: isDefault,
                                      name: nameController.text,
                                      phoneNumber: phoneNumberController.text,
                                      state: selectedState,
                                      zipCode: zipCodeController.text,
                                      shippingAddressId: widget
                                          .shippingAddress!.shippingAddressId,
                                    );
                                    return;
                                  }

                                  cubit.addShippingAddress(
                                    address:
                                        '${addressController.text} ${subAddressController.text}',
                                    country: selectedCountry,
                                    isDefault: isDefault,
                                    name: nameController.text,
                                    phoneNumber: phoneNumberController.text,
                                    state: selectedState,
                                    zipCode: zipCodeController.text,
                                  );
                                }
                              : null,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
