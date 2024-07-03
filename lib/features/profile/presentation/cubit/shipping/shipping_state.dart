part of 'shipping_cubit.dart';

abstract class ShippingState extends Equatable {
  const ShippingState();

  @override
  List<Object> get props => [];
}

class ShippingInitial extends ShippingState {
  const ShippingInitial();
}

class ShippingDetailsLoading extends ShippingState {
  const ShippingDetailsLoading();
}

class ShippingDetailsLoaded extends ShippingState {
  final List<ShippingAddress> shippingDetails;
  const ShippingDetailsLoaded(this.shippingDetails);
}

class ShippingAddressAdded extends ShippingState {
  const ShippingAddressAdded();
}

class ShippingAddressUpdated extends ShippingState {
  const ShippingAddressUpdated();
}

class ShippingLoading extends ShippingState {
  const ShippingLoading();
}

class ShippingAddressDeleted extends ShippingState {
  const ShippingAddressDeleted();
}

class ShippingDetailsError extends ShippingState {
  const ShippingDetailsError();
}
