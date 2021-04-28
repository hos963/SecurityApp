

part of 'add_lock_bloc.dart';

abstract class AddLockEvent extends Equatable {
  const AddLockEvent();
}

class SavingLockDataToFirebaseEvent extends AddLockEvent {
  final AddLockModel addLockModel;

  SavingLockDataToFirebaseEvent(this.addLockModel);

  @override
  List<Object> get props => [this.addLockModel];

  @override
  String toString() {
    return '{create user acocunt ${this.addLockModel.lockTitle}}';
  }
}
