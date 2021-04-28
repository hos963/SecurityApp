part of 'add_inspection_bloc.dart';

abstract class AddPropertyInspectionState extends Equatable {
  const AddPropertyInspectionState();
  @override
  List<Object> get props => [];
}

class AddPropertyInspectionInitial extends AddPropertyInspectionState {
  @override
  List<Object> get props => [];
  @override
  String toString() => 'Uninitialized';
}


class AddPropertyInspectionLoading extends AddPropertyInspectionState {
  @override
  String toString() => 'Loading';
}

class AddPropertyInspectionSuccessfullyPutdatastate extends AddPropertyInspectionState {
  final String successmsg;

  const AddPropertyInspectionSuccessfullyPutdatastate(this.successmsg);

  @override
  String toString() => 'Authenticated { display data: $successmsg }';
}

class AddPropertyInspectionFailedToAddDataState extends AddPropertyInspectionState {
  final String errorstr;

  const AddPropertyInspectionFailedToAddDataState(this.errorstr);

  @override
  String toString() => 'Authenticated { display data: $errorstr }';
}
