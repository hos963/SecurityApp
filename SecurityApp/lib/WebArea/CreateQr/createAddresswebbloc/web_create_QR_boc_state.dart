part of 'web_create_QR_boc_bloc.dart';

abstract class WebCreateAddressBocState extends Equatable {
  const WebCreateAddressBocState();
  @override
  List<Object> get props => [];
}

class WebCreateAddressBocInitial extends WebCreateAddressBocState {
  @override
  String toString() => 'Uninitialized';
}

class WebCreateAddressMainLoading extends WebCreateAddressBocState {
  @override
  String toString() => 'Loading';
}

class SuccessfullyCreatedAddressstate extends WebCreateAddressBocState {
  final String successmsg;

  const SuccessfullyCreatedAddressstate(this.successmsg);

  @override
  String toString() => 'Authenticated { display data: $successmsg }';
}

class gettingCreateAddresslistdatastate extends WebCreateAddressBocState {

  const gettingCreateAddresslistdatastate();

  @override
  String toString() => 'Authenticated { display data:  }';
}


class FailedToCreateAddress extends WebCreateAddressBocState {
  final String errorstr;

  const FailedToCreateAddress(this.errorstr);

  @override
  String toString() => 'Authenticated { display data: $errorstr }';
}