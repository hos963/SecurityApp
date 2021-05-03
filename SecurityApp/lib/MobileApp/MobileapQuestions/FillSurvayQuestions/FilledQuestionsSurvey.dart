import 'package:Metropolitane/CustomColors/CustomColors.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/FillSurvayQuestions/Questions/ActionTakenScreen.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/FillSurvayQuestions/Questions/FinishScreen.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/FillSurvayQuestions/Questions/HaveKeyScreen.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/FillSurvayQuestions/Questions/LeaveBuildingScreen.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/FillSurvayQuestions/Questions/MessageOnPanelScreen.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/FillSurvayQuestions/Questions/OnwayScreen.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/FillSurvayQuestions/Questions/PictureBuildingScreen.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/FillSurvayQuestions/Questions/PictureOfAlarmPanelScreen.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/FillSurvayQuestions/Questions/ReachedOnSiteScreen.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/FillSurvayQuestions/Questions/SetAlarmScreen.dart';
import 'package:Metropolitane/model/AddAlarmModel.dart';
import 'package:flutter/material.dart';

typedef void MyCallbackToback(int foo);
class FilledQuestionsSurvey extends StatefulWidget {

  AddAlarmModel addAlarmModel;

  FilledQuestionsSurvey(this.addAlarmModel);

  @override
  _FilledQuestionsSurveyState createState() => _FilledQuestionsSurveyState();
}

class _FilledQuestionsSurveyState extends State<FilledQuestionsSurvey> {

  int currentpage = 0;

  List<Widget> list = [];
  // List<Widget> list = [
  //   OnWayScreen(doSomething),
  //   ReachedOnSiteScreen(),
  //   HaveKeyScreen(),
  //   PictureBuildingScreen(isinternal: false),
  //   SetAlarmScreen(
  //     isunsetscreenn: true,
  //   ),
  //   PictureOfAlarmPanelScreen(),
  //   MessageOnPanelScreen(),
  //   PictureBuildingScreen(isinternal: true),
  //   ActionTakenScreen(),
  //   SetAlarmScreen(
  //     isunsetscreenn: false,
  //   ),
  //   LeaveBuildingScreen(),
  //   FinishScreen()
  // ];

  @override
  void initState() {

    list.add(OnWayScreen(widget.addAlarmModel,MoveNext));
    list.add(ReachedOnSiteScreen(widget.addAlarmModel,MoveNext));
    list.add(HaveKeyScreen(widget.addAlarmModel,MoveNext));
    list.add(PictureBuildingScreen(widget.addAlarmModel,MoveNext,isinternal: false));
    list.add(SetAlarmScreen(widget.addAlarmModel,MoveNext,
          isunsetscreenn: true,
        ),);
    list.add(PictureOfAlarmPanelScreen(widget.addAlarmModel,MoveNext));
    list.add(MessageOnPanelScreen(widget.addAlarmModel,MoveNext));
    list.add(PictureBuildingScreen(widget.addAlarmModel,MoveNext,isinternal: true));
    list.add(ActionTakenScreen(widget.addAlarmModel,MoveNext,));
    list.add(SetAlarmScreen(widget.addAlarmModel,MoveNext, isunsetscreenn: false,));
    list.add(LeaveBuildingScreen(widget.addAlarmModel,MoveNext));
    list.add(FinishScreen(widget.addAlarmModel,MoveNext));

    if(widget.addAlarmModel.questionareModel == null){
      currentpage = 0;

    }else{

      var questionmodel = widget.addAlarmModel.questionareModel;
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

      if(questionmodel.areyouabletounsetAlarmModel != null){

        currentpage = 5;
      }
      if(questionmodel.pictureOfAlarmPanelModel != null){

        currentpage = 6;
      }
      if(questionmodel.messageOnPanel != null){

        currentpage = 7;
      }
      if(questionmodel.internalPictureOfBuildingModel != null){

        currentpage = 8;
      }
      if(questionmodel.actionTaken != null){

        currentpage = 9;
      }
      if(questionmodel.areyouabletosetAlarmModel != null){

        currentpage = 10;
      }
      if(questionmodel.leaveBuildingModel != null){

        currentpage = 11;
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
