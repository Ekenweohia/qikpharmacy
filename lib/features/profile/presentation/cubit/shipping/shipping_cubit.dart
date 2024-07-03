import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qik_pharma_mobile/core/models/request/add_address.dart';
import 'package:qik_pharma_mobile/core/models/response/shipping_address.dart';
import 'package:qik_pharma_mobile/features/profile/repositories/shipping_repository_impl.dart';

part 'shipping_state.dart';

class ShippingCubit extends Cubit<ShippingState> {
  final ShippingRepositoryImpl _shippingRepository;
  ShippingCubit(this._shippingRepository) : super(const ShippingInitial());

  Future<void> getShippingAddress() async {
    emit(const ShippingDetailsLoading());

    final result = await _shippingRepository.getShippingAddress();

    if (result.isNotEmpty) {
      emit(ShippingDetailsLoaded(result));

      return;
    }

    emit(const ShippingDetailsError());
  }

  Future<void> addShippingAddress({
    String? address,
    String? country,
    String? state,
    String? phoneNumber,
    String? name,
    bool? isDefault,
    String? zipCode,
  }) async {
    emit(const ShippingLoading());

    AddAddressRequest request = AddAddressRequest(
      address: address,
      city: state,
      country: country,
      isDefault: isDefault,
      name: name,
      phoneNumber: phoneNumber,
      zipCode: zipCode,
    );
    final result = await _shippingRepository.addShippingAddress(request);

    if (result != null && result) {
      emit(const ShippingAddressAdded());

      Future.delayed(const Duration(seconds: 1), () {
        getShippingAddress();
      });
      return;
    }

    emit(const ShippingDetailsError());
  }

  Future<void> updateShippingAddress({
    String? address,
    String? country,
    String? state,
    String? phoneNumber,
    String? name,
    bool? isDefault,
    String? zipCode,
    String? shippingAddressId,
  }) async {
    emit(const ShippingLoading());

    AddAddressRequest request = AddAddressRequest(
      address: address,
      city: state,
      country: country,
      isDefault: isDefault,
      name: name,
      phoneNumber: phoneNumber,
      zipCode: zipCode,
    );
    final result = await _shippingRepository.updateShippingAddress(
      req: request,
      shippingAddressId: shippingAddressId!,
    );

    if (result != null && result) {
      emit(const ShippingAddressUpdated());

      Future.delayed(const Duration(seconds: 1), () {
        getShippingAddress();
      });
      return;
    }

    emit(const ShippingDetailsError());
  }

  Future<void> deleteShippingAddress({
    String? shippingAddressId,
  }) async {
    emit(const ShippingLoading());

    await _shippingRepository.deleteShippingAddress(
      shippingAddressId: shippingAddressId!,
    );

    getShippingAddress();
  }
}
