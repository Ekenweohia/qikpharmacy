part of 'onboarding_cubit.dart';

abstract class OnboardingState extends Equatable {
  const OnboardingState();

  @override
  List<Object> get props => [];

  get currentPageValue => 0;
}

class OnboardingInitial extends OnboardingState {
  @override
  final double currentPageValue;
  const OnboardingInitial(this.currentPageValue);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OnboardingInitial &&
        other.currentPageValue == currentPageValue;
  }

  @override
  int get hashCode => currentPageValue.hashCode;
}

class OnboardingPageChanged extends OnboardingState {
  @override
  final double currentPageValue;
  const OnboardingPageChanged(this.currentPageValue);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OnboardingPageChanged &&
        other.currentPageValue == currentPageValue;
  }

  @override
  int get hashCode => currentPageValue.hashCode;
}
