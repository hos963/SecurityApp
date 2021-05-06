import 'package:Metropolitane/model/FirebaseUserData.dart';
import 'package:Metropolitane/model/QuestionareModel.dart';
import 'package:Metropolitane/model/UnLockQuestionareModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddUnlockModel {
  String unlockId;
  String unlockTitle;
  String unlockDesc;
  String unlockLocation;
  String type;
  bool isactive;
  int state = 1;
  UnLockQuestionareModel questionareModel;

  FirebaseUserData firebaseUserData;

  AddUnlockModel(
      {this.unlockId,
        this.unlockTitle,
        this.unlockDesc,
        this.unlockLocation,
        this.type,
        this.isactive,
        this.questionareModel,this.firebaseUserData,this.state});

  factory AddUnlockModel.fromJson(Map<String, dynamic> parsedJson) {
    return AddUnlockModel(
      unlockId: parsedJson['unlockId'],
      unlockTitle: parsedJson['unlockTitle'],
      unlockDesc: parsedJson['unlockDesc'],
      unlockLocation: parsedJson['unlockLocation'],
      type: parsedJson['type'],
      questionareModel: parsedJson.containsKey("QuestionareModel")
          ? UnLockQuestionareModel.fromJson(parsedJson['QuestionareModel'])
          : null,
      isactive: parsedJson['isactive'],
    );
  }

  factory AddUnlockModel.fromDoc(DocumentSnapshot doc) {
    return AddUnlockModel(
      unlockId: doc.data()['unlockId'],
      unlockTitle: doc.data()['unlockTitle'],
      unlockDesc: doc.data()['unlockDesc'],
      unlockLocation: doc.data()['unlockLocation'],
      type: doc.data()['type'],
      state: doc.data()['state'],
      questionareModel: doc.data().containsKey("QuestionareModel")
          ? UnLockQuestionareModel.fromJson(doc.data()['QuestionareModel'])
          : null,

      firebaseUserData: doc.data().containsKey("firebaseUserData")
          ? FirebaseUserData.fromJson(doc.data()['firebaseUserData'])
          : null,

      isactive: doc.data()['isactive'],
    );
  }


  Map<String ,dynamic>  AddUnLockTopMap({bool isupdate = false}){
    Map<String,dynamic> map = new Map();

    map['unlockId'] = this.unlockId;
    map['unlockTitle'] = this.unlockTitle;
    map['unlockDesc'] = this.unlockDesc;
    map['unlockLocation'] = this.unlockLocation;
    map['type'] = this.type;
    map['isactive'] = true;
    map['firebaseUserData'] = this.firebaseUserData.FirebaseUSertoMap(this.firebaseUserData);
    map['state'] = this.state;
    if(isupdate == false) {
      map['timestamp'] = FieldValue.serverTimestamp();
    }
    return map;
  }




}
