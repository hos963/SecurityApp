import 'package:Metropolitane/FirebaseService/FirebaseService.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/utils/AppWidget.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/utils/QuizColors.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/utils/QuizStrings.dart';
import 'package:Metropolitane/model/AddPropertyInspectionModel.dart';
import 'package:Metropolitane/model/PropertyInspectionQuestionareModel.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicator_button/progress_button.dart';

import 'package:nb_utils/nb_utils.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/PropertyInspectionQuestions/Questions/ExternalImageScreen.dart';

import '../PropertyInspectionQuestions.dart';

class OnSiteScreen extends StatefulWidget {

  final MyCallbackToback callback;

  AddPropertyInspectionModel addPropertyInspectionModel;
  OnSiteScreen(this.addPropertyInspectionModel,this.callback);


  @override
  _OnSiteScreenState createState() => _OnSiteScreenState();
}

class _OnSiteScreenState extends State<OnSiteScreen> {
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

                text("Are you onsite?", textColor: quiz_textColorPrimary, isLongText: true, isCentered: true,fontSize: 22.0).center(),

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
                        // Navigator.push(context,  MaterialPageRoute(builder: (context) => ExternalImageScreen()));
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
    ReachedonSiteModel reachedonSiteModel = new ReachedonSiteModel();
    reachedonSiteModel.reachedonsite = true;


    if( widget.addPropertyInspectionModel.questionareModel == null){
      widget.addPropertyInspectionModel.questionareModel = new PropertyInspectionQuestionareModel();
    }
    widget.addPropertyInspectionModel.questionareModel.reachedonSiteModel = reachedonSiteModel;

    FirebaseService firebaseService = new FirebaseService();
    await firebaseService.updateOnSiteProperty( widget.addPropertyInspectionModel.inspectionId,widget.addPropertyInspectionModel.questionareModel);

    widget. callback(1);
  }

}
