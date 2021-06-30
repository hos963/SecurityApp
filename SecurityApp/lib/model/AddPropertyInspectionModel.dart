import 'package:Metropolitane/model/FirebaseUserData.dart';
import 'package:Metropolitane/model/QuestionareModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'PropertyInspectionQuestionareModel.dart';

class AddPropertyInspectionModel {
  String inspectionId;
  String inspectionTitle;
  String inspectionDesc;
  String inspectionLocation;
  String type;
  bool isactive;
  int state = 1;
  PropertyInspectionQuestionareModel questionareModel;
  var futuretask;
  FirebaseUserData firebaseUserData;

  AddPropertyInspectionModel(
      {this.inspectionId,
      this.inspectionTitle,
      this.inspectionDesc,
      this.inspectionLocation,
      this.type,
      this.isactive,
      this.questionareModel,
      this.firebaseUserData,
      this.state,
      this.futuretask});

  factory AddPropertyInspectionModel.fromJson(Map<String, dynamic> parsedJson) {
    return AddPropertyInspectionModel(
        inspectionId: parsedJson['inspectionId'],
        inspectionTitle: parsedJson['inspectionTitle'],
        inspectionDesc: parsedJson['inspectionDesc'],
        inspectionLocation: parsedJson['inspectionLocation'],
        type: parsedJson['type'],
        questionareModel: parsedJson.containsKey("QuestionareModel")
            ? PropertyInspectionQuestionareModel.fromJson(
                parsedJson['QuestionareModel'])
            : null,
        isactive: parsedJson['isactive'],
        futuretask: parsedJson['futuretask']);
  }

  factory AddPropertyInspectionModel.fromDoc(DocumentSnapshot doc) {
    return AddPropertyInspectionModel(
      inspectionId: doc.data()['inspectionId'],
      inspectionTitle: doc.data()['inspectionTitle'],
      inspectionDesc: doc.data()['inspectionDesc'],
      inspectionLocation: doc.data()['inspectionLocation'],
      type: doc.data()['type'],
      state: doc.data()['state'],
      questionareModel: doc.data().containsKey("QuestionareModel")
          ? PropertyInspectionQuestionareModel.fromJson(
              doc.data()['QuestionareModel'])
          : null,
      firebaseUserData: doc.data().containsKey("firebaseUserData")
          ? FirebaseUserData.fromJson(doc.data()['firebaseUserData'])
          : null,
      isactive: doc.data()['isactive'],
      futuretask: doc.data()['futuretask'],
    );
  }

  Map<String, dynamic> AddPropertyInspectionAlertTopMap(
      {bool isupdate = false}) {
    Map<String, dynamic> map = new Map();

    map['inspectionId'] = this.inspectionId;
    map['inspectionTitle'] = this.inspectionTitle;
    map['inspectionDesc'] = this.inspectionDesc;
    map['inspectionLocation'] = this.inspectionLocation;
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
