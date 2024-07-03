import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qik_pharma_mobile/core/models/request/checkout_payload.dart';
import 'package:qik_pharma_mobile/core/repositories/repositories.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  final CheckoutRepositoryImpl _cartRepository;

  CheckoutCubit(this._cartRepository) : super(const CheckoutInitial());

  Future<void> call(
    BuildContext context, {
    required CheckoutPayload payload,
  }) async {
    emit(const CheckoutLoading());

    final result = await _cartRepository.handleCheckout(context, payload);
    if (result != null && result) {
      emit(CheckoutSuccessful(result));
    } else {
      const CheckoutError('An error occured!');
    }
  }
}
