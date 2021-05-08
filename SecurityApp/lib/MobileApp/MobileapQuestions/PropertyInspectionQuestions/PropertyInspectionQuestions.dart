import 'package:Metropolitane/MobileApp/MobileapQuestions/PropertyInspectionQuestions/Questions/SpecialInstructionsScreen.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/PropertyInspectionQuestions/Questions/AnyDamageToProperty.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/PropertyInspectionQuestions/Questions/AnyDamageToPropertyPic.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/PropertyInspectionQuestions/Questions/AnyDrugUseOutside.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/PropertyInspectionQuestions/Questions/AnyGraffitiNeedRemoval.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/PropertyInspectionQuestions/Questions/AnyHealthAndSafetyIssues.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/PropertyInspectionQuestions/Questions/AnyIntrudersOutside.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/PropertyInspectionQuestions/Questions/AnyWaterLeaking.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/PropertyInspectionQuestions/Questions/AnyWorkerOutside.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/PropertyInspectionQuestions/Questions/ElectricMeterPicture.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/PropertyInspectionQuestions/Questions/ElectricMeterPresent.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/PropertyInspectionQuestions/Questions/ExternalImageScreen.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/PropertyInspectionQuestions/Questions/GasMeterPicture.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/PropertyInspectionQuestions/Questions/GasMeterPresent.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/PropertyInspectionQuestions/Questions/HaveKeysOrCodeScreen.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/PropertyInspectionQuestions/Questions/IsBuildingHasAlarm.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/PropertyInspectionQuestions/Questions/IsBuildingSecure.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/PropertyInspectionQuestions/Questions/JobCompleted.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/PropertyInspectionQuestions/Questions/OnSiteScreen.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/PropertyInspectionQuestions/Questions/OnTheWayScreen.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/PropertyInspectionQuestions/Questions/Take2ndInternalPicture.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/PropertyInspectionQuestions/Questions/Take3rdInternalPicture.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/PropertyInspectionQuestions/Questions/Take4thInternalPicture.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/PropertyInspectionQuestions/Questions/Take5thInternalPicture.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/PropertyInspectionQuestions/Questions/TakeInternalPictures.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/PropertyInspectionQuestions/Questions/WaterMeterPicture.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/PropertyInspectionQuestions/Questions/WaterMeterPresent.dart';
import 'package:Metropolitane/model/AddPropertyInspectionModel.dart';
import 'package:flutter/material.dart';

typedef MyCallbackToback(int i);
typedef MyCustomCallbackToback(int i);

class PropertyInspectionQuestions extends StatefulWidget {
  AddPropertyInspectionModel addPropertyInspectionModel;

  PropertyInspectionQuestions(this.addPropertyInspectionModel);

  @override
  _PropertyInspectionQuestionsState createState() =>
      _PropertyInspectionQuestionsState();
}

class _PropertyInspectionQuestionsState
    extends State<PropertyInspectionQuestions> {
  int currentpage = 0;

  List<Widget> list = [];

  @override
  void initState() {
    list.add(OnWayScreen(widget.addPropertyInspectionModel, MoveNext));
    list.add(OnSiteScreen(widget.addPropertyInspectionModel, MoveNext));
    list.add(ExternalImageScreen(widget.addPropertyInspectionModel, MoveNext));
    list.add(HaveKeysOrCodeScreen(widget.addPropertyInspectionModel, MoveNext));
    list.add(IsBuildingSecure(widget.addPropertyInspectionModel, MoveNext));
    list.add(IsBuildingHasAlarm(widget.addPropertyInspectionModel, MoveNext));
    list.add(AnyWaterLeaking(widget.addPropertyInspectionModel, MoveNext));
    list.add(ElectricMeterPresent(widget.addPropertyInspectionModel, MoveNext));
    list.add(ElectricMeterPicture(widget.addPropertyInspectionModel, MoveNext));
    list.add(GasMeterPresent(widget.addPropertyInspectionModel, MoveNext));
    list.add(GasMeterPicture(widget.addPropertyInspectionModel, MoveNext));
    list.add(WaterMeterPresent(widget.addPropertyInspectionModel, MoveNext));
    list.add(WaterMeterPicture(widget.addPropertyInspectionModel, MoveNext));
    list.add(AnyDamageToProperty(widget.addPropertyInspectionModel, MoveNext));
    list.add(
        AnyDamageToPropertyPic(widget.addPropertyInspectionModel, MoveNext));
    list.add(AnyIntrudersOutside(widget.addPropertyInspectionModel, MoveNext));
    list.add(AnyWorkerOutside(widget.addPropertyInspectionModel, MoveNext));
    list.add(
        AnyGraffitiNeedRemoval(widget.addPropertyInspectionModel, MoveNext));
    list.add(AnyDrugUseOutside(widget.addPropertyInspectionModel, MoveNext));
    list.add(
        AnyHealthAndSafetyIssues(widget.addPropertyInspectionModel, MoveNext));
    list.add(TakeInternalPictures(widget.addPropertyInspectionModel, MoveNext));
    list.add(
        Take2ndInternalPicture(widget.addPropertyInspectionModel, MoveNext));
    list.add(
        Take3rdInternalPicture(widget.addPropertyInspectionModel, MoveNext));
    list.add(
        Take4thInternalPicture(widget.addPropertyInspectionModel, MoveNext));
    list.add(
        Take5thInternalPicture(widget.addPropertyInspectionModel, MoveNext));
    list.add(
        SpecialInstructionScreen(widget.addPropertyInspectionModel, MoveNext));
    //   list.add(JobCompleted(widget.addPropertyInspectionModel),MoveNext);

    if (widget.addPropertyInspectionModel.questionareModel == null) {
      currentpage = 0;
    } else {
      var questionmodel = widget.addPropertyInspectionModel.questionareModel;

      if (questionmodel.onwayModel != null) {
        currentpage = 1;
      }

      if (questionmodel.reachedonSiteModel != null) {
        currentpage = 2;
      }

      if (questionmodel.externalImageScreenModel != null) {
        currentpage = 3;
      }
      if (questionmodel.havekeys != null) {
        currentpage = 4;
      }
      if (questionmodel.isbuildingsecure != null) {
        currentpage = 5;
      }
      if (questionmodel.isbuildinghasalarm != null) {
        currentpage = 6;
      }
      if (questionmodel.anyWaterLeaking != null) {
        currentpage = 7;
      }
      if (questionmodel.electricMeterPresent != null) {
        currentpage = 8;
      }
      if (questionmodel.electricMeterPictureModel != null) {
        currentpage = 9;
      }
      if (questionmodel.gasMeterPresent != null) {
        currentpage = 10;
      }
      if (questionmodel.gasMeterPictureModel != null) {
        currentpage = 11;
      }
      if (questionmodel.waterMeterPresent != null) {
        currentpage = 12;
      }
      if (questionmodel.waterMeterPictureModel != null) {
        currentpage = 13;
      }
      if (questionmodel.anyDamageToProperty != null) {
        currentpage = 14;
      }
      if (questionmodel.anyDamageToPropertyPicModel != null) {
        currentpage = 15;
      }
      if (questionmodel.AnyIntrudersOutside != null) {
        currentpage = 16;
      }
      if (questionmodel.AnyWorkerOutside != null) {
        currentpage = 17;
      }
      if (questionmodel.AnyGraffitiNeedRemoval != null) {
        currentpage = 18;
      }
      if (questionmodel.AnyDrugUseOutside != null) {
        currentpage = 19;
      }
      if (questionmodel.AnyHealthAndSafetyIssues != null) {
        currentpage = 20;
      }
      if (questionmodel.take1stInternalPicturesModel != null) {
        currentpage = 21;
      }
      if (questionmodel.take2ndInternalPictureModel != null) {
        currentpage = 22;
      }
      if (questionmodel.take3rdInternalPictureModel != null) {
        currentpage = 23;
      }
      if (questionmodel.take4thInternalPictureModel != null) {
        currentpage = 24;
      }
      if (questionmodel.take5thInternalPictureModel != null) {
        currentpage = 25;
      }
      if (questionmodel.SpecificInstructions != null) {
        currentpage = 26;
      }
      if (questionmodel.jobCompletedModel != null) {
        currentpage = 27;
      }
    }

    super.initState();
  }

  void MoveNext(int i) {
    if (currentpage < (list.length - 1)) {
      setState(() {
        currentpage++;
      });
    } else {
      {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back, color: Colors.black54),
      //     onPressed: () => Navigator.of(context).pop(),
      //   ),
      //   title: Text("Survey",style: TextStyle(color: Colors.black54),),
      //   centerTitle: true,
      // ),
      body: Column(
        children: [
          Expanded(child: list[currentpage]),
        ],
      ),
    );
  }
}
