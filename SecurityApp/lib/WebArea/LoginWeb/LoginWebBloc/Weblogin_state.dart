part of 'Weblogin_bloc.dart';

abstract class WebLoginState extends Equatable {
  const WebLoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends WebLoginState {
  @override
  String toString() => 'Uninitialized';
}

class LoginLoading extends WebLoginState {
  @override
  String toString() => 'Loading';
}

class UserDataLoaded extends WebLoginState {
  final FirebaseUserData userdata;

  const UserDataLoaded(this.userdata);

  @override
  // TODO: implement props
  List<Object> get props => [userdata];

  @override
  String toString() => 'Authenticated { display data: $userdata }';
}


class SuccessFull extends WebLoginState {
  final String message;

  const SuccessFull(this.message);

  @override
  String toString() => 'Authenticated { display data: $message }';
}


class FailedAuthError extends WebLoginState {
  final String errorstr;

  const FailedAuthError(this.errorstr);

  @override
  String toString() => 'Authenticated { display data: $errorstr }';
}




class CheckinStatus extends WebLoginState {
  final bool ischeckin;

  const CheckinStatus(this.ischeckin);


}


class CheckboxStatus extends WebLoginState {
  final bool ischeckin;

  const CheckboxStatus(this.ischeckin);
  @override
  // TODO: implement props
  List<Object> get props => [ischeckin];

  @override
  String toString() => 'Authenticated { display data: $ischeckin }';

}
class IncrementStatus extends WebLoginState {
  final int count;
  const IncrementStatus(this.count);

  @override
  // TODO: implement props
  List<Object> get props => [count];

  @override
  String toString() => 'Authenticated { display data: $count }';


}

