part of 'event_bloc.dart';

abstract class EventEvent extends Equatable {
  const EventEvent();
  List<Object> get props => [];
}
class GetListOfDevices extends EventEvent {
  GetListOfDevices();
}

class SelectDeviceinEvents extends EventEvent {
  String selecteddevicename;

  SelectDeviceinEvents(this.selecteddevicename);
}

class GettingStreamDataFirestoreEvents extends EventEvent {
  GettingStreamDataFirestoreEvents();
}


class ListEventsMapList extends EventEvent {
  Map<String,EventsModel> alleventslist;

  ListEventsMapList(this.alleventslist);
}