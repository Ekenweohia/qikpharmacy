part of 'country_cubit.dart';

abstract class CountryState extends Equatable {
  const CountryState();

  @override
  List<Object> get props => [];
}

class CountryInitial extends CountryState {
  const CountryInitial();
}

class CountriesLoading extends CountryState {
  const CountriesLoading();
}

class CountriesLoaded extends CountryState {
  final List<Country> countries;
  const CountriesLoaded(this.countries);
}

class CountriesLoadingError extends CountryState {
  const CountriesLoadingError();
}
