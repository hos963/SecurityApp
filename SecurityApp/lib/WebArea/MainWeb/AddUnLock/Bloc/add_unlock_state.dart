
part of 'add_unlock_bloc.dart';

abstract class AddUnLockState extends Equatable {
  const AddUnLockState();
  @override
  List<Object> get props => [];
}

class AddUnLockInitial extends AddUnLockState {
  @override
  List<Object> get props => [];
  @override
  String toString() => 'Uninitialized';
}


class AddUnLockLoading extends AddUnLockState {
  @override
  String toString() => 'Loading';
}

class AddUnLockSuccessfullyPutdatastate extends AddUnLockState {
  final String successmsg;

  const AddUnLockSuccessfullyPutdatastate(this.successmsg);

  @override
  String toString() => 'Authenticated { display data: $successmsg }';
}

class AddUnLockFailedToAddDataState extends AddUnLockState {
  final String errorstr;

  const AddUnLockFailedToAddDataState(this.errorstr);

  @override
  String toString() => 'Authenticated { display data: $errorstr }';
}
