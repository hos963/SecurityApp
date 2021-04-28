
import 'package:Metropolitane/FirebaseService/FirebaseService.dart';
import 'package:Metropolitane/model/AddPatrolModel.dart';
import 'package:Metropolitane/model/AddPropertyInspectionModel.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_inspection_event.dart';

part 'add_inspection_state.dart';

class AddPropertyInspectionBloc extends Bloc<AddPropertyInspectionEvent, AddPropertyInspectionState> {
  FirebaseService _firebaseService = new FirebaseService();

  AddPropertyInspectionBloc() : super(AddPropertyInspectionInitial());

  @override
  Stream<AddPropertyInspectionState> mapEventToState(
      AddPropertyInspectionEvent event,
      ) async* {
    if (event is SavingInspectionDataToFirebaseEvent) {
      yield* _mapAdddPropertyInspectionToState(addPropertyInspectionModel: event.addPropertyInspectionModel);
    }

    // TODO: implement mapEventToState
  }

  Stream<AddPropertyInspectionState> _mapAdddPropertyInspectionToState(
      {AddPropertyInspectionModel addPropertyInspectionModel}) async* {
    yield AddPropertyInspectionLoading();
    try {
      var response = await _firebaseService.addInspection(addPropertyInspectionModel);

      yield AddPropertyInspectionSuccessfullyPutdatastate(
          "Successfully Data Added To Server");
    } catch (e) {
      yield AddPropertyInspectionFailedToAddDataState(e.toString());
    }
  }
}
