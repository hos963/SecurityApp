
import 'package:Metropolitane/FirebaseService/FirebaseService.dart';
import 'package:Metropolitane/model/AddPatrolModel.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_patrol_event.dart';

part 'add_patrol_state.dart';

class AddPatrolBloc extends Bloc<AddPatrolEvent, AddPatrolState> {
  FirebaseService _firebaseService = new FirebaseService();

  AddPatrolBloc() : super(AddPatrolInitial());

  @override
  Stream<AddPatrolState> mapEventToState(
      AddPatrolEvent event,
      ) async* {
    if (event is SavingPatrolDataToFirebaseEvent) {
      yield* _mapAdddPatrolToState(patrolModel: event.addPatrolModel);
    }

    // TODO: implement mapEventToState
  }

  Stream<AddPatrolState> _mapAdddPatrolToState(
      {AddPatrolModel patrolModel}) async* {
    yield AddPatrolLoading();
    try {
      var response = await _firebaseService.addPatrol(patrolModel);

      yield AddPatrolSuccessfullyPutdatastate(
          "Successfully Data Added To Server");
    } catch (e) {
      yield AddPatrolFailedToAddDataState(e.toString());
    }
  }
}
