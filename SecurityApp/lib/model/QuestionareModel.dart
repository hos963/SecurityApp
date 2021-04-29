import 'package:Metropolitane/MobileApp/MobileapQuestions/FillSurvayQuestions/Questions/MessageOnPanelScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionareModel {

  OnwayModel onwayModel;
  ReachedonSiteModel reachedonSiteModel;
  bool havekeys;
  ExternalPictureOfBuildingModel externalPictureOfBuildingModel;
  AreyouabletounsetAlarmModel areyouabletounsetAlarmModel;
  PictureOfAlarmPanelModel pictureOfAlarmPanelModel;
  String messageOnPanel;
  InternalPictureOfBuildingModel internalPictureOfBuildingModel;
  bool actionTaken;
  AreyouabletosetAlarmModel areyouabletosetAlarmModel;
  LeaveBuildingModel leaveBuildingModel;

  QuestionareModel(
      {this.havekeys,
      this.messageOnPanel,
      this.actionTaken,
      this.areyouabletosetAlarmModel,
      this.leaveBuildingModel,
      this.onwayModel,
      this.reachedonSiteModel,
      this.externalPictureOfBuildingModel,
      this.areyouabletounsetAlarmModel,
      this.pictureOfAlarmPanelModel,
      this.internalPictureOfBuildingModel});

  factory QuestionareModel.fromJson(Map<String, dynamic> parsedJson) {
    return QuestionareModel(

      onwayModel:  parsedJson.containsKey('onwayModel')? OnwayModel.fromJson(parsedJson['onwayModel']) : null,
      reachedonSiteModel:  parsedJson.containsKey('reachedonSiteModel')? ReachedonSiteModel.fromJson(parsedJson['reachedonSiteModel']) : null,
      externalPictureOfBuildingModel:  parsedJson.containsKey('externalPictureOfBuildingModel')? ExternalPictureOfBuildingModel.fromJson(parsedJson['externalPictureOfBuildingModel']) : null,
      havekeys: parsedJson['havekeys'],

      areyouabletounsetAlarmModel:  parsedJson.containsKey('unsetAlarmModel')? AreyouabletounsetAlarmModel.fromJson(parsedJson['unsetAlarmModel']) : null,
      pictureOfAlarmPanelModel:  parsedJson.containsKey('pictureOfAlarmPanelModel')? PictureOfAlarmPanelModel.fromJson(parsedJson['pictureOfAlarmPanelModel']) : null,
      messageOnPanel: parsedJson['messageOnPanel'],
      internalPictureOfBuildingModel:  parsedJson.containsKey('internalPictureOfBuildingModel')? InternalPictureOfBuildingModel.fromJson(parsedJson['internalPictureOfBuildingModel']) : null,
      actionTaken: parsedJson['actionTaken'],

      areyouabletosetAlarmModel:  parsedJson.containsKey('setAlarmModel')? AreyouabletosetAlarmModel.fromJson(parsedJson['setAlarmModel']) : null,

      leaveBuildingModel:  parsedJson.containsKey('leaveBuildingModel')? LeaveBuildingModel.fromJson(parsedJson['leaveBuildingModel']) : null,

    );
  }


  Map<String ,dynamic>  AddAlrmOnthewayToMap(){
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


  Map<String ,dynamic>  UnsetAlarmtoMap(){
    Map<String,dynamic> map = new Map();
    Map<String,dynamic> onallmapp = new Map();
    onallmapp["unsetAlarmModel"] =  areyouabletounsetAlarmModel.AdonwayModelToMap();
    map['QuestionareModel'] =onallmapp;

    return map;
  }

  Map<String ,dynamic> setAlarmtoMap(){
    Map<String,dynamic> map = new Map();
    Map<String,dynamic> onallmapp = new Map();
    onallmapp["setAlarmModel"] =  areyouabletosetAlarmModel.AdonwayModelToMap();
    map['QuestionareModel'] =onallmapp;

    return map;
  }


  Map<String ,dynamic> picAlarmPaneltoMap(){
    Map<String,dynamic> map = new Map();
    Map<String,dynamic> onallmapp = new Map();
    onallmapp["pictureOfAlarmPanelModel"] =  pictureOfAlarmPanelModel.AdonwayModelToMap();
    map['QuestionareModel'] =onallmapp;

    return map;
  }

  Map<String ,dynamic> actionTakenToMap(){
    Map<String,dynamic> map = new Map();
    Map<String,dynamic> onallmapp = new Map();
    onallmapp["actionTaken"] =  actionTaken;
    map['QuestionareModel'] =onallmapp;

    return map;
  }


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

class AreyouabletounsetAlarmModel {
  bool unsetalarm;
  Timestamp unsetalarmtimestamp;

  AreyouabletounsetAlarmModel({this.unsetalarm, this.unsetalarmtimestamp});

  Map<String, dynamic> AdonwayModelToMap() {
    Map<String, dynamic> map = new Map();
    map['unsetalarm'] = unsetalarm;

    map['unsetalarmtimestamp'] = FieldValue.serverTimestamp();
    return map;
  }

  factory AreyouabletounsetAlarmModel.fromJson(
      Map<String, dynamic> parsedJson) {
    return AreyouabletounsetAlarmModel(
      unsetalarm: parsedJson['unsetalarm'],
        unsetalarmtimestamp: parsedJson['unsetalarmtimestamp'],
    );
  }
}

class AreyouabletosetAlarmModel {
  bool setalarm;
  Timestamp timestamp;

  AreyouabletosetAlarmModel({this.setalarm, this.timestamp});

  Map<String, dynamic> AdonwayModelToMap() {
    Map<String, dynamic> map = new Map();
    map['setalarm'] = setalarm;

    map['timestamp'] = FieldValue.serverTimestamp();
    return map;
  }

  factory AreyouabletosetAlarmModel.fromJson(Map<String, dynamic> parsedJson) {
    return AreyouabletosetAlarmModel(
      setalarm: parsedJson['setalarm'],
        timestamp: parsedJson['timestamp'],
    );
  }
}

class PictureOfAlarmPanelModel {
  String picalarmpanel;
  Timestamp timestamp;

  PictureOfAlarmPanelModel({this.picalarmpanel, this.timestamp});

  Map<String, dynamic> AdonwayModelToMap() {
    Map<String, dynamic> map = new Map();
    map['picalarmpanel'] = picalarmpanel;

    map['timestamp'] = FieldValue.serverTimestamp();
    return map;
  }

  factory PictureOfAlarmPanelModel.fromJson(Map<String, dynamic> parsedJson) {
    return PictureOfAlarmPanelModel(
      picalarmpanel: parsedJson['picalarmpanel'],
        timestamp: parsedJson['timestamp'],
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
