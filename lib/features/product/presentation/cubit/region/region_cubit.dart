import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qik_pharma_mobile/core/models/response/region.dart';
import 'package:qik_pharma_mobile/features/orders/repositories/region_repository.dart';

part 'region_state.dart';

class RegionCubit extends Cubit<RegionState> {
  final RegionRepositoryImpl _regionService;

  RegionCubit(this._regionService) : super(const RegionInitial());

  void getAllRegions() async {
    emit(const RegionLoading());

    List<Region> regions = await _regionService.getAllRegions();

    emit(RegionsLoaded(regions));
  }
}
