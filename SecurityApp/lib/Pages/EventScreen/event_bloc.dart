import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:Metropolitane/Database/DeviceDatabase.dart';
import 'package:Metropolitane/FirebaseService/FirebaseService.dart';
import 'package:Metropolitane/Utilities/PreferenceUtils.dart';
import 'package:Metropolitane/model/DeviceModel.dart';
import 'package:Metropolitane/model/EventsModel.dart';
import 'package:Metropolitane/model/FirebaseUserData.dart';

part 'event_event.dart';

part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  EventBloc() : super(EventInitial());

  FirebaseService _firebaseService = new FirebaseService();

  List<DeviceModel> DevicesList = [
    DeviceModel(id: 10101, devicename: "Select Device Bellow", deviceid: "1010")
  ];
  String selecteddevice = "Select Device Bellow";
  DeviceModel selected_devicemodel;
 Map<String,EventsModel> eventMap = new HashMap();
  @override
  Stream<EventState> mapEventToState(
    EventEvent event,
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

    if (event is SelectDeviceinEvents) {
      DeviceModel deviceModel = DevicesList.firstWhere(
          (i) => i.devicename == event.selecteddevicename);
      selecteddevice = deviceModel.devicename;
      selected_devicemodel = deviceModel;
      yield GetSelectedDevice(deviceModel);
    }


    if (event is GettingStreamDataFirestoreEvents) {
      yield* _gettingFirestoreStreamDataToState(event);
    }

    if (event is ListEventsMapList) {
      yield* _mapListReportEventToState(event.alleventslist);
    }


  }

  Stream<EventState> _mapListReportEventToState(
      Map<String,EventsModel> reportsModel) async* {
    yield EventListMapState(reportsModel);
  }


  StreamSubscription<QuerySnapshot> streamquery;

  Stream<EventState> _gettingFirestoreStreamDataToState(
      EventEvent eventEvent) async* {
    streamquery?.cancel();
    streamquery = _firebaseService
        .getAllStreamDatafromFirebase(selected_devicemodel.deviceid)
        .listen((event) {
      QueryDocumentSnapshot queryDocumentSnapshot = event.docs.first;
      bool gettingfirstreportmodel = false;
      bool readvarmodel = false;

      for (DocumentChange documentChange in event.docChanges) {
        String nameevent = documentChange.doc.data()["eventname"];
        EventsModel eventmodel = EventsModel.fromJson(documentChange.doc.data());
       // eventMap(documentChange.doc.id, () => eventmodel);
        eventMap[documentChange.doc.id] = eventmodel;
      }
      add(ListEventsMapList(eventMap));

    });
  }


}
