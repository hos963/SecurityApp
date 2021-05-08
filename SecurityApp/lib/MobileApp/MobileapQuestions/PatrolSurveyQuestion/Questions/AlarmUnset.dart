import 'package:Metropolitane/FirebaseService/FirebaseService.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/utils/AppWidget.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/utils/QuizColors.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/utils/QuizStrings.dart';
import 'package:Metropolitane/model/AddPatrolModel.dart';
import 'package:Metropolitane/model/PatrolQuestionareModel.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:progress_indicator_button/progress_button.dart';

import 'package:Metropolitane/MobileApp/MobileapQuestions/PatrolSurveyQuestion/Questions/TakeInternalPictures.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/PatrolSurveyQuestion/Questions/AdditionalComments.dart';

import '../PatrolQuestionSurvey.dart';
class AlarmUnset extends StatefulWidget {

  final MyCallbackToback callback;
  final Callbackforcustommove callbackforcustommove;

  AddPatrolModel addPatrolModel;
  AlarmUnset(this.addPatrolModel,this.callback,this.callbackforcustommove);


  @override
  _AlarmUnsetState createState() => _AlarmUnsetState();
}

class _AlarmUnsetState extends State<AlarmUnset> {
  String _singleValue = "Yes";

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
              text("Alarm Unset?",
                  textColor: quiz_textColorPrimary,
                  isLongText: true,
                  isCentered: true,
                  fontSize: 22.0).center(),
              SizedBox(height: 30),
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RadioButton(
                      description: "Yes",
                      value: "Yes",
                      groupValue: _singleValue,
                      onChanged: (value) => setState(
                            () => _singleValue = value,
                      ),
                    ),
                    RadioButton(
                      description: "No",
                      value: "No",
                      groupValue: _singleValue,
                      onChanged: (value) => setState(
                            () => _singleValue = value,
                      ),
                    ),
                  ],
                ),
              ).onTap(() {
                //Navigator.of(context).pop();
              }),
              SizedBox(height: 20),
              // Container(
              //   margin: EdgeInsets.all(60.0),
              //   child: quizButton(
              //     textContent: quiz_lbl_continue,
              //     onPressed: () {
              //       Updatinngdata();
              //
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
                      if(_singleValue == "Yes"){
                        Updatinngdata();
                        //  Navigator.push(context,  MaterialPageRoute(builder: (context) => TakeInternalPictures()));
                      }
                      else if(_singleValue == "No"){
                        Updatinngdata();
                      }
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
    bool istrue = false;
    if (_singleValue == "Yes") {
      istrue = true;
    } else {
      istrue = false;
    }

    if (widget.addPatrolModel.questionareModel == null) {
      widget.addPatrolModel.questionareModel = new PatrolQuestionareModel();
    }

    widget.addPatrolModel.questionareModel.alarmUnset = istrue;

    FirebaseService firebaseService = new FirebaseService();
    await firebaseService.AlarmUnset(
        widget.addPatrolModel.patrolId, widget.addPatrolModel.questionareModel);



    if (_singleValue == "Yes") {
      widget.callback(1);
    } else {
      widget.callbackforcustommove(15);
    }

  }


}

