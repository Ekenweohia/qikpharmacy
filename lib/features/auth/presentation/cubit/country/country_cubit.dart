import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qik_pharma_mobile/core/models/response/country.dart';
import 'package:qik_pharma_mobile/features/auth/repository/info_repository.dart';

part 'country_state.dart';

class CountryCubit extends Cubit<CountryState> {
  final InfoRepositoryImpl _countryRepository;

  CountryCubit(this._countryRepository) : super(const CountryInitial());

  Future<void> getCountries() async {
    emit(const CountriesLoading());

    final List<Country> countries = await _countryRepository.getCountries();
    if (countries.isNotEmpty) {
      emit(CountriesLoaded(countries));
      return;
    }

    emit(const CountriesLoadingError());
  }
}
