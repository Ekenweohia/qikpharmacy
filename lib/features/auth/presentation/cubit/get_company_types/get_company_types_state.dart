part of 'get_company_types_cubit.dart';

abstract class GetCompanyTypesState extends Equatable {
  const GetCompanyTypesState();

  @override
  List<Object> get props => [];
}

class GetCompanyTypesStateInitial extends GetCompanyTypesState {
  const GetCompanyTypesStateInitial();
}

class CompanyTypesLoading extends GetCompanyTypesState {
  const CompanyTypesLoading();
}

class CompaniesLoaded extends GetCompanyTypesState {
  final List<CompanyType> companies;
  const CompaniesLoaded(this.companies);
}

class CompaniesLoadingError extends GetCompanyTypesState {
  const CompaniesLoadingError();
}
