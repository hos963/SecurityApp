import 'package:Metropolitane/MobileApp/MobileapQuestions/UnLockSurveyQuestion/Questions/FinishScreen.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/UnLockSurveyQuestion/Questions/BuildingAlarmedAndSecured.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/UnLockSurveyQuestion/Questions/ExternalImageScreen.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/UnLockSurveyQuestion/Questions/HaveKeysScreen.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/UnLockSurveyQuestion/Questions/JobCompleted.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/UnLockSurveyQuestion/Questions/OnSiteScreen.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/UnLockSurveyQuestion/Questions/OnWayScreen.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/UnLockSurveyQuestion/Questions/SpecialInstructionsScreen.dart';
import 'package:Metropolitane/model/AddUnlockModel.dart';
import 'package:flutter/material.dart';
typedef void MyCallbackToback(int foo);
class UnLockQuestionsSurvey extends StatefulWidget {

  AddUnlockModel addUnlockModel;
  UnLockQuestionsSurvey (this.addUnlockModel);

  @override
  _UnLockQuestionsSurveyState createState() => _UnLockQuestionsSurveyState();
}

class _UnLockQuestionsSurveyState extends State<UnLockQuestionsSurvey> {

  int currentpage=0;

  List<Widget> list = [];


  @override
  void initState() {

    list.add(OnWayScreen(widget.addUnlockModel,MoveNext));
    list.add(OnSiteScreen(widget.addUnlockModel,MoveNext));
    list.add(HaveKeysScreen(widget.addUnlockModel,MoveNext));
    list.add(ExternalImageScreen(widget.addUnlockModel,MoveNext));
    list.add(BuildingAlarmAndSecured(widget.addUnlockModel,MoveNext));
    list.add(SpecialInstructionScreen(widget.addUnlockModel,MoveNext));
    list.add(JobCompleted(widget.addUnlockModel,MoveNext));
    list.add(FinishScreen(widget.addUnlockModel,MoveNext));

    if(widget.addUnlockModel.questionareModel == null){
      currentpage = 0;

    }else{

      var questionmodel = widget.addUnlockModel.questionareModel;

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

      if(questionmodel.unlockandunalarmed != null){

        currentpage = 5;
      }
      if(questionmodel.specialinstruction != null){

        currentpage = 6;
      }
      if(questionmodel.leaveBuildingModel != null){

        currentpage = 7;
      }
      if(questionmodel.leaveBuildingModel != null){

        currentpage = 8;
      }

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
