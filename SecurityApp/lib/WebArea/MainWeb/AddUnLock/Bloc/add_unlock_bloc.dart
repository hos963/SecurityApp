import 'package:Metropolitane/FirebaseService/FirebaseService.dart';
import 'package:Metropolitane/model/AddUnlockModel.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_unlock_event.dart';
part 'add_unlock_state.dart';

class AddUnLockBloc extends Bloc<AddUnLockEvent, AddUnLockState> {
  FirebaseService _firebaseService = new FirebaseService();

  AddUnLockBloc() : super(AddUnLockInitial());

  @override
  Stream<AddUnLockState> mapEventToState(
      AddUnLockEvent event,
      ) async* {
    if (event is SavingUnLockDataToFirebaseEvent) {
      yield* _mapAdddUnLockToState(unlockModel: event.addUnlockModel);
    }

    // TODO: implement mapEventToState
  }

  Stream<AddUnLockState> _mapAdddUnLockToState(
      {AddUnlockModel unlockModel}) async* {
    yield AddUnLockLoading();
    try {
      var response = await _firebaseService.addUnLock(unlockModel);

      yield AddUnLockSuccessfullyPutdatastate(
          "Successfully Data Added To Server");
    } catch (e) {
      yield AddUnLockFailedToAddDataState(e.toString());
    }
  }
}
