import 'package:Metropolitane/MobileApp/MobileapQuestions/LockSurveyQuestion/Questions/AllWindowsAndDoorsScreen.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/LockSurveyQuestion/Questions/BuildingAlarmedAndSecured.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/LockSurveyQuestion/Questions/ExternalImageScreen.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/LockSurveyQuestion/Questions/FinishScreen.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/LockSurveyQuestion/Questions/HaveKeysScreen.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/LockSurveyQuestion/Questions/JobCompleted.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/LockSurveyQuestion/Questions/OnSiteScreen.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/LockSurveyQuestion/Questions/OnWayScreen.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/LockSurveyQuestion/Questions/SpecialInstructionsScreen.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/LockSurveyQuestion/Questions/TakeInternalImageScreen.dart';
import 'package:Metropolitane/model/AddLockModel.dart';
import 'package:Metropolitane/model/LockQuestionareModel.dart';
import 'package:flutter/material.dart';


typedef void MyCallbackToback(int foo);
class LockQuestionSurvey extends StatefulWidget {

  AddLockModel addLockModel;
  LockQuestionSurvey (this.addLockModel);

  @override
  _LockQuestionSurveyState createState() => _LockQuestionSurveyState();
}

class _LockQuestionSurveyState extends State<LockQuestionSurvey> {

  int currentpage=0;

  List<Widget> list = [];


  @override
  void initState() {

    list.add(OnWayScreen(widget.addLockModel,MoveNext));
    list.add(OnSiteScreen(widget.addLockModel,MoveNext));
    list.add(HaveKeysScreen(widget.addLockModel,MoveNext));
    list.add(ExternalImageScreen(widget.addLockModel,MoveNext));
    list.add(WindowandDoorScreen(widget.addLockModel,MoveNext));
    list.add(TakeInternalImageScreen(widget.addLockModel,MoveNext));
    list.add(BuildingAlarmAndSecured(widget.addLockModel,MoveNext));
    list.add(SpecialInstructionScreen(widget.addLockModel,MoveNext));
    list.add(JobCompleted(widget.addLockModel,MoveNext));
    list.add(FinishScreen(widget.addLockModel,MoveNext));

    if(widget.addLockModel.questionareModel == null){
      currentpage = 0;

    }else{

      var questionmodel = widget.addLockModel.questionareModel;

      if(questionmodel.onwayModel != null){
        currentpage = 1;
      }

      if(questionmodel.reachedonSiteModel != null){

        currentpage = 2;
      }

      if(questionmodel.havekeys != null){

        currentpage = 3;
      }
      if(questionmodel.externalPictureOfBuildingModel != null){

        currentpage = 4;
      }

      if(questionmodel.doorsAndWindowsSecured != null){

        currentpage = 5;
      }
      if(questionmodel.internalPictureOfBuildingModel != null){

        currentpage = 6;
      }
      if(questionmodel.alarmedAndSecured != null){

        currentpage = 7;
      }
      if(questionmodel.messageOnPanel != null){

        currentpage = 8;
      }
      // if(questionmodel.leaveBuildingModel != null){
      //
      //   currentpage = 9;
      // }

      // if(questionmodel.leaveBuildingModel != null){
      //
      //   currentpage = 10;
      // }

    }
    super.initState();
  }


  void MoveNext(int i){

    if(currentpage < (list.length-1)){

      setState(() {
        currentpage ++;
      });
    }else{{
      Navigator.pop(context);
    }
    }
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
          // Container(
          //   height: 60,
          //   color: CustomColors.orangecolor,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //
          //       TextButton.icon(
          //         label: Text(""),
          //         icon: Icon(
          //           Icons.arrow_back,
          //           color: Colors.white,
          //         ),
          //         onPressed: () {
          //
          //           if(currentpage != 0){
          //
          //             setState(() {
          //               currentpage --;
          //             });
          //           }
          //
          //
          //         },
          //       ),
          //       TextButton.icon(
          //         icon: Icon(Icons.arrow_forward, color: Colors.white),
          //         label: Text(""),
          //         onPressed: () {
          //
          //           if(currentpage < (list.length-1)){
          //
          //             setState(() {
          //               currentpage ++;
          //             });
          //           }else{{
          //           }
          //           }
          //         },
          //       ),
          //
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}
