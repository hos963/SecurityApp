import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:Metropolitane/Database/DeviceDatabase.dart';
import 'package:Metropolitane/FirebaseService/FirebaseAuthServices.dart';
import 'package:Metropolitane/FirebaseService/FirebaseService.dart';
import 'package:Metropolitane/Utilities/PreferenceUtils.dart';
import 'package:Metropolitane/model/DeviceModel.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:Metropolitane/model/FirebaseUserData.dart';

part 'setting_event.dart';

part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc() : super(SettingInitial());
  List<DeviceModel> devicelist = new List();
  FirebaseService firebaseService = new FirebaseService();

  @override
  Stream<SettingState> mapEventToState(
    SettingEvent event,
  ) async* {
    if (event is ShowDeviceList) {
      yield* _mapFetchingDeviceList();
    }
    if (event is AddingDeviceData) {
      int value = await DeviceDatabase.insertDeviceModel(
          DbPrefTableName.devices_list, event.deviceModel);

      devicelist.add(event.deviceModel);
      yield AddDeviceList(devicelist, devicelist.length);
    }

    if (event is RemovedDeviceList) {
      yield* _mapRemovedDeviceFromList(event.deviceModel);
    }

    if (event is UploadImage) {
      yield* _mapuploadImage(event.file);
    }
  }

  Stream<SettingState> _mapuploadImage(File file) async* {
    yield LoadingPage();
    try {
      UploadTask uploadTask = await firebaseService.uploadFileToFirestore(file);

      var imageUrl = await (await uploadTask).ref.getDownloadURL();
      await firebaseService.settingUserPhotoLink(imageUrl);
      PreferenceUtils.setString(PrefKey.UserPic, imageUrl);
      yield ImageLinkUploaded(imageUrl);
    } catch (e) {
      yield DismissProgressPagestate();
    }
  }

  Stream<SettingState> _mapRemovedDeviceFromList(
      DeviceModel deviceModel) async* {
    yield SettingInitial();
    try {
      await DeviceDatabase.deleteDeviceModel(
          DbPrefTableName.devices_list, deviceModel);

      devicelist.remove(deviceModel);

      yield ListDevicesGetState(devicelist);
    } catch (e) {}
  }

  Stream<SettingState> _mapFetchingDeviceList() async* {
    yield SettingInitial();
    try {
      final listdata = await DeviceDatabase.query(DbPrefTableName.devices_list);

      String usercompletedata =
      PreferenceUtils.getString(PrefKey.UserCompleteData, null);

      Map<String, dynamic> user = jsonDecode(usercompletedata);

      FirebaseUserData firebaseUserData = new FirebaseUserData.fromJson(user);


      devicelist = firebaseUserData.devicesList.map((element) {

        return DeviceModel.fromMap( jsonDecode(element));
      }).toList();


      // devicelist = listdata.map((element) {
      //   return DeviceModel.fromMap(element);
      // }).toList();

      yield ListDevicesGetState(devicelist);
    } catch (e) {}
  }
}
