import 'package:Metropolitane/model/FirebaseUserData.dart';
import 'package:Metropolitane/model/QuestionareModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'PatrolQuestionareModel.dart';

class QRCodesModel {

  String QrId;
  String latitude;
  String longitude;


  QRCodesModel(
      {this.QrId,
        this.latitude,
        this.longitude,});

  factory QRCodesModel.fromJson(Map<String, dynamic> parsedJson) {
    return QRCodesModel(
      QrId: parsedJson['qrId'],
      latitude: parsedJson['latitude'],
      longitude: parsedJson['longitude'],

    );
  }

  factory QRCodesModel.fromDoc(DocumentSnapshot doc) {
    return QRCodesModel(
      QrId: doc.data()['qrId'],
      latitude: doc.data()['latitude'],
      longitude: doc.data()['longitude'],

    );
  }

  Map<String, dynamic> AddPatrolTopMap({bool isupdate = false}) {
    Map<String, dynamic> map = new Map();

    map['qrId'] = this.QrId;
    map['latitude'] = this.latitude;
    map['longitude'] = this.longitude;

  }
}
