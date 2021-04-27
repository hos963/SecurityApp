import 'package:Metropolitane/model/FirebaseUserData.dart';
import 'package:Metropolitane/model/QuestionareModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddPatrolModel {
  String patrolId;
  String patrolTitle;
  String patrolDesc;
  String patrolLocation;
  bool isactive;
  int state = 1;
  QuestionareModel questionareModel;

  FirebaseUserData firebaseUserData;

  AddPatrolModel(
      {this.patrolId,
        this.patrolTitle,
        this.patrolDesc,
        this.patrolLocation,
        this.isactive,
        this.questionareModel,this.firebaseUserData,this.state});

  factory AddPatrolModel.fromJson(Map<String, dynamic> parsedJson) {
    return AddPatrolModel(
      patrolId: parsedJson['patrolId'],
      patrolTitle: parsedJson['patrolTitle'],
      patrolDesc: parsedJson['patrolDesc'],
      patrolLocation: parsedJson['patrolLocation'],
      questionareModel: parsedJson.containsKey("QuestionareModel")
          ? QuestionareModel.fromJson(parsedJson['QuestionareModel'])
          : null,
      isactive: parsedJson['isactive'],
    );
  }

  factory AddPatrolModel.fromDoc(DocumentSnapshot doc) {
    return AddPatrolModel(
      patrolId: doc.data()['patrolId'],
      patrolTitle: doc.data()['patrolTitle'],
      patrolDesc: doc.data()['patrolDesc'],
      patrolLocation: doc.data()['patrolLocation'],
      state: doc.data()['state'],
      questionareModel: doc.data().containsKey("QuestionareModel")
          ? QuestionareModel.fromJson(doc.data()['QuestionareModel'])
          : null,

      firebaseUserData: doc.data().containsKey("firebaseUserData")
          ? FirebaseUserData.fromJson(doc.data()['firebaseUserData'])
          : null,

      isactive: doc.data()['isactive'],
    );
  }


  Map<String ,dynamic>  AddPatrolTopMap({bool isupdate = false}){
    Map<String,dynamic> map = new Map();

    map['patrolId'] = this.patrolId;
    map['patrolTitle'] = this.patrolTitle;
    map['patrolDesc'] = this.patrolDesc;
    map['patrolLocation'] = this.patrolLocation;
    map['isactive'] = true;
    map['firebaseUserData'] = this.firebaseUserData.FirebaseUSertoMap(this.firebaseUserData);
    map['state'] = this.state;
    if(isupdate == false) {
      map['timestamp'] = FieldValue.serverTimestamp();
    }
    return map;
  }




}
