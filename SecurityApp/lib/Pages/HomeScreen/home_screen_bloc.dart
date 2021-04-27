import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:Metropolitane/Database/DeviceDatabase.dart';
import 'package:Metropolitane/FirebaseService/FirebaseService.dart';
import 'package:Metropolitane/Pages/LoginPage/login_bloc.dart';
import 'package:Metropolitane/ServicesPage/Repository.dart';
import 'package:Metropolitane/Utilities/PreferenceUtils.dart';
import 'package:Metropolitane/model/DeviceModel.dart';
import 'package:Metropolitane/model/EventsModel.dart';
import 'package:Metropolitane/model/FirebaseUserData.dart';
import 'package:Metropolitane/model/ReadSettingModel.dart';
import 'package:Metropolitane/model/ReportsModel.dart';

part 'home_screen_event.dart';

part 'home_screen_state.dart';

enum SelectedEventName {
  StartVolt,
  IgnitionAttemp,
  IgnitionDelay,
  OffVolt,
  ReportTime,
  TimeZone
}

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc() : super(HomeScreenInitial());
  Repository _repository = Repository();
  ReportsModel reportsModel;
  ReadSettingModel readSettingModel;
  Map<String, ReportsModel> reporstList = new HashMap();

  Map<String, EventsModel> eventList = new HashMap();
  String selecteddevice = "Select Device Bellow";
  DeviceModel selected_devicemodel;
  List<DeviceModel> DevicesList = [
    DeviceModel(id: 10101, devicename: "Select Device Bellow", deviceid: "1010")
  ];
  FirebaseService _firebaseService = new FirebaseService();

  @override
  Stream<HomeScreenState> mapEventToState(
    HomeScreenEvent event,
  ) async* {
    if (event is GetListOfDevices) {
      final listdata = await DeviceDatabase.query(DbPrefTableName.devices_list);

      String usercompletedata =
      PreferenceUtils.getString(PrefKey.UserCompleteData, null);

      Map<String, dynamic> user = jsonDecode(usercompletedata);

       FirebaseUserData firebaseUserData = new FirebaseUserData.fromJson(user);


      DevicesList = firebaseUserData.devicesList.map((element) {

        return DeviceModel.fromMap( jsonDecode(element));
      }).toList();



      // DevicesList = listdata.map((element) {
      //   return DeviceModel.fromMap(element);
      // }).toList();

      selecteddevice = DevicesList.first.devicename;
      selected_devicemodel = DevicesList.first;
      yield GetDeviceListState(DevicesList, DevicesList.length);
    }

    if (event is SelectDevice) {
      DeviceModel deviceModel = DevicesList.firstWhere(
          (i) => i.devicename == event.selecteddevicename);
      selecteddevice = deviceModel.devicename;
      selected_devicemodel = deviceModel;
      yield GetSelectedDevice(deviceModel);
    }

    if (event is ResetTimerEvent) {
      yield* _reseteventtimerToState();
    }

    if (event is GenOnEvent) {
      yield* _genratorOneventtimerToState();
    }
    if (event is GenOffEvent) {
      yield* _genratorOFFeventtimerToState();
    }

    if (event is CallingfunctionsWithDifferentName) {
      yield* _callingDifferentFunctionsToState(
          event.eventnamecall, event.valuenumber);
    }

    if (event is ReadSetting) {
      yield* _callingReadSettingFunctionsToState();
    }

    if (event is GettingStreamDataFirestore) {
      yield* _gettingFirestoreStreamDataToState(event);
    }

    if (event is ReadSettingEvent) {
      yield* _mapReadSettingEventToState(event.readSettingModel);
    }

    if (event is ReportEvent) {
      yield* _mapReportEventToState(event.reportsModel);
    }

    if (event is ListReportMapEvent) {
      yield* _mapListReportEventToState(event.remortMapList);
    }
    if (event is ListallEventsMapEvent) {
      yield* _mapListalleventsEventToState(event.allEventsMapList,event.repostmapList);
    }

  }

  Stream<HomeScreenState> _mapListalleventsEventToState(
      Map<String, EventsModel> eventsall, Map<String, ReportsModel> reportsmap) async* {
    yield AllListMapState(eventList,reporstList);
  }


  StreamSubscription<QuerySnapshot> streamquery;

  Stream<HomeScreenState> _gettingFirestoreStreamDataToState(
      HomeScreenEvent homeScreenEvent) async* {
    streamquery?.cancel();
    reporstList.clear();
    eventList.clear();
    streamquery = _firebaseService
        .getingReadDataStream(selected_devicemodel.deviceid)
        .listen((event) {
      QueryDocumentSnapshot queryDocumentSnapshot = event.docs.first;
      bool gettingfirstreportmodel = false;
      bool readvarmodel = false;


      for (DocumentChange documentChange in event.docChanges) {
         String nameevent = documentChange.doc.data()["eventname"];

        // if (gettingfirstreportmodel == false && nameevent == "Report_Payload") {
        //   gettingfirstreportmodel = true;
        //   reportsModel = ReportsModel.fromJson(documentChange.doc.data());
        //
        //   add(ReportEvent(reportsModel));
        // }
        //
        // if (readvarmodel == false && nameevent == "Var_Payload") {
        //   readvarmodel = true;
        //   readSettingModel =
        //       ReadSettingModel.fromJson(documentChange.doc.data());
        //
        //   add(ReadSettingEvent(readSettingModel));
        // }

        if (nameevent == "Report_Payload") {
          reportsModel = ReportsModel.fromJson(documentChange.doc.data());

          reporstList[documentChange.doc.id] = reportsModel;
        }

         if (nameevent == "Report_Payload" || nameevent == "Var_Payload") {
          EventsModel eventsModel = EventsModel.fromJson(documentChange.doc.data());

           eventList[documentChange.doc.id] = eventsModel;
         }

      }

     // add(ListReportMapEvent(reporstList));
      add(ListallEventsMapEvent(eventList,reporstList));
    });
  }



  Stream<HomeScreenState> _mapListReportEventToState(
      Map<String, ReportsModel> reportsModel) async* {
    yield ReportListMapState(reportsModel);
  }

  Stream<HomeScreenState> _mapReportEventToState(
      ReportsModel reportsModel) async* {
    yield RerportDataState(reportsModel);
  }

  Stream<HomeScreenState> _mapReadSettingEventToState(
      ReadSettingModel readSettingModel) async* {
    yield GetReadSettingState(readSettingModel);
  }

  Stream<HomeScreenState> _callingReadSettingFunctionsToState() async* {
    yield ShowProgressState();
    try {
      String successfull =
          await _repository.ReadSettingApiCall(selected_devicemodel.deviceid);
      yield HideProgressState(successfull);
    } catch (e) {
      yield HideProgressState(e.toString());
    }
  }

  Stream<HomeScreenState> _callingDifferentFunctionsToState(
      SelectedEventName selectedEventName, var valuenumber) async* {
    yield ShowProgressState();
    try {
      String successfull = await _repository.CallingFunctionsWithNameEvents(
          selected_devicemodel.deviceid, selectedEventName, valuenumber);
      yield HideProgressState(successfull);
    } catch (e) {
      yield HideProgressState(e.toString());
    }
  }

  Stream<HomeScreenState> _reseteventtimerToState() async* {
    yield ShowProgressState();
    try {
      String successfull =
          await _repository.ResetTimerEventRepo(selected_devicemodel.deviceid);
      yield HideProgressState(successfull);
    } catch (e) {
      yield HideProgressState(e.toString());
    }
  }

  Stream<HomeScreenState> _genratorOneventtimerToState() async* {
    yield ShowProgressState();
    try {
      String successfull =
          await _repository.GeneratorOnEventRepo(selected_devicemodel.deviceid);
      yield HideProgressState(successfull);
    } catch (e) {
      yield HideProgressState(e.toString());
    }
  }

  Stream<HomeScreenState> _genratorOFFeventtimerToState() async* {
    yield ShowProgressState();
    try {
      String successfull = await _repository.GeneratorOffEventRepo(
          selected_devicemodel.deviceid);
      yield HideProgressState(successfull);
    } catch (e) {
      yield HideProgressState(e.toString());
    }
  }
}
