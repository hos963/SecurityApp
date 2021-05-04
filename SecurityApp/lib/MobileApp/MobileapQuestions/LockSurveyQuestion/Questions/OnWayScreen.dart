import 'package:Metropolitane/FirebaseService/FirebaseService.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/utils/AppWidget.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/utils/QuizColors.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/utils/QuizStrings.dart';

import 'package:Metropolitane/MobileApp/MobileapQuestions/LockSurveyQuestion/Questions/OnSiteScreen.dart';
import 'package:Metropolitane/model/AddLockModel.dart';
import 'package:Metropolitane/model/LockQuestionareModel.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicator_button/progress_button.dart';

import 'package:nb_utils/nb_utils.dart';

import '../LockQuestionsSurvey.dart';


class OnWayScreen extends StatefulWidget {

  final MyCallbackToback callback;

  AddLockModel addLockModel;
  OnWayScreen(this.addLockModel,this.callback);

  @override
  _OnWayScreenState createState() => _OnWayScreenState();
}

class _OnWayScreenState extends State<OnWayScreen> {
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

              text("Are you on the way?", textColor: quiz_textColorPrimary, isLongText: true, isCentered: true,fontSize: 22.0).center(),

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

    OnwayModel onwayModel = new OnwayModel();
    onwayModel.ontheWay = true;


    if( widget.addLockModel.questionareModel == null){
      widget.addLockModel.questionareModel = new LockQuestionareModel();
    }
    widget.addLockModel.questionareModel.onwayModel = onwayModel;

    FirebaseService firebaseService = new FirebaseService();
    await firebaseService.updateOnwayLock( widget.addLockModel.lockId,widget.addLockModel.questionareModel);

    widget. callback(1);
  }

}
