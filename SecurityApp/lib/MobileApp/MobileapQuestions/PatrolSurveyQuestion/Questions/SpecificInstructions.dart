import 'package:Metropolitane/FirebaseService/FirebaseService.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/utils/QuizColors.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/utils/QuizStrings.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/utils/QuizWidget.dart';
import 'package:Metropolitane/model/AddPatrolModel.dart';
import 'package:Metropolitane/model/PatrolQuestionareModel.dart';
import 'package:flutter/material.dart';

import 'package:Metropolitane/MobileApp/MobileapQuestions/PatrolSurveyQuestion/Questions/AlarmAndLocked.dart';
import 'package:progress_indicator_button/progress_button.dart';

import '../PatrolQuestionSurvey.dart';
class SpecificInstructions extends StatefulWidget {

  final MyCallbackToback callback;

  AddPatrolModel addPatrolModel;
  SpecificInstructions(this.addPatrolModel,this.callback);


  @override
  _SpecificInstructionsState createState() => _SpecificInstructionsState();
}

class _SpecificInstructionsState extends State<SpecificInstructions> {

  TextEditingController controller = new TextEditingController();


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

              Padding(
                padding: const EdgeInsets.only(left:18.0,right: 10.0),
                child : Container(
                  margin: EdgeInsets.all(24.0),
                  child: MultilinesEditextField("Specific Instructions",
                      isPassword: false, controller: controller),
                ),
              ),
              SizedBox(height: 40),
              // Container(
              //   margin: EdgeInsets.all(60.0),
              //   child: quizButton(
              //     textContent: quiz_lbl_continue,
              //     onPressed: () {
              //       Updatinngdata();
              //     },
              //   ),
              // ),
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
                      //Navigator.push(context,  MaterialPageRoute(builder: (context) => AlarmAndLocked()));
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
    if (controller.text != null) {
      FirebaseService firebaseService = new FirebaseService();
      if (widget.addPatrolModel.questionareModel == null) {
        widget.addPatrolModel.questionareModel = new PatrolQuestionareModel();
      }
      widget.addPatrolModel.questionareModel.specialInstruction = controller.text;

      await firebaseService.specialInstructionPatrol(
          widget.addPatrolModel.patrolId, widget.addPatrolModel.questionareModel);

      widget.callback(1);
    }
  }

}
