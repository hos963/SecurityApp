part of 'add_alarm_bloc.dart';

abstract class AddAlarmEvent extends Equatable {
  const AddAlarmEvent();
}

class SavingAlarmDataToFirebaseEvent extends AddAlarmEvent {
  final AddAlarmModel addAlarmModel;

  SavingAlarmDataToFirebaseEvent(this.addAlarmModel);

  @override
  List<Object> get props => [this.addAlarmModel];

  @override
  String toString() {
    return '{create user acocunt ${this.addAlarmModel.alrmTitle}}';
  }
}
