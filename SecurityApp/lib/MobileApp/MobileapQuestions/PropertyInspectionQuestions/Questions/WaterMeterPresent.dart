
import 'package:Metropolitane/FirebaseService/FirebaseService.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/utils/QuizColors.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/utils/QuizStrings.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/utils/QuizWidget.dart';
import 'package:Metropolitane/model/AddPropertyInspectionModel.dart';
import 'package:Metropolitane/model/PropertyInspectionQuestionareModel.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:progress_indicator_button/progress_button.dart';

import 'package:Metropolitane/MobileApp/MobileapQuestions/PropertyInspectionQuestions/Questions/AnyDamageToProperty.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/PropertyInspectionQuestions/Questions/WaterMeterPicture.dart';

import '../PropertyInspectionQuestions.dart';

class WaterMeterPresent extends StatefulWidget {

  final MyCallbackToback myCallbackToback;
  AddPropertyInspectionModel addPropertyInspectionModel;

  WaterMeterPresent(this.addPropertyInspectionModel,this.myCallbackToback);



  @override
  _WaterMeterPresentState createState() => _WaterMeterPresentState();
}

class _WaterMeterPresentState extends State<WaterMeterPresent> {

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
                text("Is there any water meter?",
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
                        //   if(_singleValue=="Yes"){
                      //     Navigator.push(context, MaterialPageRoute(builder: (context) => WaterMeterPicture()));
                      //   }else
                      //   Navigator.push(context,  MaterialPageRoute(builder: (context) => AnyDamageToProperty()));
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

    if (widget.addPropertyInspectionModel.questionareModel == null) {
      widget.addPropertyInspectionModel.questionareModel = new PropertyInspectionQuestionareModel();
    }

    widget.addPropertyInspectionModel.questionareModel.waterMeterPresent = istrue;

    FirebaseService firebaseService = new FirebaseService();
    await firebaseService.WaterMeterPresentProperty(
        widget.addPropertyInspectionModel.inspectionId, widget.addPropertyInspectionModel.questionareModel);

    if (_singleValue == "Yes") {
      widget.myCallbackToback(1);
    } else {
      widget.myCallbackToback(2);
    }

  }



}
