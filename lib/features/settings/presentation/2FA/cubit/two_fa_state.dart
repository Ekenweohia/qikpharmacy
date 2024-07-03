part of 'two_fa_cubit.dart';

abstract class SetUpTwoFaState extends Equatable {
  const SetUpTwoFaState();

  @override
  List<Object> get props => [];
}

class SetUpTwoFaInitial extends SetUpTwoFaState {
  const SetUpTwoFaInitial();
}

class SetUpTwoFaLoading extends SetUpTwoFaState {
  const SetUpTwoFaLoading();
}

class SetupTwoFa extends SetUpTwoFaState {
  final ToggleFA result;

  const SetupTwoFa(this.result);
}

class TwoFaDisabled extends SetUpTwoFaState {
  const TwoFaDisabled();
}

// Confirm two FA
abstract class ConfirmTwoFaState extends Equatable {
  const ConfirmTwoFaState();

  @override
  List<Object> get props => [];
}

class ConfirmTwoFaInitial extends ConfirmTwoFaState {
  const ConfirmTwoFaInitial();
}

class ConfirmTwoFaLoading extends ConfirmTwoFaState {
  const ConfirmTwoFaLoading();
}

class TwoFaEnabled extends ConfirmTwoFaState {
  const TwoFaEnabled();
}

class ConfirmTwoFaError extends ConfirmTwoFaState {
  const ConfirmTwoFaError();
}
