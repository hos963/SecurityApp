part of 'web_create_QR_boc_bloc.dart';

abstract class WebCreateAddressBocEvent extends Equatable {
  const WebCreateAddressBocEvent();


  List<Object> get props => [];
}

class CreateAddressEvent extends WebCreateAddressBocEvent {
  final AddQRModel addQRModel;

  CreateAddressEvent(this.addQRModel);

  @override
  List<Object> get props => [this.addQRModel];

  @override
  String toString() {
    return '{create user acocunt ${this.addQRModel.locationName}}';
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
  final AddQRModel addQRModel;

  DeleteUserAdress(this.addQRModel);

  @override
  List<Object> get props => [this.addQRModel];

  @override
  String toString() {
    return '{create user acocunt ${this.addQRModel.locationName}}';
  }
}