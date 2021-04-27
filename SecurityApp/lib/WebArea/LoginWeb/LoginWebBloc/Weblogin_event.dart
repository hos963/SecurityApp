part of 'Weblogin_bloc.dart';

abstract class WebLoginEvent extends Equatable {
  const WebLoginEvent();
  List<Object> get props => [];
}


class LoginWithCredentialsPressed extends WebLoginEvent {

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

class ForgetPassword extends WebLoginEvent {

  final String email;


  ForgetPassword({@required this.email});

  @override
  List<Object> get props => [email];

  @override
  String toString() {
    return 'LoginWithCredentialsPressed { email: $email }';
  }
}



class SigupEventClick extends WebLoginEvent {
}


class RememberMeClick extends WebLoginEvent {
  final bool remeberme;


  RememberMeClick({@required this.remeberme});




}

class IncrementEvent extends WebLoginEvent {





}

