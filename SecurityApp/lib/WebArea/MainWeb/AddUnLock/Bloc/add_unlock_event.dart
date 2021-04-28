

part of 'add_unlock_bloc.dart';


abstract class AddUnLockEvent extends Equatable {
  const AddUnLockEvent();
}

class SavingUnLockDataToFirebaseEvent extends AddUnLockEvent {
  final AddUnlockModel addUnlockModel;

  SavingUnLockDataToFirebaseEvent(this.addUnlockModel);

  @override
  List<Object> get props => [this.addUnlockModel];

  @override
  String toString() {
    return '{create user acocunt ${this.addUnlockModel.unlockTitle}}';
  }
}
