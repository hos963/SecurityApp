part of 'setting_bloc.dart';

abstract class SettingState extends Equatable {
  const SettingState();



  @override
  List<Object> get props => [];
}

class SettingInitial extends SettingState {
  @override
  List<Object> get props => [];
}

class AddDeviceList extends SettingState {
  List<DeviceModel> devicelist;
  int count;

  AddDeviceList(this.devicelist,this.count);

  @override
  List<Object> get props => [count];

  @override
  String toString() => 'Authenticated { display data: $devicelist }';
}

class ListDevicesGetState extends SettingState {
  final List<DeviceModel> devicelist;

  const ListDevicesGetState(this.devicelist);

  @override
  List<Object> get props => [devicelist.length];

  @override
  String toString() => 'Authenticated { display data: $devicelist }';
}



class LoadingPage extends SettingState {
  @override
  String toString() => 'Loading';
}


class DismissProgressPagestate extends SettingState {


  DismissProgressPagestate();



  @override
  String toString() {
    return 'device added';
  }
}


class ImageLinkUploaded extends SettingState {
  String imagelink;

   ImageLinkUploaded(this.imagelink);

  @override
  List<Object> get props => [imagelink];

  @override
  String toString() => 'Authenticated { display data: $imagelink }';
}
