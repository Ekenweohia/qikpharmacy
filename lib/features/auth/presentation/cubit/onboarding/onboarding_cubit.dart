import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qik_pharma_mobile/barrels/repositories.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final UserRepositoryImpl userRepository;

  OnboardingCubit(this.userRepository) : super(const OnboardingInitial(0));

  void pageChanged(value) {
    emit(OnboardingPageChanged(value));
    return;
  }

  void setInit() => userRepository.setInit();
}
