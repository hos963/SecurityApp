import 'package:Metropolitane/FirebaseService/FirebaseService.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/UnLockSurveyQuestion/UnLockQuestionsSurvey.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/utils/QuizColors.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/utils/QuizStrings.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/utils/QuizWidget.dart';
import 'package:Metropolitane/model/AddUnlockModel.dart';
import 'package:Metropolitane/model/UnLockQuestionareModel.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:progress_indicator_button/progress_button.dart';

import 'package:Metropolitane/MobileApp/MobileapQuestions/UnLockSurveyQuestion/Questions/ExternalImageScreen.dart';

class HaveKeysScreen extends StatefulWidget {


  final MyCallbackToback callback;

  AddUnlockModel addUnlockModel;
  HaveKeysScreen(this.addUnlockModel,this.callback);

  @override
  _HaveKeysScreenState createState() => _HaveKeysScreenState();
}

class _HaveKeysScreenState extends State<HaveKeysScreen> {

  String _singleValue = "Yes";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        backgroundColor: Colors.white,
        title: Text('Survey'),
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: quiz_app_background,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 20),
                text("Do you have keys?",
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
                        Updatinngdata();
                      }
                    },
                  ),
                ),
              ],
            ),
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

    if (widget.addUnlockModel.questionareModel == null) {
      widget.addUnlockModel.questionareModel = new UnLockQuestionareModel();
    }

    widget.addUnlockModel.questionareModel.havekeys = istrue;

    FirebaseService firebaseService = new FirebaseService();
    await firebaseService.HavekeyUpdateUnLock(
        widget.addUnlockModel.unlockId, widget.addUnlockModel.questionareModel);

    widget.callback(1);
  }

}
