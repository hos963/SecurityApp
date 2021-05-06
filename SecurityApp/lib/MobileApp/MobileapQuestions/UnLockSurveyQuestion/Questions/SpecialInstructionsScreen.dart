import 'package:Metropolitane/FirebaseService/FirebaseService.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/UnLockSurveyQuestion/UnLockQuestionsSurvey.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/utils/AppWidget.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/utils/QuizColors.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/utils/QuizStrings.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/utils/QuizWidget.dart';
import 'package:Metropolitane/model/AddUnlockModel.dart';
import 'package:Metropolitane/model/UnLockQuestionareModel.dart';
import 'package:flutter/material.dart';

import 'package:Metropolitane/MobileApp/MobileapQuestions/UnLockSurveyQuestion/Questions/JobCompleted.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:progress_indicator_button/progress_button.dart';

class SpecialInstructionScreen extends StatefulWidget {

  final MyCallbackToback callback;

  AddUnlockModel addLockModel;
  SpecialInstructionScreen(this.addLockModel,this.callback);


  @override
  _SpecialInstructionScreenState createState() => _SpecialInstructionScreenState();
}

class _SpecialInstructionScreenState extends State<SpecialInstructionScreen> {


  TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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

                Padding(
                  padding: const EdgeInsets.only(left:18.0,right: 10.0),
                  child:   Container(
                    margin: EdgeInsets.all(24.0),
                    child: MultilinesEditextField("Special Instructions",
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
                        Updatinngdata();
                      //  Navigator.push(context,  MaterialPageRoute(builder: (context) => JobCompleted()));
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
    if (controller.text != null) {
      FirebaseService firebaseService = new FirebaseService();
      if (widget.addLockModel.questionareModel == null) {
        widget.addLockModel.questionareModel = new UnLockQuestionareModel();
      }
      widget.addLockModel.questionareModel.specialinstruction = controller.text;

      await firebaseService.specialInstructionUnLock(
          widget.addLockModel.unlockId, widget.addLockModel.questionareModel);

      widget.callback(1);
    }
  }

}
