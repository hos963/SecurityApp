import 'package:Metropolitane/MobileApp/MobileapQuestions/utils/AppWidget.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/utils/QuizColors.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/utils/QuizStrings.dart';
import 'package:flutter/material.dart';

import 'package:Metropolitane/MobileApp/MobileapQuestions/PropertyInspectionQuestions/Questions/JobCompleted.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:progress_indicator_button/progress_button.dart';
class SpecialInstructionScreen extends StatefulWidget {
  @override
  _SpecialInstructionScreenState createState() => _SpecialInstructionScreenState();
}

class _SpecialInstructionScreenState extends State<SpecialInstructionScreen> {
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
                  child: TextField(
                    autofocus: true,
                    decoration: new InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.0),
                      ),
                      hintText: 'Specific Instruction',
                    ),
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
                        Navigator.push(context,  MaterialPageRoute(builder: (context) => JobCompleted()));
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
}
