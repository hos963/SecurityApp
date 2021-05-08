import 'package:Metropolitane/MobileApp/MobileapQuestions/FillSurvayQuestions/Questions/MessageOnPanelScreen.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/PropertyInspectionQuestions/Questions/AnyIntrudersOutside.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PropertyInspectionQuestionareModel {

  OnwayModel onwayModel;
  ReachedonSiteModel reachedonSiteModel;
  ExternalImageScreenModel externalImageScreenModel;
  bool havekeys;
  bool isbuildingsecure;
  bool  isbuildinghasalarm;
  bool  anyWaterLeaking;
  bool  electricMeterPresent;
  ElectricMeterPictureModel electricMeterPictureModel;
  bool gasMeterPresent;
  GasMeterPictureModel gasMeterPictureModel;
  bool waterMeterPresent;
  WaterMeterPictureModel waterMeterPictureModel;
  bool  anyDamageToProperty;
  AnyDamageToPropertyPicModel anyDamageToPropertyPicModel;
  bool AnyIntrudersOutside;
  bool AnyWorkerOutside;
  bool AnyGraffitiNeedRemoval;
  bool AnyDrugUseOutside;
  bool AnyHealthAndSafetyIssues;
  Take1stInternalPicturesModel take1stInternalPicturesModel;
  Take2ndInternalPictureModel take2ndInternalPictureModel;
  Take3rdInternalPictureModel take3rdInternalPictureModel;
  Take4thInternalPictureModel take4thInternalPictureModel;
  Take5thInternalPictureModel take5thInternalPictureModel;
  String SpecificInstructions;
  JobCompletedModel jobCompletedModel;


  PropertyInspectionQuestionareModel(
  {
    this.onwayModel,
    this.reachedonSiteModel,
    this.externalImageScreenModel,
    this.havekeys,
    this.isbuildingsecure,
    this.isbuildinghasalarm,
    this.anyWaterLeaking,
    this.electricMeterPresent,
    this.electricMeterPictureModel,
    this.gasMeterPresent,
    this.gasMeterPictureModel,
    this.waterMeterPresent,
    this.waterMeterPictureModel,
    this.anyDamageToProperty,
    this.anyDamageToPropertyPicModel,
    this.AnyIntrudersOutside,
    this.AnyWorkerOutside,
    this.AnyGraffitiNeedRemoval,
    this.AnyDrugUseOutside,
    this.AnyHealthAndSafetyIssues,
    this.take1stInternalPicturesModel,
    this.take2ndInternalPictureModel,
    this.take3rdInternalPictureModel,
    this.take4thInternalPictureModel,
    this.take5thInternalPictureModel,
    this.SpecificInstructions,
    this.jobCompletedModel
}); // bool havekeys;
 // ExternalPictureOfBuildingModel externalPictureOfBuildingModel;
  // AreyouabletounsetAlarmModel areyouabletounsetAlarmModel;
  // PictureOfAlarmPanelModel pictureOfAlarmPanelModel;
  // String messageOnPanel;
  // InternalPictureOfBuildingModel internalPictureOfBuildingModel;
  // bool actionTaken;
  // AreyouabletosetAlarmModel areyouabletosetAlarmModel;
  // LeaveBuildingModel leaveBuildingModel;



  factory PropertyInspectionQuestionareModel.fromJson(Map<String, dynamic> parsedJson) {
    return PropertyInspectionQuestionareModel(

      onwayModel:  parsedJson.containsKey('onwayModel')? OnwayModel.fromJson(parsedJson['onwayModel']) : null,
      reachedonSiteModel:  parsedJson.containsKey('reachedonSiteModel')? ReachedonSiteModel.fromJson(parsedJson['reachedonSiteModel']) : null,
      externalImageScreenModel:  parsedJson.containsKey('externalImageScreenModel')? ExternalImageScreenModel.fromJson(parsedJson['externalImageScreenModel']) : null,
      havekeys:  parsedJson['havekeys'],
      isbuildingsecure:  parsedJson['isbuildingsecure'],
      isbuildinghasalarm:  parsedJson['isbuildinghasalarm'],
      anyWaterLeaking:  parsedJson['anyWaterLeaking'],
      electricMeterPresent:  parsedJson['electricMeterPresent'],
      electricMeterPictureModel:  parsedJson.containsKey('electricMeterPictureModel')? ElectricMeterPictureModel.fromJson(parsedJson['electricMeterPictureModel']) : null,
      gasMeterPresent:  parsedJson['gasMeterPresent'],
      gasMeterPictureModel:  parsedJson.containsKey('gasMeterPictureModel')? GasMeterPictureModel.fromJson(parsedJson['gasMeterPictureModel']) : null,
      waterMeterPresent:  parsedJson['waterMeterPresent'],
      waterMeterPictureModel:  parsedJson.containsKey('waterMeterPictureModel')? WaterMeterPictureModel.fromJson(parsedJson['waterMeterPictureModel']) : null,
      anyDamageToProperty: parsedJson['anyDamageToProperty'],
      anyDamageToPropertyPicModel:  parsedJson.containsKey('anyDamageToPropertyPicModel')? AnyDamageToPropertyPicModel.fromJson(parsedJson['anyDamageToPropertyPicModel']) : null,
      AnyIntrudersOutside:  parsedJson['AnyIntrudersOutside'],
      AnyWorkerOutside:  parsedJson['AnyWorkerOutside'],
      AnyGraffitiNeedRemoval: parsedJson['AnyGraffitiNeedRemoval'],
      AnyDrugUseOutside:  parsedJson['AnyDrugUseOutside'],
      AnyHealthAndSafetyIssues:  parsedJson['AnyHealthAndSafetyIssues'],
      take1stInternalPicturesModel:  parsedJson.containsKey('take1stInternalPicturesModel')? Take1stInternalPicturesModel.fromJson(parsedJson['take1stInternalPicturesModel']) : null,
      take2ndInternalPictureModel:  parsedJson.containsKey('take2ndInternalPictureModel')? Take2ndInternalPictureModel.fromJson(parsedJson['take2ndInternalPictureModel']) : null,
      take3rdInternalPictureModel:  parsedJson.containsKey('take3rdInternalPictureModel')? Take3rdInternalPictureModel.fromJson(parsedJson['take3rdInternalPictureModel']) : null,
      take4thInternalPictureModel:  parsedJson.containsKey('take4thInternalPictureModel')? Take4thInternalPictureModel.fromJson(parsedJson['take4thInternalPictureModel']) : null,
      take5thInternalPictureModel:  parsedJson.containsKey('take5thInternalPictureModel')? Take5thInternalPictureModel.fromJson(parsedJson['take5thInternalPictureModel']) : null,
      SpecificInstructions: parsedJson['SpecificInstructions'],
      jobCompletedModel:  parsedJson.containsKey('jobCompletedModel')? JobCompletedModel.fromJson(parsedJson['jobCompletedModel']) : null,

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



  Map<String ,dynamic>  ExternalImageScreenModeltoMap(){
    Map<String,dynamic> map = new Map();
    Map<String,dynamic> onallmapp = new Map();
    onallmapp["externalImageScreenModel"] =  externalImageScreenModel.AdonwayModelToMap();
    map['QuestionareModel'] =onallmapp;

    return map;
  }

  Map<String ,dynamic>  ElectricMeterPictureProperty(){
    Map<String,dynamic> map = new Map();
    Map<String,dynamic> onallmapp = new Map();
    onallmapp["externalImageScreenModel"] =  externalImageScreenModel.AdonwayModelToMap();
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

  Map<String ,dynamic>  isBuildingsecure(){
    Map<String,dynamic> map = new Map();
    Map<String,dynamic> onallmapp = new Map();
    onallmapp["isbuildingsecure"] =  isbuildingsecure;
    map['QuestionareModel'] =onallmapp;

    return map;
  }

  Map<String ,dynamic>  isbuildinghasAlarm(){
    Map<String,dynamic> map = new Map();
    Map<String,dynamic> onallmapp = new Map();
    onallmapp["isbuildinghasalarm"] =  isbuildinghasalarm;
    map['QuestionareModel'] =onallmapp;

    return map;
  }

  Map<String ,dynamic>  ElectricMeterPresent(){
    Map<String,dynamic> map = new Map();
    Map<String,dynamic> onallmapp = new Map();
    onallmapp["electricMeterPictureModel"] =  electricMeterPictureModel;
    map['QuestionareModel'] =onallmapp;

    return map;
  }

  Map<String ,dynamic>  GasMeterPresent(){
    Map<String,dynamic> map = new Map();
    Map<String,dynamic> onallmapp = new Map();
    onallmapp["gasMeterPresent"] =  gasMeterPresent;
    map['QuestionareModel'] =onallmapp;

    return map;
  }

  Map<String ,dynamic>  WaterMeterPresent(){
    Map<String,dynamic> map = new Map();
    Map<String,dynamic> onallmapp = new Map();
    onallmapp["waterMeterPresent"] =  waterMeterPresent;
    map['QuestionareModel'] =onallmapp;

    return map;
  }

  Map<String ,dynamic>  AnyDamagetoPropertyPresent(){
    Map<String,dynamic> map = new Map();
    Map<String,dynamic> onallmapp = new Map();
    onallmapp["anyDamageToProperty"] =  anyDamageToProperty;
    map['QuestionareModel'] =onallmapp;

    return map;
  }

  Map<String ,dynamic>  AnyIntrudersOutsidetoProperty(){
    Map<String,dynamic> map = new Map();
    Map<String,dynamic> onallmapp = new Map();
    onallmapp["AnyIntrudersOutside"] =  AnyIntrudersOutside;
    map['QuestionareModel'] =onallmapp;

    return map;
  }

  Map<String ,dynamic>  AnyGraftiOutsidetoProperty(){
    Map<String,dynamic> map = new Map();
    Map<String,dynamic> onallmapp = new Map();
    onallmapp["AnyGraffitiNeedRemoval"] =  AnyGraffitiNeedRemoval;
    map['QuestionareModel'] =onallmapp;

    return map;
  }
  Map<String ,dynamic>  AnyDrugUseOutsidetoProperty(){
    Map<String,dynamic> map = new Map();
    Map<String,dynamic> onallmapp = new Map();
    onallmapp["AnyDrugUseOutside"] =  AnyDrugUseOutside;
    map['QuestionareModel'] =onallmapp;

    return map;
  }
  Map<String ,dynamic>  AnyHeealthIssueOutsidetoProperty(){
    Map<String,dynamic> map = new Map();
    Map<String,dynamic> onallmapp = new Map();
    onallmapp["AnyHealthAndSafetyIssues"] =  AnyHealthAndSafetyIssues;
    map['QuestionareModel'] =onallmapp;

    return map;
  }

  Map<String ,dynamic>  AnyWorkerOutsidetoProperty(){
    Map<String,dynamic> map = new Map();
    Map<String,dynamic> onallmapp = new Map();
    onallmapp["AnyWorkerOutside"] =  AnyWorkerOutside;
    map['QuestionareModel'] =onallmapp;

    return map;
  }

  Map<String ,dynamic>  AnyWaterLeaking(){
    Map<String,dynamic> map = new Map();
    Map<String,dynamic> onallmapp = new Map();
    onallmapp["anyWaterLeaking"] =  anyWaterLeaking;
    map['QuestionareModel'] =onallmapp;

    return map;
  }

  Map<String ,dynamic>  GasMeterPictureModelToMap(){
    Map<String,dynamic> map = new Map();
    Map<String,dynamic> onallmapp = new Map();
    onallmapp["gasMeterPictureModel"] =  gasMeterPictureModel;
    map['QuestionareModel'] =onallmapp;

    return map;
  }

  Map<String ,dynamic>  WaterMeterPictureModelToMap(){
    Map<String,dynamic> map = new Map();
    Map<String,dynamic> onallmapp = new Map();
    onallmapp["waterMeterPictureModel"] =  waterMeterPictureModel;
    map['QuestionareModel'] =onallmapp;

    return map;
  }

  Map<String ,dynamic>  AnyDamageToPropertyPicModelToMap(){
    Map<String,dynamic> map = new Map();
    Map<String,dynamic> onallmapp = new Map();
    onallmapp["anyDamageToPropertyPicModel"] =  anyDamageToPropertyPicModel;
    map['QuestionareModel'] =onallmapp;

    return map;
  }

  Map<String ,dynamic>  Take1stInternalPicturesModelToMap(){
    Map<String,dynamic> map = new Map();
    Map<String,dynamic> onallmapp = new Map();
    onallmapp["take1stInternalPicturesModel"] =  take1stInternalPicturesModel;
    map['QuestionareModel'] =onallmapp;

    return map;
  }

  Map<String ,dynamic>  Take2ndInternalPicturesModelToMap(){
    Map<String,dynamic> map = new Map();
    Map<String,dynamic> onallmapp = new Map();
    onallmapp["take2ndInternalPictureModel"] =  take2ndInternalPictureModel;
    map['QuestionareModel'] =onallmapp;

    return map;
  }

  Map<String ,dynamic>  Take3rdInternalPicturesModelToMap(){
    Map<String,dynamic> map = new Map();
    Map<String,dynamic> onallmapp = new Map();
    onallmapp["take3rdInternalPictureModel"] =  take3rdInternalPictureModel;
    map['QuestionareModel'] =onallmapp;

    return map;
  }

  Map<String ,dynamic>  Take4thInternalPicturesModelToMap(){
    Map<String,dynamic> map = new Map();
    Map<String,dynamic> onallmapp = new Map();
    onallmapp["take4thInternalPictureModel"] =  take4thInternalPictureModel;
    map['QuestionareModel'] =onallmapp;

    return map;
  }


  Map<String ,dynamic>  Take5thInternalPicturesModelToMap(){
    Map<String,dynamic> map = new Map();
    Map<String,dynamic> onallmapp = new Map();
    onallmapp["take5thInternalPictureModel"] =  take5thInternalPictureModel;
    map['QuestionareModel'] =onallmapp;

    return map;
  }

  Map<String ,dynamic>  SpecialInstructionToMap(){
    Map<String,dynamic> map = new Map();
    Map<String,dynamic> onallmapp = new Map();
    onallmapp["SpecificInstructions"] =  SpecificInstructions;
    map['QuestionareModel'] =onallmapp;

    return map;
  }

  Map<String ,dynamic>  JobCompletedToMap(){
    Map<String,dynamic> map = new Map();
    Map<String,dynamic> onallmapp = new Map();
    onallmapp["jobCompletedModel"] =  jobCompletedModel;
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

class JobCompletedModel {
  bool jobcompleted;
  Timestamp onawytimestamp;

  JobCompletedModel({this.jobcompleted, this.onawytimestamp});

  Map<String, dynamic> AdonwayModelToMap() {
    Map<String, dynamic> map = new Map();
    map['jobcompleted'] = jobcompleted;

    map['onawytimestamp'] = FieldValue.serverTimestamp();
    return map;
  }

  factory JobCompletedModel.fromJson(Map<String, dynamic> parsedJson) {
    return JobCompletedModel(
      jobcompleted: parsedJson['jobcompleted'],
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

class ExternalImageScreenModel {
  String externalImageScreenModel;
  Timestamp timestampextpic;

  ExternalImageScreenModel(
      {this.externalImageScreenModel, this.timestampextpic});

  Map<String, dynamic> AdonwayModelToMap() {
    Map<String, dynamic> map = new Map();
    map['externalImageScreenModel'] = externalImageScreenModel;

    map['timestampextpic'] = FieldValue.serverTimestamp();
    return map;
  }

  factory ExternalImageScreenModel.fromJson(
      Map<String, dynamic> parsedJson) {
    return ExternalImageScreenModel(
      externalImageScreenModel: parsedJson['externalImageScreenModel'],
      timestampextpic: parsedJson['timestampextpic'],
    );
  }
}

class ElectricMeterPictureModel {
  String electricMeterPictureModel;
  Timestamp timestampextpic;

  ElectricMeterPictureModel(
      {this.electricMeterPictureModel, this.timestampextpic});

  Map<String, dynamic> AdonwayModelToMap() {
    Map<String, dynamic> map = new Map();
    map['electricMeterPictureModel'] = electricMeterPictureModel;

    map['timestampextpic'] = FieldValue.serverTimestamp();
    return map;
  }

  factory ElectricMeterPictureModel.fromJson(
      Map<String, dynamic> parsedJson) {
    return ElectricMeterPictureModel(
      electricMeterPictureModel: parsedJson['electricMeterPictureModel'],
      timestampextpic: parsedJson['timestampextpic'],
    );
  }
}


class WaterMeterPictureModel {
  String waterMeterPictureModel;
  Timestamp timestampextpic;

  WaterMeterPictureModel(
      {this.waterMeterPictureModel, this.timestampextpic});

  Map<String, dynamic> AdonwayModelToMap() {
    Map<String, dynamic> map = new Map();
    map['waterMeterPictureModel'] = waterMeterPictureModel;

    map['timestampextpic'] = FieldValue.serverTimestamp();
    return map;
  }

  factory WaterMeterPictureModel.fromJson(
      Map<String, dynamic> parsedJson) {
    return WaterMeterPictureModel(
      waterMeterPictureModel: parsedJson['waterMeterPictureModel'],
      timestampextpic: parsedJson['timestampextpic'],
    );
  }
}

class AnyDamageToPropertyPicModel {
  String anyDamageToPropertyPicModel;
  Timestamp timestampextpic;

  AnyDamageToPropertyPicModel(
      {this.anyDamageToPropertyPicModel, this.timestampextpic});

  Map<String, dynamic> AdonwayModelToMap() {
    Map<String, dynamic> map = new Map();
    map['anyDamageToPropertyPicModel'] = anyDamageToPropertyPicModel;

    map['timestampextpic'] = FieldValue.serverTimestamp();
    return map;
  }

  factory AnyDamageToPropertyPicModel.fromJson(
      Map<String, dynamic> parsedJson) {
    return AnyDamageToPropertyPicModel(
      anyDamageToPropertyPicModel: parsedJson['anyDamageToPropertyPicModel'],
      timestampextpic: parsedJson['timestampextpic'],
    );
  }
}

class Take1stInternalPicturesModel {
  String take1stInternalPicturesModel;
  Timestamp timestampextpic;

  Take1stInternalPicturesModel(
      {this.take1stInternalPicturesModel, this.timestampextpic});

  Map<String, dynamic> AdonwayModelToMap() {
    Map<String, dynamic> map = new Map();
    map['take1stInternalPicturesModel'] = take1stInternalPicturesModel;

    map['timestampextpic'] = FieldValue.serverTimestamp();
    return map;
  }

  factory Take1stInternalPicturesModel.fromJson(
      Map<String, dynamic> parsedJson) {
    return Take1stInternalPicturesModel(
      take1stInternalPicturesModel: parsedJson['take1stInternalPicturesModel'],
      timestampextpic: parsedJson['timestampextpic'],
    );
  }
}

class Take2ndInternalPictureModel {
  String take2ndInternalPictureModel;
  Timestamp timestampextpic;

  Take2ndInternalPictureModel(
      {this.take2ndInternalPictureModel, this.timestampextpic});

  Map<String, dynamic> AdonwayModelToMap() {
    Map<String, dynamic> map = new Map();
    map['take2ndInternalPictureModel'] = take2ndInternalPictureModel;

    map['timestampextpic'] = FieldValue.serverTimestamp();
    return map;
  }

  factory Take2ndInternalPictureModel.fromJson(
      Map<String, dynamic> parsedJson) {
    return Take2ndInternalPictureModel(
      take2ndInternalPictureModel: parsedJson['take2ndInternalPictureModel'],
      timestampextpic: parsedJson['timestampextpic'],
    );
  }
}

class Take3rdInternalPictureModel {
  String take3rdInternalPictureModel;
  Timestamp timestampextpic;

  Take3rdInternalPictureModel(
      {this.take3rdInternalPictureModel, this.timestampextpic});

  Map<String, dynamic> AdonwayModelToMap() {
    Map<String, dynamic> map = new Map();
    map['take3rdInternalPictureModel'] = take3rdInternalPictureModel;

    map['timestampextpic'] = FieldValue.serverTimestamp();
    return map;
  }

  factory Take3rdInternalPictureModel.fromJson(
      Map<String, dynamic> parsedJson) {
    return Take3rdInternalPictureModel(
      take3rdInternalPictureModel: parsedJson['take3rdInternalPictureModel'],
      timestampextpic: parsedJson['timestampextpic'],
    );
  }
}

class Take4thInternalPictureModel {
  String take4thInternalPictureModel;
  Timestamp timestampextpic;

  Take4thInternalPictureModel(
      {this.take4thInternalPictureModel, this.timestampextpic});

  Map<String, dynamic> AdonwayModelToMap() {
    Map<String, dynamic> map = new Map();
    map['take4thInternalPictureModel'] = take4thInternalPictureModel;

    map['timestampextpic'] = FieldValue.serverTimestamp();
    return map;
  }

  factory Take4thInternalPictureModel.fromJson(
      Map<String, dynamic> parsedJson) {
    return Take4thInternalPictureModel(
      take4thInternalPictureModel: parsedJson['take4thInternalPictureModel'],
      timestampextpic: parsedJson['timestampextpic'],
    );
  }
}

class Take5thInternalPictureModel {
  String take5thInternalPictureModel;
  Timestamp timestampextpic;

  Take5thInternalPictureModel(
      {this.take5thInternalPictureModel, this.timestampextpic});

  Map<String, dynamic> AdonwayModelToMap() {
    Map<String, dynamic> map = new Map();
    map['take5thInternalPictureModel'] = take5thInternalPictureModel;

    map['timestampextpic'] = FieldValue.serverTimestamp();
    return map;
  }

  factory Take5thInternalPictureModel.fromJson(
      Map<String, dynamic> parsedJson) {
    return Take5thInternalPictureModel(
      take5thInternalPictureModel: parsedJson['take5thInternalPictureModel'],
      timestampextpic: parsedJson['timestampextpic'],
    );
  }
}


class GasMeterPictureModel {
  String gasMeterPictureModel;
  Timestamp timestampextpic;

  GasMeterPictureModel(
      {this.gasMeterPictureModel, this.timestampextpic});

  Map<String, dynamic> AdonwayModelToMap() {
    Map<String, dynamic> map = new Map();
    map['gasMeterPictureModel'] = gasMeterPictureModel;

    map['timestampextpic'] = FieldValue.serverTimestamp();
    return map;
  }

  factory GasMeterPictureModel.fromJson(
      Map<String, dynamic> parsedJson) {
    return GasMeterPictureModel(
      gasMeterPictureModel: parsedJson['gasMeterPictureModel'],
      timestampextpic: parsedJson['timestampextpic'],
    );
  }
}


