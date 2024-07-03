part of 'dod_cubit.dart';

abstract class DODState extends Equatable {
  const DODState();

  @override
  List<Object> get props => [];
}

class DODInitial extends DODState {
  const DODInitial();
}

class DODLoading extends DODState {
  const DODLoading();
}

class DODLoaded extends DODState {
  final List<Product> products;
  const DODLoaded(this.products);
}

class DODError extends DODState {
  const DODError();
}
