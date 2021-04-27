import 'dart:async';

import 'package:Metropolitane/FirebaseService/FirebaseService.dart';
import 'package:Metropolitane/model/AddAlarmModel.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_alarm_event.dart';

part 'add_alarm_state.dart';

class AddAlarmBloc extends Bloc<AddAlarmEvent, AddAlarmState> {
  FirebaseService _firebaseService = new FirebaseService();

  AddAlarmBloc() : super(AddAlarmInitial());

  @override
  Stream<AddAlarmState> mapEventToState(
    AddAlarmEvent event,
  ) async* {
    if (event is SavingAlarmDataToFirebaseEvent) {
      yield* _mapAdddAlarmToState(alarmModel: event.addAlarmModel);
    }

    // TODO: implement mapEventToState
  }

  Stream<AddAlarmState> _mapAdddAlarmToState(
      {AddAlarmModel alarmModel}) async* {
    yield AddAlarmLoading();
    try {
      var response = await _firebaseService.addAlarm(alarmModel);

      yield AddAlarmSuccessfullyPutdatastate(
          "Successfully Data Added To Server");
    } catch (e) {
      yield AddAlarmFailedToAddDataState(e.toString());
    }
  }
}
