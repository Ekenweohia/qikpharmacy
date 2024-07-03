part of 'region_cubit.dart';

abstract class RegionState extends Equatable {
  const RegionState();

  @override
  List<Object> get props => [];
}

class RegionInitial extends RegionState {
  const RegionInitial();
}

class RegionLoading extends RegionState {
  const RegionLoading();
}

class RegionsLoaded extends RegionState {
  final List<Region> regions;
  const RegionsLoaded(this.regions);
}

class RegionGetError extends RegionState {
  const RegionGetError();
}
