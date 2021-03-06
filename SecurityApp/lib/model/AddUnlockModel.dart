import 'package:Metropolitane/model/FirebaseUserData.dart';
import 'package:Metropolitane/model/QuestionareModel.dart';
import 'package:Metropolitane/model/UnLockQuestionareModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddUnlockModel {
  String unlockId;
  String unlockTitle;
  String unlockDesc;
  String latlong;
  String type;
  bool isactive;
  int state = 1;
  UnLockQuestionareModel questionareModel;
  var futuretask;
  FirebaseUserData firebaseUserData;

  AddUnlockModel(
      {this.unlockId,
      this.unlockTitle,
      this.unlockDesc,
      this.latlong,
      this.type,
      this.isactive,
      this.questionareModel,
      this.firebaseUserData,
      this.state,
      this.futuretask});

  factory AddUnlockModel.fromJson(Map<String, dynamic> parsedJson) {
    return AddUnlockModel(
      unlockId: parsedJson['unlockId'],
      unlockTitle: parsedJson['unlockTitle'],
      unlockDesc: parsedJson['unlockDesc'],
      latlong: parsedJson['latlong'],
      type: parsedJson['type'],
      questionareModel: parsedJson.containsKey("QuestionareModel")
          ? UnLockQuestionareModel.fromJson(parsedJson['QuestionareModel'])
          : null,
      isactive: parsedJson['isactive'],
      futuretask: parsedJson['futuretask'],
    );
  }

  factory AddUnlockModel.fromDoc(DocumentSnapshot doc) {
    return AddUnlockModel(
      unlockId: doc.data()['unlockId'],
      unlockTitle: doc.data()['unlockTitle'],
      unlockDesc: doc.data()['unlockDesc'],
      latlong: doc.data()['latlong'],
      type: doc.data()['type'],
      state: doc.data()['state'],
      questionareModel: doc.data().containsKey("QuestionareModel")
          ? UnLockQuestionareModel.fromJson(doc.data()['QuestionareModel'])
          : null,
      firebaseUserData: doc.data().containsKey("firebaseUserData")
          ? FirebaseUserData.fromJson(doc.data()['firebaseUserData'])
          : null,
      isactive: doc.data()['isactive'],
      futuretask: doc.data()['futuretask'],
    );
  }

  Map<String, dynamic> AddUnLockTopMap({bool isupdate = false}) {
    Map<String, dynamic> map = new Map();

    map['unlockId'] = this.unlockId;
    map['unlockTitle'] = this.unlockTitle;
    map['unlockDesc'] = this.unlockDesc;
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
