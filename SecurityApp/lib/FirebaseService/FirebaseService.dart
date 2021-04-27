import 'dart:async';
import 'dart:async';
import 'dart:async';
import 'dart:collection';
import 'dart:io';

import 'package:Metropolitane/model/AddAlarmModel.dart';
import 'package:Metropolitane/model/AddPatrolModel.dart';
import 'package:Metropolitane/model/AddressAlarmModel.dart';
import 'package:Metropolitane/model/QuestionareModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:Metropolitane/model/FirebaseUserData.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io' as io;

class FirebaseService {
  FirebaseFirestore _fireStoreDataBase = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getingReadDataStream(String deviceid) {
    Query collectionReference = _fireStoreDataBase
        .collection('Readingdata')
        .where("deviceid", isEqualTo: deviceid)
        .where("eventname", whereIn: ["Report_Payload", "Var_Payload"]).orderBy(
            "publishtime",
            descending: true);
    Query query = collectionReference.limit(30);

    return query.snapshots().where((event) {
      if (deviceid == null) return true;
      for (DocumentChange documentChange in event.docChanges) {
        var id = documentChange.doc.id;
        var data = documentChange.doc.data;
        return true;
      }
      return false;
    });
  }

  Stream<QuerySnapshot> getAllStreamDatafromFirebase(String deviceid) {
    Query collectionReference = _fireStoreDataBase
        .collection('Readingdata')
        .orderBy("publishtime", descending: true);
    Query query = collectionReference.limit(30);

    return query.snapshots().where((event) {
      if (deviceid == null) return true;
      for (DocumentChange documentChange in event.docChanges) {
        var id = documentChange.doc.id;
        var data = documentChange.doc.data;
        return true;
      }
      return false;
    });
  }

  Future<void> AddingUserData(FirebaseUserData firebaseUserData) async {
    Map<String, dynamic> data = new Map();

    data["email"] = firebaseUserData.email;
    data["udid"] = firebaseUserData.udid;
    data["name"] = firebaseUserData.name;
    data["contactnumber"] = firebaseUserData.phonenumber;
    data["typeofuser"] = firebaseUserData.typeofuser;
    data["isactive"] = true;
    data["Timestamp"] = FieldValue.serverTimestamp();
    var result = await _fireStoreDataBase
        .collection("users")
        .doc(firebaseUserData.udid)
        .set(data);
    return result;
  }

  Future<FirebaseUserData> gettingNormalUsersData(User fbuser) async {
    DocumentSnapshot result =
        await _fireStoreDataBase.collection("users").doc(fbuser.uid).get();

    FirebaseUserData firebaseUserData =
        FirebaseUserData.fromJson(result.data());

    return firebaseUserData;
  }

  Future<void> addAlarm(AddAlarmModel alarmModel) async {
    String id = _fireStoreDataBase.collection("AlarmAlert").doc().id;
    alarmModel.alarmId = id;

    var resp = await _fireStoreDataBase
        .collection("AlarmAlert")
        .doc(id)
        .set(alarmModel.AddAlrmToMap());

    return resp;
  }

  Future<void> addPatrol(AddPatrolModel patrolModel) async {
    String id = _fireStoreDataBase.collection("PatrolAlert").doc().id;
    patrolModel.patrolId = id;

    var resp = await _fireStoreDataBase
        .collection("PatrolAlert")
        .doc(id)
        .set(patrolModel.AddPatrolTopMap());

    return resp;
  }


  Future<void> UpdateAlarm(AddAlarmModel alarmModel) async {
    var resp = await _fireStoreDataBase
        .collection("AlarmAlert")
        .doc(alarmModel.alarmId)
        .set(alarmModel.AddAlrmToMap(isupdate: true), SetOptions(merge: true));

    return resp;
  }

  Future<void> updateOnway(
      String keypath, QuestionareModel questionareModel) async {
    var resp = await _fireStoreDataBase
        .collection("AlarmAlert")
        .doc(keypath)
        .set(questionareModel.AddAlrmOnthewayToMap(), SetOptions(merge: true));

    return resp;
  }

  Future<void> messagetoPannelToMapp(
      String keypath, QuestionareModel questionareModel) async {
    var resp = await _fireStoreDataBase
        .collection("AlarmAlert")
        .doc(keypath)
        .set(questionareModel.MessageOnPanelToMap(), SetOptions(merge: true));

    return resp;
  }
  Future<void> HavekeyUpdate(
      String keypath, QuestionareModel questionareModel) async {
    var resp = await _fireStoreDataBase
        .collection("AlarmAlert")
        .doc(keypath)
        .set(questionareModel.HaveKeyToMapModel(), SetOptions(merge: true));

    return resp;
  }

  Future<void>ActionTakennToMapp(
      String keypath, QuestionareModel questionareModel) async {
    var resp = await _fireStoreDataBase
        .collection("AlarmAlert")
        .doc(keypath)
        .set(questionareModel.actionTakenToMap(), SetOptions(merge: true));

    return resp;
  }

  Future<void>LeaveBuildingToMapp(
      String keypath, QuestionareModel questionareModel) async {
    var resp = await _fireStoreDataBase
        .collection("AlarmAlert")
        .doc(keypath)
        .set(questionareModel.LeaveBuildingtoMap(), SetOptions(merge: true));

    return resp;
  }

  Future<void>UpdatingStatus(
      String keypath, AddAlarmModel addAlarmModel) async {
    var resp = await _fireStoreDataBase
        .collection("AlarmAlert")
        .doc(keypath)
        .set(addAlarmModel.AddAlrmToMap(isupdate: true), SetOptions(merge: true));

    return resp;
  }


  Future<void> InternalOrExternalUpdate(String keypath,
      QuestionareModel questionareModel, bool isinternal) async {
    if (isinternal == true) {
      var resp = await _fireStoreDataBase
          .collection("AlarmAlert")
          .doc(keypath)
          .set(questionareModel.InternakPictureOfBuildingModeltoMap(), SetOptions(merge: true));

      return resp;
    } else {
      var resp2 = await _fireStoreDataBase
          .collection("AlarmAlert")
          .doc(keypath)
          .set(questionareModel.ExternalPictureOfBuildingModeltoMap(), SetOptions(merge: true));

      return resp2;
    }
  }



  Future<void> PictureOfAlarmPanel(
      String keypath, QuestionareModel questionareModel) async {
    var resp = await _fireStoreDataBase
        .collection("AlarmAlert")
        .doc(keypath)
        .set(questionareModel.picAlarmPaneltoMap(), SetOptions(merge: true));

    return resp;
  }





  Future<void> SetOrUnSetAlarm(String keypath,
      QuestionareModel questionareModel, bool isinternal) async {
    if (isinternal == true) {
      var resp = await _fireStoreDataBase
          .collection("AlarmAlert")
          .doc(keypath)
          .set(questionareModel.UnsetAlarmtoMap(), SetOptions(merge: true));

      return resp;
    } else {
      var resp2 = await _fireStoreDataBase
          .collection("AlarmAlert")
          .doc(keypath)
          .set(questionareModel.setAlarmtoMap(), SetOptions(merge: true));

      return resp2;
    }
  }

  Future<void> ReachedOnSiteUpdate(
      String keypath, QuestionareModel questionareModel) async {
    var resp = await _fireStoreDataBase
        .collection("AlarmAlert")
        .doc(keypath)
        .set(questionareModel.AddReachedonSiteModel(), SetOptions(merge: true));

    return resp;
  }

  Future<List<String>> GetAllReadingdata(DateTimeRange dateTimeRange) async {
    List<String> idslist = new List();

    QuerySnapshot result = await _fireStoreDataBase
        .collection("Readingdata")
        .where("publishtime",
            isGreaterThan: dateTimeRange.start.toUtc().toIso8601String())
        .where("publishtime",
            isLessThanOrEqualTo: dateTimeRange.end.toUtc().toIso8601String())
        .get();

    result.docs.forEach((result) {
      print(result.id);
      idslist.add(result.id);
    });

    return idslist;
  }

  Future<FirebaseUserData> GettingUserData(User fbuser) async {
    DocumentSnapshot result =
        await _fireStoreDataBase.collection("AdminUser").doc(fbuser.uid).get();

    FirebaseUserData firebaseUserData =
        FirebaseUserData.fromJson(result.data());

    return firebaseUserData;
  }

  Future<List<FirebaseUserData>> gettingAllUsersData() async {
    List<FirebaseUserData> list =
        new List<FirebaseUserData>.empty(growable: true);
    ;
    var documents =
        await _fireStoreDataBase.collection("users").orderBy('Timestamp').get();
    documents.docs.forEach((element) {
      list.add(FirebaseUserData.fromJson(element.data()));
    });

    return list;
  }

  Future<List<AddressAlarmModel>> gettingAllLocationsData() async {
    var list = new List<AddressAlarmModel>.empty(growable: true);
    // var list2 = new List();
    var documents = await _fireStoreDataBase
        .collection("Addresses")
        .orderBy('Timestamp')
        .get();
    documents.docs.forEach((element) {
      list.add(AddressAlarmModel.fromJson(element.data()));
    });

    return list;
  }

  Future<void> deleteAddress(AddressAlarmModel addressAlarmModel) async {
    var del = await _fireStoreDataBase
        .collection("Addresses")
        .doc(addressAlarmModel.adressId)
        .delete();

    return del;
  }

  Future<void> AddingAddressData(AddressAlarmModel addressAlarmModel) async {
    Map<String, dynamic> data = new Map();
    var idpost;
    if (addressAlarmModel.adressId != null) {
      idpost = addressAlarmModel.adressId;
    } else {
      idpost = _fireStoreDataBase.collection("Addresses").doc().id;
    }
    data["locationName"] = addressAlarmModel.locationName;
    data["latitude"] = addressAlarmModel.latitude;
    data["longitude"] = addressAlarmModel.longitude;
    data["adressId"] = idpost;
    data["Timestamp"] = FieldValue.serverTimestamp();
    data["isvisible"] = true;
    var result = await _fireStoreDataBase
        .collection("Addresses")
        .doc(idpost)
        .set(data, SetOptions(merge: true));
    return result;
  }

  Future<firebase_storage.UploadTask> uploadFileToFirestore(File file) async {
    firebase_storage.UploadTask uploadTask;

    // Create a Reference to the file
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('playground')
        .child('/' + file.name);

    final metadata = firebase_storage.SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': file.path});

    uploadTask = ref.putFile(io.File(file.path), metadata);

    return Future.value(uploadTask);
  }

  Future<void> settingUserPhotoLink(String linkPhoto) async {
    HashMap<String, String> hashMap = new HashMap<String, String>();
    hashMap["pic"] = linkPhoto;
    var value = await _fireStoreDataBase
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .set(hashMap, SetOptions(merge: true));

    return value;
  }

  Future<void> settinguseractive(bool isactive, Stringuserid) async {
    HashMap<String, bool> hashMap = new HashMap<String, bool>();
    hashMap["isactive"] = isactive;
    var value = await _fireStoreDataBase
        .collection("users")
        .doc(Stringuserid)
        .set(hashMap, SetOptions(merge: true));

    return value;
  }

  Future<void> AddingDataToArrayListUSer(
      List<dynamic> listarray, Stringuserid) async {
    var value = await _fireStoreDataBase
        .collection("users")
        .doc(Stringuserid)
        .update({"devicesList": FieldValue.arrayUnion(listarray)});

    return value;
  }

  Future<String> downloadLink(firebase_storage.Reference ref) async {
    final link = await ref.getDownloadURL();

    return link;
  }
}

extension FileExtention on FileSystemEntity {
  String get name {
    return this?.path?.split("/")?.last;
  }
}
