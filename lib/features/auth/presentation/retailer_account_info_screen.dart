import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qik_pharma_mobile/features/auth/presentation/account_under_review_screen.dart';
import 'package:qik_pharma_mobile/features/auth/presentation/cubit/country/country_cubit.dart';
import 'package:qik_pharma_mobile/features/auth/presentation/cubit/get_company_types/get_company_types_cubit.dart';
import 'package:qik_pharma_mobile/features/auth/presentation/cubit/get_medications/get_medications_cubit.dart';
import 'package:qik_pharma_mobile/features/auth/presentation/widgets/options_overlay.dart';
import 'package:qik_pharma_mobile/features/profile/presentation/cubit/user/user_cubit.dart';
import 'package:qik_pharma_mobile/shared/widgets/widgets.dart';
import 'package:qik_pharma_mobile/utils/qikpharma_navigator.dart';
import 'package:qik_pharma_mobile/utils/utils.dart';

class RetailerAccountInfoScreen extends StatefulWidget {
  const RetailerAccountInfoScreen({Key? key}) : super(key: key);

  @override
  State<RetailerAccountInfoScreen> createState() =>
      _RetailerAccountInfoScreenState();
}

class _RetailerAccountInfoScreenState extends State<RetailerAccountInfoScreen> {
  final _formKey = GlobalKey<FormState>();

  final companyNameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final nameController = TextEditingController();
  final registrationNumberController = TextEditingController();
  final businessTypeController = TextEditingController();

  String? selectedCountry;
  String? selectedState;
  String? companyType;
  String? medicationType;

  List<dynamic>? states = [];

  bool buttonEnabled() =>
      companyNameController.text.isNotEmpty &&
      addressController.text.isNotEmpty &&
      phoneNumberController.text.isNotEmpty &&
      nameController.text.isNotEmpty &&
      registrationNumberController.text.isNotEmpty &&
      businessTypeController.text.isNotEmpty &&
      selectedCountry != null &&
      selectedState != null &&
      companyType != null &&
      medicationType != null &&
      _formKey.currentState!.validate();

  @override
  void initState() {
    _getCountriesAndStates();
    _getCompanyTypes();
    _getMedications();
    super.initState();
  }

  void _getCountriesAndStates() async {
    final countryStateCubit = BlocProvider.of<CountryCubit>(context);
    countryStateCubit.getCountries();
  }

  void _getCompanyTypes() async {
    final getCompanyTypesCubit = BlocProvider.of<GetCompanyTypesCubit>(context);
    getCompanyTypesCubit.getCompanyTypes();
  }

  void _getMedications() async {
    final getMedicationsCubit = BlocProvider.of<GetMedicationsCubit>(context);
    getMedicationsCubit.getMedications();
  }

  void updateUserDetails() {
    final userCubit = BlocProvider.of<UserCubit>(context);

    userCubit.updateUserDetails(
      address: addressController.text,
      phoneNumber: phoneNumberController.text,
      country: selectedCountry,
      state: selectedState,
      // companyName: companyNameController.text,
      // companyType: companyType,
      // medicatonType: medicationType,
      name: nameController.text,
      // businessType: businessTypeController.text,
      // registrationNumber: registrationNumberController.text,
    );
  }

  void _gotoAccountUnderReviewScreen() {
    QikPharmaNavigator.pushReplacement(
      context,
      const AccountUnderReviewScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocConsumer<UserCubit, UserState>(
          listener: (context, state) {
            if (state is UserDetailsUpdated) {
              _gotoAccountUnderReviewScreen();
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Update Account Information",
                    style: textStyle24Bold.copyWith(
                        color: AppCustomColors.textBlue),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    "Company Information",
                    style: textStyle15w700PrimaryColor,
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    flex: 12,
                    child: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildRequiredFormInputField(
                              hint: 'Retailer\'s company name',
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Field cannot be empty.';
                                }

                                return null;
                              },
                              controller: companyNameController,
                            ),
                            const SizedBox(height: 24),
                            _buildRequiredFormInputField(
                              hint: 'Retailer\'s Address',
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Field cannot be empty.';
                                }

                                return null;
                              },
                              controller: addressController,
                            ),
                            const SizedBox(height: 24),
                            BlocBuilder<CountryCubit, CountryState>(
                              builder: (context, state) {
                                if (state is CountriesLoaded) {
                                  if (selectedCountry != null) {
                                    final selectedCountryStates = state
                                        .countries
                                        .where((e) =>
                                            e.name?.toLowerCase() ==
                                            selectedCountry?.toLowerCase())
                                        .toList();

                                    states = selectedCountryStates.isNotEmpty
                                        ? selectedCountryStates[0].state
                                        : [];
                                  }

                                  return Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "*",
                                              style: textStyle20BoldRed,
                                            ),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: OptionsOverlay(
                                                placeholderText:
                                                    'Select Country',
                                                options: state.countries,
                                                selectedOption: (value) {
                                                  setState(() {
                                                    selectedCountry =
                                                        value.name;
                                                  });
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      if (selectedCountry != null)
                                        const SizedBox(width: 24),
                                      if (selectedCountry != null)
                                        Expanded(
                                          flex: 2,
                                          child: OptionsOverlay(
                                            placeholderText: 'Select State',
                                            options: states ?? [],
                                            selectedOption: (value) {
                                              setState(() {
                                                selectedState = value.name;
                                              });
                                            },
                                          ),
                                        ),
                                    ],
                                  );
                                }

                                return const SizedBox.shrink();
                              },
                            ),
                            const SizedBox(height: 24),
                            _buildRequiredFormInputField(
                              hint: "Phone Number",
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Field cannot be empty.';
                                }

                                return null;
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              controller: phoneNumberController,
                            ),
                            const SizedBox(height: 39),
                            Text(
                              'Basic Information',
                              style: textStyle15w700PrimaryColor,
                            ),
                            const SizedBox(height: 24),
                            _buildRequiredFormInputField(
                              hint: 'Retailer\'s name',
                              validator: (value) {
                                if (!value!.isValidName) {
                                  return 'Missing a First or Last name';
                                }
                                return null;
                              },
                              controller: nameController,
                            ),
                            const SizedBox(height: 24),
                            _buildRequiredFormInputField(
                              hint: 'Business Registration No',
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Field cannot be empty.';
                                }
                                return null;
                              },
                              controller: registrationNumberController,
                            ),
                            const SizedBox(height: 40),
                            BlocBuilder<GetCompanyTypesCubit,
                                GetCompanyTypesState>(
                              builder: (context, state) {
                                if (state is CompaniesLoaded) {
                                  return Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "*",
                                        style: textStyle20BoldRed,
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: OptionsOverlay(
                                          placeholderText: 'Company type',
                                          options: state.companies,
                                          selectedOption: (value) {
                                            setState(() {
                                              companyType = value.name;
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                                }

                                return const SizedBox.shrink();
                              },
                            ),
                            const SizedBox(height: 24),
                            _buildRequiredFormInputField(
                              hint: 'Nature of business',
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Field cannot be empty.';
                                }
                                return null;
                              },
                              controller: businessTypeController,
                            ),
                            const SizedBox(height: 40),
                            BlocBuilder<GetMedicationsCubit,
                                GetMedicationsState>(
                              builder: (context, state) {
                                if (state is MedicationsLoaded) {
                                  return Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "*",
                                        style: textStyle20BoldRed,
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: OptionsOverlay(
                                          placeholderText:
                                              'Type of medications to be distributed',
                                          options: state.medications,
                                          selectedOption: (value) {
                                            setState(() {
                                              medicationType = value.name;
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                                }

                                return const SizedBox.shrink();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  PrimaryButton(
                    title: "CREATE ACCOUNT",
                    isEnabled: buttonEnabled(),
                    onPressed:
                        buttonEnabled() ? () => updateUserDetails() : null,
                    loading: state is UserLoading,
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildRequiredFormInputField({
    required String hint,
    String? Function(String?)? validator,
    required TextEditingController controller,
    inputFormatters,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "*",
          style: textStyle20BoldRed,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: InputField(
            hint: hint,
            label: hint,
            validator: validator,
            controller: controller,
            inputFormatters: inputFormatters,
            onChanged: (final value) {
              setState(() {});
            },
          ),
        ),
      ],
    );
  }
}
