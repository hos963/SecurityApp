import 'package:Metropolitane/MobileApp/MobileapQuestions/PatrolSurveyQuestion/Questions/AlarmUnset.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/PatrolSurveyQuestion/Questions/DoKeyGiveAccess.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/PatrolSurveyQuestion/Questions/ExternalPatrolDone.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/PatrolSurveyQuestion/Questions/HaveKeysScreen.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/PatrolSurveyQuestion/Questions/IsBuildingPresent.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/PatrolSurveyQuestion/Questions/OnSiteScreen.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/PatrolSurveyQuestion/Questions/OnWayScreen.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/PatrolSurveyQuestion/Questions/SpecificInstructions.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/PatrolSurveyQuestion/Questions/TakeFifthInternalPictures.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/PatrolSurveyQuestion/Questions/TakeImageOfKeys.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/PatrolSurveyQuestion/Questions/TakeInternalPictures.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/PatrolSurveyQuestion/Questions/TakePictureOfBuilding.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/PatrolSurveyQuestion/Questions/TakeSecondInternalPictures.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/PatrolSurveyQuestion/Questions/TakeSinglePictureOfBuilding.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/PatrolSurveyQuestion/Questions/TakeThirdInternalPictures.dart';
import 'package:Metropolitane/model/AddPatrolModel.dart';
import 'package:flutter/material.dart';

import 'Questions/AlarmAndLocked.dart';
import 'Questions/FinishScreen.dart';
import 'Questions/JobCompleted.dart';
import 'Questions/TakeFourthInternalPictures.dart';

typedef void MyCallbackToback(int foo);
typedef void Callbackforcustommove(int foo);

class PatrolQuestionSurvey extends StatefulWidget {
  AddPatrolModel addPatrolModel;

  PatrolQuestionSurvey(this.addPatrolModel);

  @override
  _PatrolQuestionSurveyState createState() => _PatrolQuestionSurveyState();
}

class _PatrolQuestionSurveyState extends State<PatrolQuestionSurvey> {
  int currentpage = 0;

  List<Widget> list = [];

  @override
  void initState() {

    list.add(OnWayScreen(widget.addPatrolModel, MoveNext));
    list.add(OnSiteScreen(widget.addPatrolModel, MoveNext));
    list.add(ExternalPatrolDone(widget.addPatrolModel, MoveNext));
    list.add(IsBuildingPresent(widget.addPatrolModel, MoveNext,MoveCustomIndex));
    list.add(TakeSinglePictureOfBuilding(widget.addPatrolModel, MoveNext));
    list.add(HaveKeysScreen(widget.addPatrolModel, MoveNext,MoveCustomIndex));
    list.add(TakeImageOfKeys(widget.addPatrolModel, MoveNext));
    list.add(DoKeyGiveAccess(widget.addPatrolModel, MoveNext,MoveCustomIndex));
    list.add(AlarmUnset(widget.addPatrolModel, MoveNext,MoveCustomIndex));
    list.add(TakeInternalPictures(widget.addPatrolModel, MoveNext));
    list.add(TakeSecondInternalPictures(widget.addPatrolModel, MoveNext));
    list.add(TakeThirdInternalPictures(widget.addPatrolModel, MoveNext));
    list.add(TakeFourthInternalPictures(widget.addPatrolModel, MoveNext));
    list.add(TakeFifthInternalPictures(widget.addPatrolModel, MoveNext));
    list.add(SpecificInstructions(widget.addPatrolModel, MoveNext));
    list.add(AlarmAndLocked(widget.addPatrolModel, MoveNext));
    list.add(JobCompleted(widget.addPatrolModel, MoveNext));
    list.add(FinishScreen(widget.addPatrolModel, MoveNext));

    if (widget.addPatrolModel.questionareModel == null) {
      currentpage = 0;
    } else {
      var questionmodel = widget.addPatrolModel.questionareModel;

      if (questionmodel.onwayModel != null) {
        currentpage = 1;
      }

      if (questionmodel.reachedonSiteModel != null) {
        currentpage = 2;
      }

      if (questionmodel.externalpatroldone != null) {
        currentpage = 3;
      }
      if (questionmodel.isBuildingPresent!=null) {
        if(questionmodel.isBuildingPresent){
          currentpage = 4;
        }
        else{
          currentpage = 9;
        }
      }
      if (questionmodel.externalPictureOfBuildingModel != null) {
        currentpage = 5;
      }
      if (questionmodel.havekeys != null) {
        if(questionmodel.havekeys){
          currentpage = 6;
        }
        else{
          currentpage = 7;
        }
      }
      if (questionmodel.takePictureOfKeys != null) {
        currentpage = 7;
      }
      if (questionmodel.dokeygiveAccess != null) {

        if(questionmodel.dokeygiveAccess){
          currentpage = 8;
        }
        else{
          currentpage = 14;
        }
      }
      if (questionmodel.alarmUnset != null) {

        if(questionmodel.alarmUnset){
          currentpage = 9;
        }
        else{
          currentpage = 14;
        }

      }
      if (questionmodel.internalPictureOfBuildingModel != null) {
        currentpage = 10;
      }
      if (questionmodel.internalFirstPictureOfBuildingModel != null) {
        currentpage = 11;
      }
      if (questionmodel.internalSecondPictureOfBuildingModel != null) {
        currentpage = 12;
      }
      if (questionmodel.internalThirdPictureOfBuildingModel != null) {
        currentpage = 13;
      }
      if (questionmodel.internalFourthPictureOfBuildingModel != null) {
        currentpage = 14;
      }
      if (questionmodel.specialInstruction != null) {
        currentpage = 15;

        if(questionmodel.isBuildingPresent){
          currentpage = 15;
        }
        else{
          currentpage = 17;
        }

      }
      if (questionmodel.lockAndAlarmed != null) {
        currentpage = 16;
      }
      if (questionmodel.leaveBuildingModel != null) {
        currentpage = 17;
      }
    }
    super.initState();
  }

  void MoveNext(int i) {
    if (currentpage < (list.length - 1)) {
      setState(() {
        currentpage++;
      });
    } else {
      {
        Navigator.pop(context);
      }
    }
  }

  void MoveCustomIndex(int i){
    setState(() {
      currentpage  = i;
    });

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black54),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Survey",style: TextStyle(color: Colors.black54),),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(child: list[currentpage]),
        ],
      ),
    );
  }
}
