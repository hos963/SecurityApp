part of 'setting_bloc.dart';

abstract class SettingEvent extends Equatable {
  const SettingEvent();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ShowDeviceList extends SettingEvent {}

class RemovedDeviceList extends SettingEvent {
  DeviceModel deviceModel;

  RemovedDeviceList(@required this.deviceModel);

  @override
  List<Object> get props => [deviceModel];

  @override
  String toString() {
    return 'device added';
  }
}

class UploadImage extends SettingEvent {
  File file;

  UploadImage(@required this.file);

  @override
  List<Object> get props => [file];

  @override
  String toString() {
    return 'device added';
  }
}


class DismissProgressEvent extends SettingEvent {


  DismissProgressEvent();

  @override
  List<Object> get props => [];

  @override
  String toString() {
    return 'device added';
  }
}

class AddingDeviceData extends SettingEvent {
  DeviceModel deviceModel;

  AddingDeviceData(@required this.deviceModel);

  @override
  List<Object> get props => [deviceModel];

  @override
  String toString() {
    return 'device added';
  }
}
