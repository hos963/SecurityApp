import 'package:Metropolitane/FirebaseService/FirebaseService.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/utils/AppWidget.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/utils/QuizColors.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/utils/QuizStrings.dart';
import 'package:Metropolitane/model/AddPatrolModel.dart';
import 'package:Metropolitane/model/PatrolQuestionareModel.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicator_button/progress_button.dart';

import 'package:nb_utils/nb_utils.dart';

import '../PatrolQuestionSurvey.dart';
class JobCompleted extends StatefulWidget {

  final MyCallbackToback callback;

  AddPatrolModel addPatrolModel;
  JobCompleted(this.addPatrolModel,this.callback);

  @override
  _JobCompletedState createState() => _JobCompletedState();
}

class _JobCompletedState extends State<JobCompleted> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        color: quiz_app_background,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),

              text("Job Completed", textColor: quiz_textColorPrimary, isLongText: true, isCentered: true,fontSize: 22.0).center(),

              SizedBox(height: 40),
              // Container(
              //   margin: EdgeInsets.all(60.0),
              //   child: quizButton(
              //     textContent: "Finish",
              //     onPressed: () {
              //       Updatinngdata();
              //     },
              //   ),
              // )
              Container(

                width: 200,
                height: 50,
                child: ProgressButton(
                  color: quiz_colorPrimaryDark,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  strokeWidth: 2,
                  child: Text(
                    quiz_lbl_continue,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  onPressed: (AnimationController controller) {
                    if (controller.isCompleted) {
                      //   controller.reverse();
                    } else {
                      controller.forward();
                      Updatinngdata();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Future<void> Updatinngdata() async {

    FirebaseService firebaseService = new FirebaseService();
    if (widget.addPatrolModel.questionareModel == null) {
      widget.addPatrolModel.questionareModel = new PatrolQuestionareModel();
    }
    widget.addPatrolModel.questionareModel.leaveBuildingModel = new LeaveBuildingModel();
    widget.addPatrolModel.questionareModel.leaveBuildingModel.leavebuilding = true;
    await firebaseService.JobCompletePatrol(
        widget.addPatrolModel.patrolId, widget.addPatrolModel.questionareModel);

    widget.addPatrolModel.state = 3;

    await firebaseService.UpdatingStatusPatrol(
        widget.addPatrolModel.patrolId,widget.addPatrolModel);

    widget.callback(1);

  }

}
