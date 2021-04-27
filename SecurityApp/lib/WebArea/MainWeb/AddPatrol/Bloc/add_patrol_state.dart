part of 'add_patrol_bloc.dart';

abstract class AddPatrolState extends Equatable {
  const AddPatrolState();
  @override
  List<Object> get props => [];
}

class AddPatrolInitial extends AddPatrolState {
  @override
  List<Object> get props => [];
  @override
  String toString() => 'Uninitialized';
}


class AddPatrolLoading extends AddPatrolState {
  @override
  String toString() => 'Loading';
}

class AddPatrolSuccessfullyPutdatastate extends AddPatrolState {
  final String successmsg;

  const AddPatrolSuccessfullyPutdatastate(this.successmsg);

  @override
  String toString() => 'Authenticated { display data: $successmsg }';
}

class AddPatrolFailedToAddDataState extends AddPatrolState {
  final String errorstr;

  const AddPatrolFailedToAddDataState(this.errorstr);

  @override
  String toString() => 'Authenticated { display data: $errorstr }';
}
