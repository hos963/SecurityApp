import 'package:Metropolitane/MobileApp/MobileapQuestions/FillSurvayQuestions/Questions/MessageOnPanelScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LockQuestionareModel {

  OnwayModel onwayModel;
  ReachedonSiteModel reachedonSiteModel;
  bool havekeys;
  ExternalPictureOfBuildingModel externalPictureOfBuildingModel;
  bool doorsAndWindowsSecured;
  InternalPictureOfBuildingModel internalPictureOfBuildingModel;
  bool alarmedAndSecured;
  String messageOnPanel;
  LeaveBuildingModel leaveBuildingModel;




  LockQuestionareModel(
      {
        this.onwayModel,
        this.reachedonSiteModel,
        this.havekeys,
        this.externalPictureOfBuildingModel,
        this.doorsAndWindowsSecured,
        this.internalPictureOfBuildingModel,
        this.alarmedAndSecured,
        this.messageOnPanel,
        this.leaveBuildingModel,



        });

  factory LockQuestionareModel.fromJson(Map<String, dynamic> parsedJson) {
    return LockQuestionareModel(

      onwayModel:  parsedJson.containsKey('onwayModel')? OnwayModel.fromJson(parsedJson['onwayModel']) : null,
      reachedonSiteModel:  parsedJson.containsKey('reachedonSiteModel')? ReachedonSiteModel.fromJson(parsedJson['reachedonSiteModel']) : null,
      havekeys: parsedJson['havekeys'],
      externalPictureOfBuildingModel:  parsedJson.containsKey('externalPictureOfBuildingModel')? ExternalPictureOfBuildingModel.fromJson(parsedJson['externalPictureOfBuildingModel']) : null,
      doorsAndWindowsSecured:parsedJson['doorsAndWindowsSecured'],
      internalPictureOfBuildingModel:  parsedJson.containsKey('internalPictureOfBuildingModel')? InternalPictureOfBuildingModel.fromJson(parsedJson['internalPictureOfBuildingModel']) : null,
      alarmedAndSecured:parsedJson['alarmedAndSecured'],
      messageOnPanel: parsedJson['messageOnPanel'],
      leaveBuildingModel:  parsedJson.containsKey('leaveBuildingModel')? LeaveBuildingModel.fromJson(parsedJson['leaveBuildingModel']) : null,

    );
  }


  Map<String ,dynamic>  AddLockOnthewayToMap(){
    Map<String,dynamic> map = new Map();
    Map<String,dynamic> onallmapp = new Map();
    onallmapp["onwayModel"] =  onwayModel.AdonwayModelToMap();
    map['QuestionareModel'] =onallmapp;

    return map;
  }
  Map<String ,dynamic>  AddReachedonSiteModel(){
    Map<String,dynamic> map = new Map();
    Map<String,dynamic> onallmapp = new Map();
    onallmapp["reachedonSiteModel"] =  reachedonSiteModel.AdreachedyModelToMap();
    map['QuestionareModel'] =onallmapp;

    return map;
  }
  Map<String ,dynamic>  MessageOnPanelToMap(){
    Map<String,dynamic> map = new Map();
    Map<String,dynamic> onallmapp = new Map();
    onallmapp["messageOnPanel"] =  messageOnPanel;
    map['QuestionareModel'] =onallmapp;

    return map;
  }

  Map<String ,dynamic>  HaveKeyToMapModel(){
    Map<String,dynamic> map = new Map();
    Map<String,dynamic> onallmapp = new Map();
    onallmapp["havekeys"] =  havekeys;
    map['QuestionareModel'] =onallmapp;

    return map;
  }

  Map<String ,dynamic>  AlarmedAndSecured(){
    Map<String,dynamic> map = new Map();
    Map<String,dynamic> onallmapp = new Map();
    onallmapp["alarmedAndSecured"] =  alarmedAndSecured;
    map['QuestionareModel'] =onallmapp;

    return map;
  }

  Map<String ,dynamic>  isWindowAndDoorSecuredLock(){
    Map<String,dynamic> map = new Map();
    Map<String,dynamic> onallmapp = new Map();
    onallmapp["isWindowAndDoorSecuredLock"] =  doorsAndWindowsSecured;
    map['QuestionareModel'] =onallmapp;

    return map;
  }


  Map<String ,dynamic>  ExternalPictureOfBuildingModeltoMap(){
    Map<String,dynamic> map = new Map();
    Map<String,dynamic> onallmapp = new Map();
    onallmapp["externalPictureOfBuildingModel"] =  externalPictureOfBuildingModel.AdonwayModelToMap();
    map['QuestionareModel'] =onallmapp;

    return map;
  }

  Map<String ,dynamic>  InternakPictureOfBuildingModeltoMap(){
    Map<String,dynamic> map = new Map();
    Map<String,dynamic> onallmapp = new Map();
    onallmapp["internalPictureOfBuildingModel"] =  internalPictureOfBuildingModel.AdonwayModelToMap();
    map['QuestionareModel'] =onallmapp;

    return map;
  }


 /* Map<String ,dynamic>  UnsetAlarmtoMap(){
    Map<String,dynamic> map = new Map();
    Map<String,dynamic> onallmapp = new Map();
    onallmapp["unsetAlarmModel"] =  areyouabletounsetAlarmModel.AdonwayModelToMap();
    map['QuestionareModel'] =onallmapp;

    return map;
  }*/

/*  Map<String ,dynamic> setAlarmtoMap(){
    Map<String,dynamic> map = new Map();
    Map<String,dynamic> onallmapp = new Map();
    onallmapp["setAlarmModel"] =  areyouabletosetAlarmModel.AdonwayModelToMap();
    map['QuestionareModel'] =onallmapp;

    return map;
  }*/


/*  Map<String ,dynamic> picAlarmPaneltoMap(){
    Map<String,dynamic> map = new Map();
    Map<String,dynamic> onallmapp = new Map();
    onallmapp["pictureOfAlarmPanelModel"] =  pictureOfAlarmPanelModel.AdonwayModelToMap();
    map['QuestionareModel'] =onallmapp;

    return map;
  }*/

 /* Map<String ,dynamic> actionTakenToMap(){
    Map<String,dynamic> map = new Map();
    Map<String,dynamic> onallmapp = new Map();
    onallmapp["actionTaken"] =  actionTaken;
    map['QuestionareModel'] =onallmapp;

    return map;
  }*/


  Map<String ,dynamic> LeaveBuildingtoMap(){
    Map<String,dynamic> map = new Map();
    Map<String,dynamic> onallmapp = new Map();
    onallmapp["leaveBuildingModel"] =  leaveBuildingModel.AdonwayModelToMap();
    map['QuestionareModel'] =onallmapp;

    return map;
  }


}

class OnwayModel {
  bool ontheWay;
  Timestamp onawytimestamp;

  OnwayModel({this.ontheWay, this.onawytimestamp});

  Map<String, dynamic> AdonwayModelToMap() {
    Map<String, dynamic> map = new Map();
    map['ontheWay'] = ontheWay;

    map['onawytimestamp'] = FieldValue.serverTimestamp();
    return map;
  }

  factory OnwayModel.fromJson(Map<String, dynamic> parsedJson) {
    return OnwayModel(
      ontheWay: parsedJson['ontheWay'],
      onawytimestamp: parsedJson['onawytimestamp'],
    );
  }
}

class ReachedonSiteModel {
  bool reachedonsite;
  Timestamp reachedtimestamp;

  ReachedonSiteModel({this.reachedonsite, this.reachedtimestamp});

  Map<String, dynamic> AdreachedyModelToMap() {
    Map<String, dynamic> map = new Map();
    map['reachedonsite'] = reachedonsite;

    map['reachedtimestamp'] = FieldValue.serverTimestamp();
    return map;
  }

  factory ReachedonSiteModel.fromJson(Map<String, dynamic> parsedJson) {
    return ReachedonSiteModel(
      reachedonsite: parsedJson['reachedonsite'],
      reachedtimestamp: parsedJson['reachedtimestamp'],
    );
  }
}

class ExternalPictureOfBuildingModel {
  String externalbuildingpic;
  Timestamp timestampextpic;

  ExternalPictureOfBuildingModel(
      {this.externalbuildingpic, this.timestampextpic});

  Map<String, dynamic> AdonwayModelToMap() {
    Map<String, dynamic> map = new Map();
    map['externalbuildingpic'] = externalbuildingpic;

    map['timestampextpic'] = FieldValue.serverTimestamp();
    return map;
  }

  factory ExternalPictureOfBuildingModel.fromJson(
      Map<String, dynamic> parsedJson) {
    return ExternalPictureOfBuildingModel(
      externalbuildingpic: parsedJson['externalbuildingpic'],
      timestampextpic: parsedJson['timestampextpic'],
    );
  }
}

class InternalPictureOfBuildingModel {
  String internalbuildingpic;
  Timestamp timestamp;

  InternalPictureOfBuildingModel({this.internalbuildingpic, this.timestamp});

  Map<String, dynamic> AdonwayModelToMap() {
    Map<String, dynamic> map = new Map();
    map['internalbuildingpic'] = internalbuildingpic;

    map['timestamp'] = FieldValue.serverTimestamp();
    return map;
  }

  factory InternalPictureOfBuildingModel.fromJson(
      Map<String, dynamic> parsedJson) {
    return InternalPictureOfBuildingModel(
      internalbuildingpic: parsedJson['internalbuildingpic'],
      timestamp: parsedJson['timestamp'],
    );
  }
}

class LeaveBuildingModel {
  bool leavebuilding;
  Timestamp timestamp;

  LeaveBuildingModel({this.leavebuilding, this.timestamp});

  Map<String, dynamic> AdonwayModelToMap() {
    Map<String, dynamic> map = new Map();
    map['leavebuilding'] = leavebuilding;

    map['timestamp'] = FieldValue.serverTimestamp();
    return map;
  }

  factory LeaveBuildingModel.fromJson(Map<String, dynamic> parsedJson) {
    return LeaveBuildingModel(
      leavebuilding: parsedJson['leavebuilding'],
      timestamp: parsedJson['timestamp'],
    );
  }
}
