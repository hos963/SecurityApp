part of 'add_inspection_bloc.dart';


abstract class AddPropertyInspectionEvent extends Equatable {
  const AddPropertyInspectionEvent();
}

class SavingInspectionDataToFirebaseEvent extends AddPropertyInspectionEvent {
  final AddPropertyInspectionModel addPropertyInspectionModel;

  SavingInspectionDataToFirebaseEvent(this.addPropertyInspectionModel);

  @override
  List<Object> get props => [this.addPropertyInspectionModel];

  @override
  String toString() {
    return '{create user acocunt ${this.addPropertyInspectionModel.inspectionTitle}}';
  }
}
