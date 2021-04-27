part of 'add_alarm_bloc.dart';

abstract class AddAlarmState extends Equatable {
  const AddAlarmState();
  @override
  List<Object> get props => [];
}

class AddAlarmInitial extends AddAlarmState {
  @override
  List<Object> get props => [];
  @override
  String toString() => 'Uninitialized';
}


class AddAlarmLoading extends AddAlarmState {
  @override
  String toString() => 'Loading';
}

class AddAlarmSuccessfullyPutdatastate extends AddAlarmState {
  final String successmsg;

  const AddAlarmSuccessfullyPutdatastate(this.successmsg);

  @override
  String toString() => 'Authenticated { display data: $successmsg }';
}

class AddAlarmFailedToAddDataState extends AddAlarmState {
  final String errorstr;

  const AddAlarmFailedToAddDataState(this.errorstr);

  @override
  String toString() => 'Authenticated { display data: $errorstr }';
}
