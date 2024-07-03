part of 'logistics_cubit.dart';

abstract class LogisticsState extends Equatable {
  const LogisticsState();

  @override
  List<Object> get props => [];

  List<Logistics>? get logistics => [];
}

class LogisticsInitial extends LogisticsState {
  const LogisticsInitial();
}

class LogisticsLoading extends LogisticsState {
  const LogisticsLoading();
}

class LogisticsLoaded extends LogisticsState {
  @override
  final List<Logistics> logistics;
  const LogisticsLoaded(this.logistics);
}

class LogisticsError extends LogisticsState {
  const LogisticsError();
}
