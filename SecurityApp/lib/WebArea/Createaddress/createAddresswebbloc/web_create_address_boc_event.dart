part of 'web_create_address_boc_bloc.dart';

abstract class WebCreateAddressBocEvent extends Equatable {
  const WebCreateAddressBocEvent();


  List<Object> get props => [];
}

class CreateAddressEvent extends WebCreateAddressBocEvent {
  final AddressAlarmModel addressAlarmModel;

  CreateAddressEvent(this.addressAlarmModel);

  @override
  List<Object> get props => [this.addressAlarmModel];

  @override
  String toString() {
    return '{create user acocunt ${this.addressAlarmModel.locationName}}';
  }
}

class getAddresseslistevetn extends WebCreateAddressBocEvent {
  getAddresseslistevetn();

  @override
  List<Object> get props => [];

  @override
  String toString() {
    return '{create user acocunt }';
  }
}

class DeleteUserAdress extends WebCreateAddressBocEvent {
  final AddressAlarmModel userdata;

  DeleteUserAdress(this.userdata);

  @override
  List<Object> get props => [this.userdata];

  @override
  String toString() {
    return '{create user acocunt ${this.userdata.locationName}}';
  }
}