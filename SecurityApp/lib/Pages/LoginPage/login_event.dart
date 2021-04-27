part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
  List<Object> get props => [];
}


class LoginWithCredentialsPressed extends LoginEvent {

  final String email;
  final String password;

  LoginWithCredentialsPressed({@required this.email, @required this.password});

  @override
  List<Object> get props => [email,password];

  @override
  String toString() {
    return 'LoginWithCredentialsPressed { email: $email, password: $password }';
  }
}

class ForgetPassword extends LoginEvent {

  final String email;


  ForgetPassword({@required this.email});

  @override
  List<Object> get props => [email];

  @override
  String toString() {
    return 'LoginWithCredentialsPressed { email: $email }';
  }
}



class SigupEventClick extends LoginEvent {
}


class RememberMeClick extends LoginEvent {
  final bool remeberme;


  RememberMeClick({@required this.remeberme});




}

class IncrementEvent extends LoginEvent {





}

