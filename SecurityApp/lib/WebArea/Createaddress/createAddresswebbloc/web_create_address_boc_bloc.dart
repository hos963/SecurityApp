import 'dart:async';

import 'package:Metropolitane/FirebaseService/FirebaseService.dart';
import 'package:Metropolitane/ServicesPage/Repository.dart';
import 'package:Metropolitane/model/AddressAlarmModel.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'web_create_address_boc_event.dart';
part 'web_create_address_boc_state.dart';

class WebCreateAddressBocBloc extends Bloc<WebCreateAddressBocEvent, WebCreateAddressBocState> {

  Repository _repository = Repository();
  bool isactiveuser = true;
  FirebaseService _firebaseService = new FirebaseService();

  List<AddressAlarmModel> listfb ;

  WebCreateAddressBocBloc() : super(WebCreateAddressBocInitial());


  @override
  Stream<WebCreateAddressBocState> mapEventToState(
      WebCreateAddressBocEvent event,) async* {
    if (event is CreateAddressEvent) {
      yield* _mapAdddressSavePressedToState(
          addressAlarmModel: event.addressAlarmModel);
    }

    if (event is getAddresseslistevetn) {
      yield* _mapgetListLocationsToState();
    }

    if (event is DeleteUserAdress) {
      yield* _mapdeleteaddressToState(event.userdata);
    }
  }

  Stream<WebCreateAddressBocState> _mapAdddressSavePressedToState(
      {AddressAlarmModel addressAlarmModel}) async* {
    yield WebCreateAddressMainLoading();
    try {
      var response = _firebaseService.AddingAddressData(addressAlarmModel);

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
      var response = await _firebaseService.gettingAllLocationsData();

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



  Stream<WebCreateAddressBocState> _mapdeleteaddressToState(AddressAlarmModel addressAlarmModel) async* {
    yield WebCreateAddressMainLoading();
    try {


      var response = await _firebaseService.deleteAddress(addressAlarmModel);
      listfb.remove(addressAlarmModel);

      yield gettingCreateAddresslistdatastate();

    } catch (e) {
      yield FailedToCreateAddress(e.toString());
    }
  }

}