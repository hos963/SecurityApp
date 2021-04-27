import 'package:Metropolitane/model/FirebaseUserData.dart';
import 'package:Metropolitane/model/QuestionareModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddAlarmModel {
  String alarmId;
  String alrmTitle;
  String alrmDesc;
  String alrmLocation;
  bool isactive;
  int state = 1;
  QuestionareModel questionareModel;

  FirebaseUserData firebaseUserData;

  AddAlarmModel(
      {this.alarmId,
      this.alrmTitle,
      this.alrmDesc,
      this.alrmLocation,
      this.isactive,
      this.questionareModel,this.firebaseUserData,this.state});

  factory AddAlarmModel.fromJson(Map<String, dynamic> parsedJson) {
    return AddAlarmModel(
      alarmId: parsedJson['alarmId'],
      alrmTitle: parsedJson['alrmTitle'],
      alrmDesc: parsedJson['alrmDesc'],
      alrmLocation: parsedJson['alrmLocation'],
      questionareModel: parsedJson.containsKey("QuestionareModel")
          ? QuestionareModel.fromJson(parsedJson['QuestionareModel'])
          : null,
      isactive: parsedJson['isactive'],
    );
  }

  factory AddAlarmModel.fromDoc(DocumentSnapshot doc) {
    return AddAlarmModel(
      alarmId: doc.data()['alarmId'],
      alrmTitle: doc.data()['alrmTitle'],
      alrmDesc: doc.data()['alrmDesc'],
      alrmLocation: doc.data()['alrmLocation'],
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


  Map<String ,dynamic>  AddAlrmToMap({bool isupdate = false}){
    Map<String,dynamic> map = new Map();

    map['alarmId'] = this.alarmId;
    map['alrmTitle'] = this.alrmTitle;
    map['alrmDesc'] = this.alrmDesc;
    map['alrmLocation'] = this.alrmLocation;
    map['isactive'] = true;
    map['firebaseUserData'] = this.firebaseUserData.FirebaseUSertoMap(this.firebaseUserData);
    map['state'] = this.state;
    if(isupdate == false) {
      map['timestamp'] = FieldValue.serverTimestamp();
    }
    return map;
  }




}
