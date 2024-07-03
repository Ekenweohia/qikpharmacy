part of 'user_product_cubit.dart';

abstract class UserProductState extends Equatable {
  const UserProductState();

  @override
  List<Object> get props => [];
}

class UserProductInitial extends UserProductState {
  const UserProductInitial();
}

class UserProductLoading extends UserProductState {
  const UserProductLoading();
}

class UserProductLoaded extends UserProductState {
  final List<Product> products;
  const UserProductLoaded(this.products);
}

class UserProductError extends UserProductState {
  const UserProductError();
}

class UserProductCreated extends UserProductState {
  const UserProductCreated();
}

class UserProductDeleted extends UserProductState {
  const UserProductDeleted();
}
