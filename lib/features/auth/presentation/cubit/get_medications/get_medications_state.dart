part of 'get_medications_cubit.dart';

abstract class GetMedicationsState extends Equatable {
  const GetMedicationsState();

  @override
  List<Object> get props => [];
}

class GetMedicationsStateInitial extends GetMedicationsState {
  const GetMedicationsStateInitial();
}

class MedicationsLoading extends GetMedicationsState {
  const MedicationsLoading();
}

class MedicationsLoaded extends GetMedicationsState {
  final List<Medications> medications;
  const MedicationsLoaded(this.medications);
}

class MedicationsLoadingError extends GetMedicationsState {
  const MedicationsLoadingError();
}
