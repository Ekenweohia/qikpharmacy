import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qik_pharma_mobile/core/models/response/logistics.dart';
import 'package:qik_pharma_mobile/features/cart/repository/cart_repository_impl.dart';

part 'logistics_state.dart';

class LogisticsCubit extends Cubit<LogisticsState> {
  final CartRepositoryImpl _cartRepository;

  LogisticsCubit(this._cartRepository) : super(const LogisticsInitial());

  Future<void> getLogistics() async {
    emit(const LogisticsLoading());

    final result = await _cartRepository.getLogistics();

    if (result.isNotEmpty) {
      emit(LogisticsLoaded(result));

      return;
    }

    emit(const LogisticsError());
  }
}
