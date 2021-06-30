import 'package:Metropolitane/MobileApp/MobileapQuestions/FillSurvayQuestions/Questions/MessageOnPanelScreen.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/PatrolSurveyQuestion/Questions/ExternalPatrolDone.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/PatrolSurveyQuestion/Questions/IsBuildingPresent.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PatrolQuestionareModel {

  OnwayModel onwayModel;
  ReachedonSiteModel reachedonSiteModel;
  bool externalpatroldone;
  bool isBuildingPresent;
  TakePictureOfBuildingModel externalPictureOfBuildingModel;
  bool havekeys;
  TakePictureOfKey takePictureOfKeys;
  Take2ndPictureOfKey take2ndPictureOfKeys;
  Take3rdPictureOfKey take3rdPictureOfKeys;
  Take4thPictureOfKey taker4thPictureOfKeys;
  Take5thPictureOfKey taker5thPictureOfKeys;

  Take1stPitcure taker1thPicture;
  Take2ndPitcure taker2ndPicture;

  bool dokeygiveAccess;
  bool alarmUnset;
  InternalPictureOfBuildingModel internalPictureOfBuildingModel;
  InternalFirstPictureOfBuildingModel internalFirstPictureOfBuildingModel;
  InternalSecondPictureOfBuildingModel internalSecondPictureOfBuildingModel;
  InternalThirdPictureOfBuildingModel internalThirdPictureOfBuildingModel;
  InternalFourthPictureOfBuildingModel internalFourthPictureOfBuildingModel;
  String specialInstruction;
  LockAndAlarmed lockAndAlarmed;
  LeaveBuildingModel leaveBuildingModel;
  bool actionTaken;


  PatrolQuestionareModel(
  {this.onwayModel,
    this.reachedonSiteModel,
    this.externalpatroldone,
    this.isBuildingPresent,
    this.externalPictureOfBuildingModel,
    this.havekeys,
    this.takePictureOfKeys,
    this.take2ndPictureOfKeys,
    this.take3rdPictureOfKeys,
    this.taker4thPictureOfKeys,
    this.taker5thPictureOfKeys,
    this.taker1thPicture,
    this.taker2ndPicture,
    this.dokeygiveAccess,
    this.alarmUnset,
    this.internalPictureOfBuildingModel,
    this.internalFirstPictureOfBuildingModel,
    this.internalSecondPictureOfBuildingModel,
    this.internalThirdPictureOfBuildingModel,
    this.internalFourthPictureOfBuildingModel,
    this.specialInstruction,
    this.lockAndAlarmed,
    this.leaveBuildingModel,
    this.actionTaken});

  factory PatrolQuestionareModel.fromJson(Map<String, dynamic> parsedJson) {
    return PatrolQuestionareModel(

      onwayModel:  parsedJson.containsKey('onwayModel')? OnwayModel.fromJson(parsedJson['onwayModel']) : null,
      reachedonSiteModel:  parsedJson.containsKey('reachedonSiteModel')? ReachedonSiteModel.fromJson(parsedJson['reachedonSiteModel']) : null,
      externalpatroldone: parsedJson['externalpatroldone'],
      isBuildingPresent: parsedJson['isBuildingPresent'],
      externalPictureOfBuildingModel:  parsedJson.containsKey('externalbuildingpic')? TakePictureOfBuildingModel.fromJson(parsedJson['externalbuildingpic']) : null,
      havekeys: parsedJson['havekeys'],
      takePictureOfKeys:  parsedJson.containsKey('takePictureOfKeys')? TakePictureOfKey.fromJson(parsedJson['takePictureOfKeys']) : null,
      take2ndPictureOfKeys:  parsedJson.containsKey('take2ndPictureOfKeys')? Take2ndPictureOfKey.fromJson(parsedJson['take2ndPictureOfKeys']) : null,
      take3rdPictureOfKeys:  parsedJson.containsKey('take3rdPictureOfKeys')? Take3rdPictureOfKey.fromJson(parsedJson['take3rdPictureOfKeys']) : null,
      taker4thPictureOfKeys:  parsedJson.containsKey('taker4thPictureOfKeys')? Take4thPictureOfKey.fromJson(parsedJson['taker4thPictureOfKeys']) : null,
      taker5thPictureOfKeys:  parsedJson.containsKey('taker5thPictureOfKeys')? Take5thPictureOfKey.fromJson(parsedJson['taker5thPictureOfKeys']) : null,
      taker1thPicture:  parsedJson.containsKey('taker1thPicture')? Take1stPitcure.fromJson(parsedJson['taker1thPicture']) : null,

      dokeygiveAccess: parsedJson['dokeygiveAccess'],

      alarmUnset: parsedJson['AlarmUnset'],
      internalPictureOfBuildingModel:  parsedJson.containsKey('internalPictureOfBuildingModel')? InternalPictureOfBuildingModel.fromJson(parsedJson['internalPictureOfBuildingModel']) : null,
      internalFirstPictureOfBuildingModel:  parsedJson.containsKey('internalFirstPictureOfBuildingModel')? InternalFirstPictureOfBuildingModel.fromJson(parsedJson['internalFirstPictureOfBuildingModel']) : null,
      internalSecondPictureOfBuildingModel:  parsedJson.containsKey('internalSecondPictureOfBuildingModel')? InternalSecondPictureOfBuildingModel.fromJson(parsedJson['internalSecondPictureOfBuildingModel']) : null,
      internalThirdPictureOfBuildingModel:  parsedJson.containsKey('internalThirdPictureOfBuildingModel')? InternalThirdPictureOfBuildingModel.fromJson(parsedJson['internalThirdPictureOfBuildingModel']) : null,
      internalFourthPictureOfBuildingModel:  parsedJson.containsKey('internalFourthPictureOfBuildingModel')? InternalFourthPictureOfBuildingModel.fromJson(parsedJson['internalFourthPictureOfBuildingModel']) : null,
      specialInstruction: parsedJson['specialInstruction'],

      lockAndAlarmed:  parsedJson.containsKey('setAlarmModel')? LockAndAlarmed.fromJson(parsedJson['setAlarmModel']) : null,

      leaveBuildingModel:  parsedJson.containsKey('leaveBuildingModel')? LeaveBuildingModel.fromJson(parsedJson['leaveBuildingModel']) : null,

      actionTaken: parsedJson['actionTaken'],




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
  Map<String ,dynamic>  SpecialInstructionToMap(){
    Map<String,dynamic> map = new Map();
    Map<String,dynamic> onallmapp = new Map();
    onallmapp["specialInstruction"] =  specialInstruction;
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

  Map<String ,dynamic>  ExternalPatrolDone(){
    Map<String,dynamic> map = new Map();
    Map<String,dynamic> onallmapp = new Map();
    onallmapp["externalpatroldone"] =  externalpatroldone;
    map['QuestionareModel'] = onallmapp;
    return map;
  }

  Map<String ,dynamic>  IsBuildingPresent(){
    Map<String,dynamic> map = new Map();
    Map<String,dynamic> onallmapp = new Map();
    onallmapp["isBuildingPresent"] =  isBuildingPresent;
    map['QuestionareModel'] =onallmapp;

    return map;
  }

    Map<String ,dynamic>  dokeygiveAccessToMapModel(){
    Map<String,dynamic> map = new Map();
    Map<String,dynamic> onallmapp = new Map();
    onallmapp["dokeygiveAccess"] =  dokeygiveAccess;
    map['QuestionareModel'] =onallmapp;

    return map;
  }
    Map<String ,dynamic>  alarmUnsetToMapModel(){
    Map<String,dynamic> map = new Map();
    Map<String,dynamic> onallmapp = new Map();
    onallmapp["AlarmUnset"] =  alarmUnset;
    map['QuestionareModel'] =onallmapp;

    return map;
  }


  Map<String ,dynamic>  TakePictureOfBuildingModeltoMap(){
    Map<String,dynamic> map = new Map();
    Map<String,dynamic> onallmapp = new Map();
    onallmapp["externalbuildingpic"] =  externalPictureOfBuildingModel.AdonwayModelToMap();
    map['QuestionareModel'] =onallmapp;

    return map;
  }

  Map<String ,dynamic>  TakePictureOfKeystoMap(){
    Map<String,dynamic> map = new Map();
    Map<String,dynamic> onallmapp = new Map();
    onallmapp["takePictureOfKeys"] =  takePictureOfKeys.AdonwayModelToMap();
    map['QuestionareModel'] =onallmapp;

    return map;
  }

  Map<String ,dynamic>  Take2ndPictureOfKeystoMap(){
    Map<String,dynamic> map = new Map();
    Map<String,dynamic> onallmapp = new Map();
    onallmapp["take2ndPictureOfKeys"] =  take2ndPictureOfKeys.AdonwayModelToMap();
    map['QuestionareModel'] =onallmapp;

    return map;
  }

  Map<String ,dynamic>  Take3rdPictureOfKeystoMap(){
    Map<String,dynamic> map = new Map();
    Map<String,dynamic> onallmapp = new Map();
    onallmapp["take3rdPictureOfKeys"] =  take3rdPictureOfKeys.AdonwayModelToMap();
    map['QuestionareModel'] =onallmapp;

    return map;
  }

  Map<String ,dynamic>  Take4thPictureOfKeystoMap(){
    Map<String,dynamic> map = new Map();
    Map<String,dynamic> onallmapp = new Map();
    onallmapp["taker4thPictureOfKeys"] =  taker4thPictureOfKeys.AdonwayModelToMap();
    map['QuestionareModel'] =onallmapp;

    return map;
  }

  Map<String ,dynamic>  Take5thPictureOfKeystoMap(){
    Map<String,dynamic> map = new Map();
    Map<String,dynamic> onallmapp = new Map();
    onallmapp["taker5thPictureOfKeys"] =  taker5thPictureOfKeys.AdonwayModelToMap();
    map['QuestionareModel'] =onallmapp;

    return map;
  }

  Map<String ,dynamic>  Take1stPicture(){
    Map<String,dynamic> map = new Map();
    Map<String,dynamic> onallmapp = new Map();
    onallmapp["taker1thPicture"] =  taker1thPicture.AdonwayModelToMap();
    map['QuestionareModel'] =onallmapp;

    return map;
  }

  Map<String ,dynamic>  InternalPictureOfBuildingModeltoMap(){
    Map<String,dynamic> map = new Map();
    Map<String,dynamic> onallmapp = new Map();
    onallmapp["internalPictureOfBuildingModel"] =  internalPictureOfBuildingModel.AdonwayModelToMap();
    map['QuestionareModel'] =onallmapp;

    return map;
  }

  Map<String ,dynamic>  InternalFirstPictureOfBuildingModeltoMap(){
    Map<String,dynamic> map = new Map();
    Map<String,dynamic> onallmapp = new Map();
    onallmapp["internalFirstPictureOfBuildingModel"] =  internalFirstPictureOfBuildingModel.AdonwayModelToMap();
    map['QuestionareModel'] =onallmapp;

    return map;
  }
  Map<String ,dynamic>  InternalSecondPictureOfBuildingModeltoMap(){
    Map<String,dynamic> map = new Map();
    Map<String,dynamic> onallmapp = new Map();
    onallmapp["internalSecondPictureOfBuildingModel"] =  internalSecondPictureOfBuildingModel.AdonwayModelToMap();
    map['QuestionareModel'] =onallmapp;

    return map;
  }

  Map<String ,dynamic>  InternalThirdPictureOfBuildingModeltoMap(){
    Map<String,dynamic> map = new Map();
    Map<String,dynamic> onallmapp = new Map();
    onallmapp["internalThirdPictureOfBuildingModel"] =  internalThirdPictureOfBuildingModel.AdonwayModelToMap();
    map['QuestionareModel'] =onallmapp;

    return map;
  }

  Map<String ,dynamic>  InternalFourthPictureOfBuildingModeltoMap(){
    Map<String,dynamic> map = new Map();
    Map<String,dynamic> onallmapp = new Map();
    onallmapp["internalFourthPictureOfBuildingModel"] =  internalFourthPictureOfBuildingModel.AdonwayModelToMap();
    map['QuestionareModel'] =onallmapp;

    return map;
  }



  Map<String ,dynamic> lockAndAlarmedtoMap(){
    Map<String,dynamic> map = new Map();
    Map<String,dynamic> onallmapp = new Map();
    onallmapp["setAlarmModel"] =  lockAndAlarmed.AdonwayModelToMap();
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

class TakePictureOfBuildingModel {
  String externalbuildingpic;
  Timestamp timestampextpic;

  TakePictureOfBuildingModel(
      {this.externalbuildingpic, this.timestampextpic});

  Map<String, dynamic> AdonwayModelToMap() {
    Map<String, dynamic> map = new Map();
    map['externalbuildingpic'] = externalbuildingpic;

    map['timestampextpic'] = FieldValue.serverTimestamp();
    return map;
  }

  factory TakePictureOfBuildingModel.fromJson(
      Map<String, dynamic> parsedJson) {
    return TakePictureOfBuildingModel(
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

class LockAndAlarmed {
  bool setalarm;
  Timestamp timestamp;

  LockAndAlarmed({this.setalarm, this.timestamp});

  Map<String, dynamic> AdonwayModelToMap() {
    Map<String, dynamic> map = new Map();
    map['setalarm'] = setalarm;

    map['timestamp'] = FieldValue.serverTimestamp();
    return map;
  }

  factory LockAndAlarmed.fromJson(Map<String, dynamic> parsedJson) {
    return LockAndAlarmed(
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

class InternalFirstPictureOfBuildingModel {
  String internalbuildingpic;
  Timestamp timestamp;

  InternalFirstPictureOfBuildingModel({this.internalbuildingpic, this.timestamp});

  Map<String, dynamic> AdonwayModelToMap() {
    Map<String, dynamic> map = new Map();
    map['internalbuildingpic'] = internalbuildingpic;

    map['timestamp'] = FieldValue.serverTimestamp();
    return map;
  }

  factory InternalFirstPictureOfBuildingModel.fromJson(
      Map<String, dynamic> parsedJson) {
    return InternalFirstPictureOfBuildingModel(
      internalbuildingpic: parsedJson['internalbuildingpic'],
      timestamp: parsedJson['timestamp'],
    );
  }
}

class InternalSecondPictureOfBuildingModel {
  String internalbuildingpic;
  Timestamp timestamp;

  InternalSecondPictureOfBuildingModel({this.internalbuildingpic, this.timestamp});

  Map<String, dynamic> AdonwayModelToMap() {
    Map<String, dynamic> map = new Map();
    map['internalbuildingpic'] = internalbuildingpic;

    map['timestamp'] = FieldValue.serverTimestamp();
    return map;

  }

  factory InternalSecondPictureOfBuildingModel.fromJson(
      Map<String, dynamic> parsedJson) {
    return InternalSecondPictureOfBuildingModel(
      internalbuildingpic: parsedJson['internalbuildingpic'],
      timestamp: parsedJson['timestamp'],
    );
  }
}

class InternalThirdPictureOfBuildingModel {
  String internalbuildingpic;
  Timestamp timestamp;

  InternalThirdPictureOfBuildingModel({this.internalbuildingpic, this.timestamp});

  Map<String, dynamic> AdonwayModelToMap() {
    Map<String, dynamic> map = new Map();
    map['internalbuildingpic'] = internalbuildingpic;

    map['timestamp'] = FieldValue.serverTimestamp();
    return map;

  }

  factory InternalThirdPictureOfBuildingModel.fromJson(
      Map<String, dynamic> parsedJson) {
    return InternalThirdPictureOfBuildingModel(
      internalbuildingpic: parsedJson['internalbuildingpic'],
      timestamp: parsedJson['timestamp'],
    );
  }
}

class InternalFourthPictureOfBuildingModel {
  String internalbuildingpic;
  Timestamp timestamp;

  InternalFourthPictureOfBuildingModel({this.internalbuildingpic, this.timestamp});

  Map<String, dynamic> AdonwayModelToMap() {
    Map<String, dynamic> map = new Map();
    map['internalbuildingpic'] = internalbuildingpic;

    map['timestamp'] = FieldValue.serverTimestamp();
    return map;

  }

  factory InternalFourthPictureOfBuildingModel.fromJson(
      Map<String, dynamic> parsedJson) {
    return InternalFourthPictureOfBuildingModel(
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

class TakePictureOfKey {
  String takePictureOfKeys;
  Timestamp timestampextpic;

  TakePictureOfKey(
      {this.takePictureOfKeys, this.timestampextpic});

  Map<String, dynamic> AdonwayModelToMap() {
    Map<String, dynamic> map = new Map();
    map['takePictureOfKeys'] = takePictureOfKeys;

    map['timestampextpic'] = FieldValue.serverTimestamp();
    return map;
  }

  factory TakePictureOfKey.fromJson(
      Map<String, dynamic> parsedJson) {
    return TakePictureOfKey(
      takePictureOfKeys: parsedJson['takePictureOfKeys'],
      timestampextpic: parsedJson['timestampextpic'],
    );
  }
}


class Take2ndPictureOfKey {
  String take2ndPictureOfKeys;
  Timestamp timestampextpic;

  Take2ndPictureOfKey(
      {this.take2ndPictureOfKeys, this.timestampextpic});

  Map<String, dynamic> AdonwayModelToMap() {
    Map<String, dynamic> map = new Map();
    map['take2ndPictureOfKeys'] = take2ndPictureOfKeys;

    map['timestampextpic'] = FieldValue.serverTimestamp();
    return map;
  }

  factory Take2ndPictureOfKey.fromJson(
      Map<String, dynamic> parsedJson) {
    return Take2ndPictureOfKey(
      take2ndPictureOfKeys: parsedJson['take2ndPictureOfKeys'],
      timestampextpic: parsedJson['timestampextpic'],
    );
  }
}


class Take3rdPictureOfKey {
  String take3rdPictureOfKeys;
  Timestamp timestampextpic;

  Take3rdPictureOfKey(
      {this.take3rdPictureOfKeys, this.timestampextpic});

  Map<String, dynamic> AdonwayModelToMap() {
    Map<String, dynamic> map = new Map();
    map['take3rdPictureOfKeys'] = take3rdPictureOfKeys;

    map['timestampextpic'] = FieldValue.serverTimestamp();
    return map;
  }

  factory Take3rdPictureOfKey.fromJson(
      Map<String, dynamic> parsedJson) {
    return Take3rdPictureOfKey(
      take3rdPictureOfKeys: parsedJson['take3rdPictureOfKeys'],
      timestampextpic: parsedJson['timestampextpic'],
    );
  }
}


class Take4thPictureOfKey {
  String taker4thPictureOfKeys;
  Timestamp timestampextpic;

  Take4thPictureOfKey(
      {this.taker4thPictureOfKeys, this.timestampextpic});

  Map<String, dynamic> AdonwayModelToMap() {
    Map<String, dynamic> map = new Map();
    map['taker4thPictureOfKeys'] = taker4thPictureOfKeys;

    map['timestampextpic'] = FieldValue.serverTimestamp();
    return map;
  }

  factory Take4thPictureOfKey.fromJson(
      Map<String, dynamic> parsedJson) {
    return Take4thPictureOfKey(
      taker4thPictureOfKeys: parsedJson['taker4thPictureOfKeys'],
      timestampextpic: parsedJson['timestampextpic'],
    );
  }
}

class Take5thPictureOfKey {
  String taker5thPictureOfKeys;
  Timestamp timestampextpic;

  Take5thPictureOfKey(
      {this.taker5thPictureOfKeys, this.timestampextpic});

  Map<String, dynamic> AdonwayModelToMap() {
    Map<String, dynamic> map = new Map();
    map['taker5thPictureOfKeys'] = taker5thPictureOfKeys;

    map['timestampextpic'] = FieldValue.serverTimestamp();
    return map;
  }

  factory Take5thPictureOfKey.fromJson(
      Map<String, dynamic> parsedJson) {
    return Take5thPictureOfKey(
      taker5thPictureOfKeys: parsedJson['taker5thPictureOfKeys'],
      timestampextpic: parsedJson['timestampextpic'],
    );
  }
}


class Take1stPitcure {
  String taker1thPicture;
  Timestamp timestampextpic;

  Take1stPitcure(
      {this.taker1thPicture, this.timestampextpic});

  Map<String, dynamic> AdonwayModelToMap() {
    Map<String, dynamic> map = new Map();
    map['taker1thPicture'] = taker1thPicture;

    map['timestampextpic'] = FieldValue.serverTimestamp();
    return map;
  }

  factory Take1stPitcure.fromJson(
      Map<String, dynamic> parsedJson) {
    return Take1stPitcure(
      taker1thPicture: parsedJson['taker1thPicture'],
      timestampextpic: parsedJson['timestampextpic'],
    );
  }
}

class Take2ndPitcure {
  String taker2ndPicture;
  Timestamp timestampextpic;

  Take2ndPitcure(
      {this.taker2ndPicture, this.timestampextpic});

  Map<String, dynamic> AdonwayModelToMap() {
    Map<String, dynamic> map = new Map();
    map['taker2ndPicture'] = taker2ndPicture;

    map['timestampextpic'] = FieldValue.serverTimestamp();
    return map;
  }

  factory Take2ndPitcure.fromJson(
      Map<String, dynamic> parsedJson) {
    return Take2ndPitcure(
      taker2ndPicture: parsedJson['taker2ndPicture'],
      timestampextpic: parsedJson['timestampextpic'],
    );
  }
}

