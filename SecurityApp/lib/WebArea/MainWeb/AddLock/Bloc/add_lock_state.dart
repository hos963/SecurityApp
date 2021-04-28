
part of 'add_lock_bloc.dart';

abstract class AddLockState extends Equatable {
  const AddLockState();
  @override
  List<Object> get props => [];
}

class AddLockInitial extends AddLockState {
  @override
  List<Object> get props => [];
  @override
  String toString() => 'Uninitialized';
}


class AddLockLoading extends AddLockState {
  @override
  String toString() => 'Loading';
}

class AddLockSuccessfullyPutdatastate extends AddLockState {
  final String successmsg;

  const AddLockSuccessfullyPutdatastate(this.successmsg);

  @override
  String toString() => 'Authenticated { display data: $successmsg }';
}

class AddLockFailedToAddDataState extends AddLockState {
  final String errorstr;

  const AddLockFailedToAddDataState(this.errorstr);

  @override
  String toString() => 'Authenticated { display data: $errorstr }';
}
