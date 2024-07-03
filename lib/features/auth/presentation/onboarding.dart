import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qik_pharma_mobile/features/auth/presentation/cubit/onboarding/onboarding_cubit.dart';
import 'package:qik_pharma_mobile/features/splash/splash_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../utils/utils.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController controller = PageController();

  @override
  void initState() {
    controller.addListener(() {
      final onboardingCubit = BlocProvider.of<OnboardingCubit>(context);
      onboardingCubit.pageChanged(controller.page!);
    });
    super.initState();
  }

  void _navigate() {
    final cubit = BlocProvider.of<OnboardingCubit>(context);
    cubit.setInit();
    Navigator.pushReplacement(
      context,
      PageTransition(
        duration: const Duration(milliseconds: 1000),
        type: PageTransitionType.rightToLeftWithFade,
        child: const SplashScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      minimum: const EdgeInsets.only(top: 67),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: PageView(
              controller: controller,
              children: <Widget>[
                _buildOnboardingPage(
                  title: "View and buy Verified Drugs",
                  description:
                      "qikPharma provides an easy, assesible and convenient way to buy verified drugs ",
                  imagePath: "assets/images/onboarding1.png",
                  isLeft: false,
                ),
                _buildOnboardingPage(
                  title: "Get Delivery on time",
                  description:
                      "Get nationwide delivery from orders made on qikPharma with our logistics",
                  imagePath: "assets/images/onboarding2.png",
                  isLeft: true,
                ),
                _buildOnboardingPage(
                  title: "Connects verified pharmaciticals in Africa",
                  description:
                      "qikPharma provides a connections between pharmacitical supply chain accross Africa.",
                  imagePath: "assets/images/onboarding3.png",
                  isLeft: false,
                ),
                _buildOnboardingPage(
                  title: "Become a Trusted Pharma",
                  description:
                      "Join our fast growing verified pharma vendors nation-wide, fast and easy steps",
                  imagePath: "assets/images/onboarding4.png",
                  isLeft: true,
                ),
              ],
            ),
          ),
          _buildBottomWidgets(),
        ],
      ),
    );
  }

  Widget _buildBottomWidgets() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: BlocBuilder<OnboardingCubit, OnboardingState>(
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (state.currentPageValue != 3)
                TextButton(
                  onPressed: () => controller.animateToPage(
                    3,
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.bounceInOut,
                  ),
                  child: Text(
                    "Skip",
                    style: textStyle15w400.copyWith(
                      color: AppCustomColors.textBlue.withOpacity(.45),
                    ),
                  ),
                ),
              _buildPageIndicator(),
              TextButton(
                onPressed: state.currentPageValue == 3
                    ? _navigate
                    : () => controller.animateToPage(
                          state.currentPageValue.toInt() + 1,
                          duration: const Duration(milliseconds: 350),
                          curve: Curves.bounceInOut,
                        ),
                child: Text(
                  state.currentPageValue == 3 ? "Get Started" : "Next",
                  style: textStyle15w700.copyWith(
                    color: AppCustomColors.primaryColor,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildOnboardingPage({
    required String title,
    required String description,
    required String imagePath,
    required bool isLeft,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
          child: Text(
            title,
            style: textStyle24Bold.copyWith(
              fontSize: 23,
              fontWeight: FontWeight.w600,
              color: AppCustomColors.textBlue,
            ),
          ),
        ),
        const SizedBox(height: 11),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Text(
            description,
            style: textStyle17w300.copyWith(
              color: AppCustomColors.textBlue.withOpacity(.45),
            ),
          ),
        ),
        const SizedBox(height: 30),
        Expanded(
          child: Row(
            mainAxisAlignment:
                isLeft ? MainAxisAlignment.start : MainAxisAlignment.end,
            children: [
              Image.asset(imagePath),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPageIndicator() {
    return SmoothPageIndicator(
      controller: controller,
      count: 4,
      effect: ExpandingDotsEffect(
        dotHeight: 4,
        dotWidth: 4,
        dotColor: Colors.grey.withOpacity(.45),
        activeDotColor: AppCustomColors.primaryColor,
        spacing: 8,
        expansionFactor: 2,
      ),
    );
  }
}
