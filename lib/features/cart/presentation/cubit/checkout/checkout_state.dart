part of 'checkout_cubit.dart';

abstract class CheckoutState extends Equatable {
  const CheckoutState();

  @override
  List<Object> get props => [];

  bool? get result => null;
}

class CheckoutInitial extends CheckoutState {
  const CheckoutInitial();
}

class CheckoutLoading extends CheckoutState {
  const CheckoutLoading();
}

class CheckoutSuccessful extends CheckoutState {
  @override
  final bool result;
  const CheckoutSuccessful(this.result);
}

class CheckoutError extends CheckoutState {
  final String message;
  const CheckoutError(this.message);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CheckoutError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
