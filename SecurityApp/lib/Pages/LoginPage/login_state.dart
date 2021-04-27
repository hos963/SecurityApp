part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {
  @override
  String toString() => 'Uninitialized';
}

class LoginLoading extends LoginState {
  @override
  String toString() => 'Loading';
}

class UserDataLoaded extends LoginState {
  final String userdata;

  const UserDataLoaded(this.userdata);

  @override
  // TODO: implement props
  List<Object> get props => [userdata];

  @override
  String toString() => 'Authenticated { display data: $userdata }';
}


class SuccessFull extends LoginState {
  final String message;

  const SuccessFull(this.message);

  @override
  String toString() => 'Authenticated { display data: $message }';
}


class FailedAuthError extends LoginState {
  final String errorstr;

  const FailedAuthError(this.errorstr);

  @override
  String toString() => 'Authenticated { display data: $errorstr }';
}




class CheckinStatus extends LoginState {
  final bool ischeckin;

  const CheckinStatus(this.ischeckin);


}


class CheckboxStatus extends LoginState {
  final bool ischeckin;

  const CheckboxStatus(this.ischeckin);
  @override
  // TODO: implement props
  List<Object> get props => [ischeckin];

  @override
  String toString() => 'Authenticated { display data: $ischeckin }';

}
class IncrementStatus extends LoginState {
  final int count;
  const IncrementStatus(this.count);

  @override
  // TODO: implement props
  List<Object> get props => [count];

  @override
  String toString() => 'Authenticated { display data: $count }';


}

