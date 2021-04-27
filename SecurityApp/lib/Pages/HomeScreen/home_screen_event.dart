part of 'home_screen_bloc.dart';

abstract class HomeScreenEvent extends Equatable {
  const HomeScreenEvent();

  List<Object> get props => [];
}

class GetListOfDevices extends HomeScreenEvent {
  GetListOfDevices();
}

class SelectDevice extends HomeScreenEvent {
  String selecteddevicename;

  SelectDevice(this.selecteddevicename);
}

class GenOffEvent extends HomeScreenEvent {}

class GenOnEvent extends HomeScreenEvent {}

class ResetTimerEvent extends HomeScreenEvent {}

class ReadSetting extends HomeScreenEvent {}

class GettingStreamDataFirestore extends HomeScreenEvent {}




class ReadSettingEvent extends HomeScreenEvent {
  ReadSettingModel readSettingModel;

  ReadSettingEvent(this.readSettingModel);
  @override
  List<Object> get props => [readSettingModel];

  @override
  String toString() {
    return 'LoginWithCredentialsPressed { email: $readSettingModel }';
  }
}

class ReportEvent extends HomeScreenEvent {
  ReportsModel reportsModel;

  ReportEvent(this.reportsModel);

}

class ListReportMapEvent extends HomeScreenEvent {
  Map<String,ReportsModel> remortMapList;

  ListReportMapEvent(this.remortMapList);


}

class ListallEventsMapEvent extends HomeScreenEvent {
  Map<String,EventsModel> allEventsMapList;
  Map<String,ReportsModel> repostmapList;

  ListallEventsMapEvent(this.allEventsMapList,this.repostmapList);


}

class CallingfunctionsWithDifferentName extends HomeScreenEvent {
  SelectedEventName eventnamecall;
  var valuenumber;

  CallingfunctionsWithDifferentName(this.eventnamecall, this.valuenumber);
}
