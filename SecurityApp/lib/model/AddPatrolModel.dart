import 'package:Metropolitane/model/FirebaseUserData.dart';
import 'package:Metropolitane/model/QuestionareModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'PatrolQuestionareModel.dart';

class AddPatrolModel {
  String patrolId;
  String patrolTitle;
  String patrolDesc;
  String latlong;
  String type;
  bool isactive;
  int state = 1;
  PatrolQuestionareModel questionareModel;
  var futuretask;
  String Lat;
  String Long;
  FirebaseUserData firebaseUserData;


  AddPatrolModel(
      {this.patrolId,
      this.patrolTitle,
      this.patrolDesc,
      this.latlong,
      this.type,
      this.isactive,
      this.questionareModel,
      this.firebaseUserData,
      this.state,
      this.futuretask,
      this.Lat,
      this.Long,});

  factory AddPatrolModel.fromJson(Map<String, dynamic> parsedJson) {
    return AddPatrolModel(
      patrolId: parsedJson['patrolId'],
      patrolTitle: parsedJson['patrolTitle'],
      patrolDesc: parsedJson['patrolDesc'],
      latlong: parsedJson['latlong'],
      type: parsedJson['type'],
      questionareModel: parsedJson.containsKey("QuestionareModel")
          ? PatrolQuestionareModel.fromJson(parsedJson['QuestionareModel'])
          : null,
      isactive: parsedJson['isactive'],
      futuretask: parsedJson['futuretask'],
      Lat: parsedJson['Lat'],
      Long: parsedJson['Long'],
    );
  }

  factory AddPatrolModel.fromDoc(DocumentSnapshot doc) {
    return AddPatrolModel(
      patrolId: doc.data()['patrolId'],
      patrolTitle: doc.data()['patrolTitle'],
      patrolDesc: doc.data()['patrolDesc'],
      latlong: doc.data()['latlong'],
      type: doc.data()['type'],
      state: doc.data()['state'],
      questionareModel: doc.data().containsKey("QuestionareModel")
          ? PatrolQuestionareModel.fromJson(doc.data()['QuestionareModel'])
          : null,
      firebaseUserData: doc.data().containsKey("firebaseUserData")
          ? FirebaseUserData.fromJson(doc.data()['firebaseUserData'])
          : null,
      isactive: doc.data()['isactive'],
      futuretask: doc.data()['futuretask'],
      Lat: doc.data()['Lat'],
      Long: doc.data()['Long'],
    );
  }

  Map<String, dynamic> AddPatrolTopMap({bool isupdate = false}) {
    Map<String, dynamic> map = new Map();

    map['patrolId'] = this.patrolId;
    map['patrolTitle'] = this.patrolTitle;
    map['patrolDesc'] = this.patrolDesc;
    map['latlong'] = this.latlong;
    map['type'] = this.type;
    map['isactive'] = true;
    map['firebaseUserData'] =
        this.firebaseUserData.FirebaseUSertoMap(this.firebaseUserData);
    map['state'] = this.state;
    map['futuretask'] = this.futuretask;
    map['Lat'] = this.Lat;
    map['Long'] = this.Long;
    if (isupdate == false) {
      map['timestamp'] = FieldValue.serverTimestamp();
    }
    return map;
  }
}
