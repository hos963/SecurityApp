part of 'add_patrol_bloc.dart';

abstract class AddPatrolEvent extends Equatable {
  const AddPatrolEvent();
}

class SavingPatrolDataToFirebaseEvent extends AddPatrolEvent {
  final AddPatrolModel addPatrolModel;

  SavingPatrolDataToFirebaseEvent(this.addPatrolModel);

  @override
  List<Object> get props => [this.addPatrolModel];

  @override
  String toString() {
    return '{create user acocunt ${this.addPatrolModel.patrolTitle}}';
  }
}
