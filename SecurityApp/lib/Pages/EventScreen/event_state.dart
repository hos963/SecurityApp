part of 'event_bloc.dart';

abstract class EventState extends Equatable {
  const EventState();
}

class EventInitial extends EventState {
  @override
  List<Object> get props => [];
}
class GetDeviceListState extends EventState {
  List<DeviceModel> devicelist;
  int count;

  GetDeviceListState(this.devicelist, this.count);

  @override
  List<Object> get props => [count];

  @override
  String toString() => 'Authenticated { display data: $devicelist }';
}

class GetSelectedDevice extends EventState {
  DeviceModel devicelist;

  GetSelectedDevice(this.devicelist);

  @override
  List<Object> get props => [devicelist];

  @override
  String toString() => 'Authenticated { display data: $devicelist }';
}

class EventListMapState extends EventState {
  Map<String, EventsModel> eventmaplist;

  EventListMapState(this.eventmaplist);

  @override
  List<Object> get props => [eventmaplist];

  @override
  String toString() => 'Authenticated { display data: $eventmaplist }';
}