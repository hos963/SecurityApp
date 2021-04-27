part of 'web_main_bloc.dart';

abstract class WebMainEvent extends Equatable {
  const WebMainEvent();

  List<Object> get props => [];
}

class CreateUserAccountEvent extends WebMainEvent {
  final FirebaseUserData userdata;

  CreateUserAccountEvent(this.userdata);

  @override
  List<Object> get props => [this.userdata];

  @override
  String toString() {
    return '{create user acocunt ${this.userdata.email}}';
  }
}

class getFirebaseUserslistevetn extends WebMainEvent {
  getFirebaseUserslistevetn();

  @override
  List<Object> get props => [];

  @override
  String toString() {
    return '{create user acocunt }';
  }
}

class setcheckisActiveUser extends WebMainEvent {
  bool isactive;
  int position;
  String userid;

  setcheckisActiveUser(this.isactive, position, this.userid);

  @override
  List<Object> get props => [isactive];

  @override
  String toString() {
    return '{create user acocunt }';
  }
}


class DeletingDataweb extends WebMainEvent {
  DateTimeRange dateTimeRange;

  DeletingDataweb(this.dateTimeRange);
  @override
  List<Object> get props => [dateTimeRange];

  @override
  String toString() {
    return 'LoginWithCredentialsPressed { email: $dateTimeRange }';
  }
}
