import 'package:Metropolitane/model/FirebaseUserData.dart';
import 'package:Metropolitane/model/LockQuestionareModel.dart';
import 'package:Metropolitane/model/QuestionareModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddLockModel {
  String lockId;
  String lockTitle;
  String lockDesc;
  String latlong;
  String type;
  bool isactive;
  int state = 1;
  LockQuestionareModel questionareModel;
  var futuretask;
  FirebaseUserData firebaseUserData;

  AddLockModel(
      {this.lockId,
      this.lockTitle,
      this.lockDesc,
      this.latlong,
      this.type,
      this.isactive,
      this.questionareModel,
      this.firebaseUserData,
      this.state,
      this.futuretask});

  factory AddLockModel.fromJson(Map<String, dynamic> parsedJson) {
    return AddLockModel(
      lockId: parsedJson['lockId'],
      lockTitle: parsedJson['lockTitle'],
      lockDesc: parsedJson['lockDesc'],
      latlong: parsedJson['latlong'],
      type: parsedJson['type'],
      questionareModel: parsedJson.containsKey("QuestionareModel")
          ? LockQuestionareModel.fromJson(parsedJson['QuestionareModel'])
          : null,
      isactive: parsedJson['isactive'],
      futuretask: parsedJson['futuretask'],
    );
  }

  factory AddLockModel.fromDoc(DocumentSnapshot doc) {
    return AddLockModel(
      lockId: doc.data()['lockId'],
      lockTitle: doc.data()['lockTitle'],
      lockDesc: doc.data()['lockDesc'],
      latlong: doc.data()['latlong'],
      type: doc.data()['type'],
      state: doc.data()['state'],
      questionareModel: doc.data().containsKey("QuestionareModel")
          ? LockQuestionareModel.fromJson(doc.data()['QuestionareModel'])
          : null,
      firebaseUserData: doc.data().containsKey("firebaseUserData")
          ? FirebaseUserData.fromJson(doc.data()['firebaseUserData'])
          : null,
      isactive: doc.data()['isactive'],
      futuretask: doc.data()['futuretask'],
    );
  }

  Map<String, dynamic> AddLockTopMap({bool isupdate = false}) {
    Map<String, dynamic> map = new Map();

    map['lockId'] = this.lockId;
    map['lockTitle'] = this.lockTitle;
    map['lockDesc'] = this.lockDesc;
    map['latlong'] = this.latlong;
    map['type'] = this.type;
    map['isactive'] = true;
    map['firebaseUserData'] =
        this.firebaseUserData.FirebaseUSertoMap(this.firebaseUserData);
    map['state'] = this.state;
    map['futuretask'] = this.futuretask;
    if (isupdate == false) {
      map['timestamp'] = FieldValue.serverTimestamp();
    }
    return map;
  }
}
