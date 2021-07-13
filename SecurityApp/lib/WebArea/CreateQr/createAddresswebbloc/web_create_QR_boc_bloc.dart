
import 'package:Metropolitane/FirebaseService/FirebaseService.dart';
import 'package:Metropolitane/ServicesPage/Repository.dart';
import 'package:Metropolitane/model/AddQRModel.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'web_create_QR_boc_event.dart';
part 'web_create_QR_boc_state.dart';

class WebCreateQRBocBloc extends Bloc<WebCreateAddressBocEvent, WebCreateAddressBocState> {

  Repository _repository = Repository();
  bool isactiveuser = true;
  FirebaseService _firebaseService = new FirebaseService();

  List<AddQRModel> listfb ;

  WebCreateQRBocBloc() : super(WebCreateAddressBocInitial());


  @override
  Stream<WebCreateAddressBocState> mapEventToState(
      WebCreateAddressBocEvent event,) async* {
    if (event is CreateAddressEvent) {
      yield* _mapAdddressSavePressedToState(
          addQRModel: event.addQRModel);
    }

    if (event is getAddresseslistevetn) {
      yield* _mapgetListLocationsToState();
    }

    if (event is DeleteUserAdress) {
      yield* _mapdeleteaddressToState(event.addQRModel);
    }
  }

  Stream<WebCreateAddressBocState> _mapAdddressSavePressedToState(
      {AddQRModel addQRModel}) async* {
    yield WebCreateAddressMainLoading();
    try {
      var response = _firebaseService.AddingQRData(addQRModel);

      if (response != null) {
        yield SuccessfullyCreatedAddressstate(
            "Successfully Created" + response.toString());
      add(getAddresseslistevetn());
      } else {
        yield FailedToCreateAddress("Server Error");
      }
    } catch (e) {
      yield FailedToCreateAddress(e.toString());
    }
  }


  Stream<WebCreateAddressBocState> _mapgetListLocationsToState() async* {
    //  yield WebMainLoading();
    try {
      var response = await _firebaseService.gettingAllQrList();

      if (response.isNotEmpty) {
        if(listfb != null && listfb.length > 0){

          listfb.clear();
        }


        listfb = response;


      }

      if (response != null) {
        yield gettingCreateAddresslistdatastate();
      } else {
        yield FailedToCreateAddress("Server Error");
      }
    } catch (e) {
      yield FailedToCreateAddress(e.toString());
    }
  }



  Stream<WebCreateAddressBocState> _mapdeleteaddressToState(AddQRModel addQRModel) async* {
    yield WebCreateAddressMainLoading();
    try {

      var response = await _firebaseService.deleteQr(addQRModel);
      listfb.remove(addQRModel);

      yield gettingCreateAddresslistdatastate();

    } catch (e) {
      yield FailedToCreateAddress(e.toString());
    }
  }

}