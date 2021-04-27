import 'package:Metropolitane/FirebaseService/FirebaseService.dart';
import 'package:Metropolitane/model/AddAlarmModel.dart';
import 'package:Metropolitane/model/QuestionareModel.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/Screens/QuizCreatePassword.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/utils/QuizColors.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/utils/QuizConstant.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/utils/QuizExtension.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/utils/QuizStrings.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/utils/QuizWidget.dart';
import 'package:progress_indicator_button/progress_button.dart';

import '../FilledQuestionsSurvey.dart';

class MessageOnPanelScreen extends StatefulWidget {
  AddAlarmModel addAlarmModel;
  final MyCallbackToback callback;

  MessageOnPanelScreen(this.addAlarmModel, this.callback);

  @override
  _MessageOnPanelScreenState createState() => _MessageOnPanelScreenState();
}

class _MessageOnPanelScreenState extends State<MessageOnPanelScreen> {
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
              text("Message on Panel",
                      textColor: quiz_textColorPrimary,
                      isLongText: true,
                      isCentered: true,
                      fontSize: 22.0)
                  .center(),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.all(24.0),
                decoration: boxDecoration(
                    bgColor: quiz_white,
                    color: quiz_white,
                    showShadow: true,
                    radius: 10),
                child: MultilinesEditextField("Type Message",
                    isPassword: false, controller: controller),
              ),
              SizedBox(height: 20),
              SizedBox(height: 20),
              // Container(
              //   margin: EdgeInsets.all(26.0),
              //   child: quizButton(
              //     textContent: quiz_lbl_continue,
              //     onPressed: () {
              //
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
    if (controller.text != null) {
      FirebaseService firebaseService = new FirebaseService();
      if (widget.addAlarmModel.questionareModel == null) {
        widget.addAlarmModel.questionareModel = new QuestionareModel();
      }
      widget.addAlarmModel.questionareModel.messageOnPanel = controller.text;

      await firebaseService.messagetoPannelToMapp(
          widget.addAlarmModel.alarmId, widget.addAlarmModel.questionareModel);

      widget.callback(1);
    }
  }
}
