import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qik_pharma_mobile/core/models/response/medications.dart';
import 'package:qik_pharma_mobile/features/auth/repository/info_repository.dart';

part 'get_medications_state.dart';

class GetMedicationsCubit extends Cubit<GetMedicationsState> {
  final InfoRepositoryImpl _countryRepository;

  GetMedicationsCubit(this._countryRepository)
      : super(const GetMedicationsStateInitial());

  Future<void> getMedications() async {
    emit(const MedicationsLoading());

    final result = await _countryRepository.getMedications();
    if (result.isNotEmpty) {
      emit(MedicationsLoaded(result));
      return;
    }

    emit(const MedicationsLoadingError());
  }
}
