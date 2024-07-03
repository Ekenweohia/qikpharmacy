import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qik_pharma_mobile/core/models/response/company_type.dart';
import 'package:qik_pharma_mobile/features/auth/repository/info_repository.dart';

part 'get_company_types_state.dart';

class GetCompanyTypesCubit extends Cubit<GetCompanyTypesState> {
  final InfoRepositoryImpl _infoRepositoryImpl;

  GetCompanyTypesCubit(this._infoRepositoryImpl)
      : super(const GetCompanyTypesStateInitial());

  Future<void> getCompanyTypes() async {
    emit(const CompanyTypesLoading());

    final companies = await _infoRepositoryImpl.getCompanyTypes();
    if (companies.isNotEmpty) {
      emit(CompaniesLoaded(companies));
      return;
    }

    emit(const CompaniesLoadingError());
  }
}
