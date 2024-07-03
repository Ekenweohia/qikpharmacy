import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qik_pharma_mobile/core/models/response/single_country.dart';
import 'package:qik_pharma_mobile/features/auth/presentation/welcome.dart';
import 'package:qik_pharma_mobile/features/splash/cubit/splash_cubit.dart';
import 'package:qik_pharma_mobile/shared/widgets/widgets.dart';
import 'package:qik_pharma_mobile/utils/colors.dart';
import 'package:qik_pharma_mobile/utils/qikpharma_navigator.dart';
import 'package:qik_pharma_mobile/utils/text_styles.dart';

class CountrySelectionScreen extends StatefulWidget {
  final List<SingleCountry> countries;

  const CountrySelectionScreen({Key? key, required this.countries})
      : super(key: key);

  @override
  State<CountrySelectionScreen> createState() => _CountrySelectionScreenState();
}

class _CountrySelectionScreenState extends State<CountrySelectionScreen> {
  List<SingleCountry> countries = [];
  SingleCountry selectedCountry = SingleCountry();

  bool buttonEnabled() => selectedCountry.id != null;

  @override
  void initState() {
    super.initState();

    setState(() {
      countries = [...widget.countries];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocConsumer<SplashCubit, SplashState>(
          listener: (context, state) {
            if (state is SplashLoaded) {
              QikPharmaNavigator.pushReplacement(
                  context, const WelcomeScreen());
            }
          },
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Center(
                  child: Image.asset(
                    "assets/images/logo.png",
                    scale: 4,
                  ),
                ),
                const SizedBox(height: 55),
                Text(
                  'Select Country',
                  style: textStyle20.copyWith(
                    fontSize: 23,
                    fontWeight: FontWeight.w600,
                    color: AppCustomColors.textBlue,
                  ),
                ),
                const SizedBox(height: 35),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 44),
                  child: Column(
                    children: List.generate(
                      countries.length,
                      (index) {
                        final item = countries[index];

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCountry = item;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 29),
                            child: Row(
                              children: [
                                item.countryFlagPath != null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: Image.network(
                                          item.countryFlagPath!,
                                          height: 24,
                                          width: 24,
                                          errorBuilder: (context, error,
                                                  stackTrace) =>
                                              const Icon(Icons.flag_outlined),
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                                const SizedBox(width: 13),
                                Expanded(
                                  child: Text(
                                    item.countryName ?? '',
                                    style: textStyle17w500Black.copyWith(
                                      color: Colors.black.withOpacity(.45),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: selectedCountry.id == item.id
                                        ? AppCustomColors.primaryColor
                                        : Colors.white,
                                    border: Border.all(
                                      color: AppCustomColors
                                          .nonActiveProgressColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const Spacer(),
                PrimaryButton(
                  width: 300,
                  title: 'CONTINUE',
                  isEnabled: buttonEnabled(),
                  onPressed: buttonEnabled()
                      ? () {
                          final cubit = BlocProvider.of<SplashCubit>(context);
                          cubit.setBaseParameters(selectedCountry);
                        }
                      : null,
                  loading: state is SplashLoading,
                ),
                const Spacer(),
              ],
            );
          },
        ),
      ),
    );
  }
}
