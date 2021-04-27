part of 'web_main_bloc.dart';

abstract class WebMainState extends Equatable {
  const WebMainState();
  @override
  List<Object> get props => [];
}

class WebMainInitial extends WebMainState {
  @override
  String toString() => 'Uninitialized';
}

class WebMainLoading extends WebMainState {
  @override
  String toString() => 'Loading';
}

class SuccessfullyCreatedAccountstate extends WebMainState {
  final String successmsg;

  const SuccessfullyCreatedAccountstate(this.successmsg);

  @override
  String toString() => 'Authenticated { display data: $successmsg }';
}

class gettinglistdatastate extends WebMainState {

  const gettinglistdatastate();

  @override
  String toString() => 'Authenticated { display data:  }';
}


class FailedToCreateAccount extends WebMainState {
  final String errorstr;

  const FailedToCreateAccount(this.errorstr);

  @override
  String toString() => 'Authenticated { display data: $errorstr }';
}




class isactiveuserState extends WebMainState {
  final bool isactive;
  final int position ;
  const isactiveuserState(this.isactive,this.position);
  @override
  List<Object> get props => [this.position];
  @override
  String toString() => 'Authenticated { display data: $isactive }';
}

