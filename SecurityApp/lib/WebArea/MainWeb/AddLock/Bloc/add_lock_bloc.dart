import 'package:Metropolitane/FirebaseService/FirebaseService.dart';
import 'package:Metropolitane/model/AddLockModel.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_lock_state.dart';
part 'add_lock_event.dart';

class AddLockBloc extends Bloc<AddLockEvent, AddLockState> {
  FirebaseService _firebaseService = new FirebaseService();

  AddLockBloc() : super(AddLockInitial());

  @override
  Stream<AddLockState> mapEventToState(
      AddLockEvent event,
      ) async* {
    if (event is SavingLockDataToFirebaseEvent) {
      yield* _mapAdddLockToState(lockModel: event.addLockModel);
    }

    // TODO: implement mapEventToState
  }

  Stream<AddLockState> _mapAdddLockToState(
      {AddLockModel lockModel}) async* {
    yield AddLockLoading();
    try {
      var response = await _firebaseService.addLock(lockModel);

      yield AddLockSuccessfullyPutdatastate(
          "Successfully Data Added To Server");
    } catch (e) {
      yield AddLockFailedToAddDataState(e.toString());
    }
  }
}
