part of 'home_screen_bloc.dart';

abstract class HomeScreenState extends Equatable {
  const HomeScreenState();
}

class HomeScreenInitial extends HomeScreenState {
  @override
  List<Object> get props => [];
}

class GetDeviceListState extends HomeScreenState {
  List<DeviceModel> devicelist;
  int count;

  GetDeviceListState(this.devicelist, this.count);

  @override
  List<Object> get props => [count];

  @override
  String toString() => 'Authenticated { display data: $devicelist }';
}

class GetSelectedDevice extends HomeScreenState {
  DeviceModel devicelist;

  GetSelectedDevice(this.devicelist);

  @override
  List<Object> get props => [devicelist];

  @override
  String toString() => 'Authenticated { display data: $devicelist }';
}

class GetReadSettingState extends HomeScreenState {
  final ReadSettingModel readSettingModel;

  const  GetReadSettingState(this.readSettingModel);
  @override
  List<Object> get props => [readSettingModel];


  @override
  String toString() => 'Authenticated { display data: $readSettingModel }';
}

class RerportDataState extends HomeScreenState {
  ReportsModel reportsModel;

  RerportDataState(this.reportsModel);

  @override
  List<Object> get props => [reportsModel];

  @override
  String toString() => 'Authenticated { display data: $reportsModel }';
}

class ReportListMapState extends HomeScreenState {
  Map<String, ReportsModel> reportmaplist;

  ReportListMapState(this.reportmaplist);

  @override
  List<Object> get props => [reportmaplist];

  @override
  String toString() => 'Authenticated { display data: $reportmaplist }';
}

class AllListMapState extends HomeScreenState {
  Map<String, EventsModel> alleventsmap;
  Map<String, ReportsModel> reportsMap;

  AllListMapState(this.alleventsmap,this.reportsMap);

  @override
  List<Object> get props => [alleventsmap,reportsMap];

  @override
  String toString() => 'Authenticated { display data: $alleventsmap }';
}


class ShowProgressState extends HomeScreenState {
  @override
  String toString() => 'Loading';

  @override
  List<Object> get props => [];
}

class HideProgressState extends HomeScreenState {
  String messgage;

  HideProgressState(this.messgage);

  @override
  String toString() => 'Hide Progress';

  @override
  List<Object> get props => [];
}
